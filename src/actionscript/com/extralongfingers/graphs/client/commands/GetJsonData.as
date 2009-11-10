package com.extralongfingers.graphs.client.commands
{
	import com.extralongfingers.graphs.client.events.CommandEvent;
	import com.extralongfingers.graphs.framework.baseclasses.BaseCommand;
	import com.extralongfingers.graphs.framework.interfaces.ICommand;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class GetJsonData extends BaseCommand implements ICommand
	{
		
		private var _url : String;
		
		public function GetJsonData()
		{
		}

		override public function execute():void
		{
			
			var ul : URLLoader = new URLLoader( new URLRequest( _url ) );
			ul.addEventListener( Event.COMPLETE, dataLoadComplete );
			ul.addEventListener( IOErrorEvent.IO_ERROR, ioerror );
			
			
		}
		
		private function dataLoadComplete( e : Event ) : void 
		{
			var ce : CommandEvent = new CommandEvent( CommandEvent.COMMAND_RESULT );
			ce.setData( e.target );
			
			this.dispatchEvent( ce );
		}
		
		
		private function ioerror( e : IOErrorEvent )  : void {}
		
		
		
		
		public function set url( s : String ) : void { _url = s; }
		
	}
}