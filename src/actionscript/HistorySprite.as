package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class HistorySprite extends Sprite
	{
		private var t : TextField;
		private var i : uint = 1;
		
		public function HistorySprite()
		{
			t = new TextField();
			t.text = " Your history of terms : ";
			t.height = 1000;
			
			addChild( t );
			
			
		}
		
		
		public function addTerm( s : String ) : void {
			
			t.appendText( "\n"+i+ " "+s );
			i++;
		}
		
		public function clearTerms() : void {
			t.text = " Your history of terms : ";
			i=1;
			
		}

	}
}