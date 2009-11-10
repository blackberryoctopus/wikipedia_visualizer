package com.nabbr.thememanager.client.events
{
	import flash.events.Event;

	public class ModelEvent extends Event
	{
		public static var MODEL_UPDATE : String = "modelupdate";
	
		
		public function ModelEvent ( type:String )
		{
			super ( type );
		}	
		
		public override function clone ( ) : Event
		{	
			return new ModelEvent ( type );
		}
	}
}
