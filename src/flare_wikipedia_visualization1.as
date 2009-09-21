package {
	import com.adobe.serialization.json.JSON;
	
	import flare.display.TextSprite;
	import flare.query.methods.eq;
	import flare.util.Shapes;
	import flare.vis.Visualization;
	import flare.vis.controls.ClickControl;
	import flare.vis.controls.DragControl;
	import flare.vis.controls.HoverControl;
	import flare.vis.data.Data;
	import flare.vis.data.DataSprite;
	import flare.vis.data.NodeSprite;
	import flare.vis.data.Tree;
	import flare.vis.events.SelectionEvent;
	import flare.vis.operator.label.RadialLabeler;
	import flare.vis.operator.layout.BundledEdgeRouter;
	import flare.vis.operator.layout.CircleLayout;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;



	[SWF(width="1440",height="900",backgroundColor="#FFFFFF",frameRate="30")]

	public class flare_wikipedia_visualization1 extends Sprite
	{
		
		[Embed(source="Arial.ttf", fontName="Arial")]
		private static var _font	: Class;
		private var defaultTextSize : Number 		= 12;
		private var _fmt			: TextFormat 	= new TextFormat("Arial", defaultTextSize);
		
		private var vis 			: Visualization;
		
		private var t 				: TextField;
		private var tUpdate 		: TextField;
		
		private var _term 			: String 		= "visualization";
		private var url 			: String 		= "http://localhost:8887/cgi-bin/wikilink?q="+_term;
		private var _b 				: Rectangle 	= new Rectangle( 0, 0, 1024, 600 );
		private var _history		: Breadcrumbs;
		private var hs				: HistorySprite;
		
	
		public function flare_wikipedia_visualization1()
		{
			addTextField();
			
			var l : URLLoader = new URLLoader( new URLRequest( url ) );
			l.addEventListener(	IOErrorEvent.IO_ERROR, 	ioerror );
			l.addEventListener(	Event.COMPLETE, 		complete );
		}
		
		private function ioerror( e : IOErrorEvent ) : void { trace( e );}
		
		private function complete( e : Event ) : void
		{
			var s : String 	= e.target.data as String;
			
			var a : Array 	= JSON.decode( s ) as Array;
			
			if( a.length > 140 ) _fmt.size = 10;
			else if ( a.length > 220 ) _fmt.size = 9;
			else if ( a.length > 280 ) _fmt.size = 8;
			else if ( a.length > 300 ) _fmt.size = 7;
			else if ( a.length > 400 ) _fmt.size = 6;
			else if ( a.length > 500 ) _fmt.size = 4;
			else if ( a.length > 600 ) _fmt.size = 3;
			
			
			
			var data : Data = buildData( a );
			visualize( data );
		}
		
		private function visualize( d : Data ) : void
		{
			vis = new Visualization(d );
			
			vis.bounds 	= _b;
			vis.x 		= 150;
			vis.y 		= 50;
		
			var cl : CircleLayout = new CircleLayout("depth", null, true);
			cl.angleWidth = Math.PI*2;
			vis.operators.add( cl );
			
			var ber : BundledEdgeRouter = new BundledEdgeRouter();
			vis.operators.add( ber );
			
			var rl : RadialLabeler = new RadialLabeler(
											function(d:DataSprite):String {	var txt:String = d.data.name; return txt;},
											true, 
											_fmt, 
											eq( "childDegree", 0 )
											);
			
			vis.operators.add(rl);
			
			
			vis.operators.last.textMode = TextSprite.EMBED; // embed fonts!
			
			
			vis.controls.add( new DragControl() );
			
			vis.data.nodes.setProperties(
												{   fillColor:0xabcabcac,
													shape: null, 
													buttonMode: true              // show hand cursor
												}
											);
			vis.data.edges.setProperties	(	{
													lineWidth: 1,
													lineColor: 0xffaa55ff,
													lineAlpha : .6,
													shape : Shapes.CIRCLE,
													mouseEnabled: false          // non-interactive edges
												}
											);
											
											
			addClickControls();
			addHoverControls();
			vis.continuousUpdates = false;
			vis.update().play();
			addChild( vis );
		}
		
		private function addClickControls() : void
		{
			var cc : ClickControl = new ClickControl( NodeSprite, 1, _fnClick, _fnUnClick );
			vis.controls.add( cc );
		}
		
		private function addHoverControls() : void
		{
			var hov : HoverControl = new HoverControl( NodeSprite, HoverControl.DONT_MOVE, nodeOver, nodeRollOut );
			vis.controls.add( hov );
		}
		
		
		private function nodeOver( e : SelectionEvent ) : void
		{
			e.node.props.label.color = 0xffaa55ff;
			e.node.props.label.bold = true;
			e.node.props.label.size = 14;
			tUpdate.text = e.node.data.name;
			
		}
		
		private function nodeRollOut( e : SelectionEvent ) : void
		{
			var node : NodeSprite = e.node;
			node.props.label.color =0;
			node.props.label.size = _fmt.size;
			node.props.label.bold = false;
			
		}
		private function _fnUnClick( e  : SelectionEvent ) : void
		{
			
		}
		
		
		
		private function _fnClick( e : SelectionEvent ) : void 
		{
			
			_term = String(e.node.data.name);
			
			hs.addTerm( _term );
			
			
			
			t.text = _term;
			t.width = t.textWidth * 1.2;
			
			//This clear functionality should be made into a command to reduce redundancy.
				vis.data.clear();
				vis.continuousUpdates = false;
				removeChild( vis );
				
				var wikiurl : String = String( e.node.data.url );
				
				
				
					
				
				var l : URLLoader = new URLLoader( new URLRequest( url ) );
				l.addEventListener(IOErrorEvent.IO_ERROR, ioerror );
				l.addEventListener(Event.COMPLETE, complete );
		}
		
		
		
		private function addTextField() : void
		{
			var tLink : TextField 	= new TextField();
			tLink.text 				= "Wikipedia Article";
			tLink.width 			= tLink.textWidth * 1.1;
			tLink.height 			= tLink.textHeight * 1.1;
			tLink.textColor 		= 0x0000ff;
			tLink.y 				= 100;
			tLink.x 				= 50;
			tLink.addEventListener( MouseEvent.CLICK, textClick );
				
					
			addChild( tLink );
			
			
			t = new TextField();
			t.border = true;
			t.borderColor = 0x00000000;
			
			t.addEventListener( KeyboardEvent.KEY_DOWN, keyDown );
			
			t.type = TextFieldType.INPUT;
			
			t.x = 50;
			t.y = 50;
			
			
			t.text = _term;
			t.width = 200;
			t.height = 15;
			
			
			tUpdate = new TextField();
			tUpdate.x = 1200;
			tUpdate.y = 50;
			addChild( tUpdate );
			
			
			hs = new HistorySprite();
			addChild( hs );
			hs.x = 1200;
			hs.y = tUpdate.y + 200;
			hs.width = 200;
			hs.height = stage.height - tUpdate.y - tUpdate.height;
			hs.addTerm( _term );
			
			addChild( t );
				
		}
		
		private function textClick( e : MouseEvent ) : void
		{
			var wikiUrl : String 		= "http://www.wikipedia.org/wiki/"+_term;
			var ur 		: URLRequest 	= new URLRequest( wikiUrl );
			navigateToURL( ur, "_blank" ); 
		}
		
		
		private function keyDown( e : KeyboardEvent ) : void
		{
			if( e.charCode == Keyboard.ENTER ) 
			{
				_term = TextField( e.target ).text;
				
				hs.clearTerms();
				hs.addTerm( _term );
				
				vis.data.clear();
				vis.continuousUpdates = false;
				removeChild( vis );
				
				url = "http://devel.nabbr.com/cgi-bin/wikilink?q="+_term;
				
				var l : URLLoader = new URLLoader( new URLRequest( url ) );
				l.addEventListener(IOErrorEvent.IO_ERROR, ioerror );
				l.addEventListener(Event.COMPLETE, complete );
			}
		}
		
		
		
		private function buildData( tuples : Array ) : Data
		{
			
			var d : Data 	= new Data();
			var t : Tree 	= new Tree();
			t.root 			= d.addNode( { name : _term, size : 50 } );
			t.root.name  	= _term;
			t.root.setNodeProperties( 
										{   fillColor:0xabcabcac,
											shape: Shapes.CIRCLE, 
											buttonMode: true              
										}
									);
												
			var u : NodeSprite;
			var o : Object;
			tuples.sortOn( "name" );
			
			var _num : Number = 0;
			for each ( o in tuples ) {
				u = d.addNode( { url : o.url, name : o.name, size : 25, depth :( _num < 500 )?1:2 } );
				d.addEdgeFor( t.root, u );
				t.addChild( t.root, u );
				_num++;
			}
			
			d.tree = t;
			return d;
				
		}
		
	}
}
