package com.extralongfingers.graphs.client.events
{
	import flash.events.Event;

	public class CommandEvent extends Event
	{
		private var _d : *;
		public static var COMMAND_RESULT : String = "commandResult";
		
		public function CommandEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		override public function clone()	: Event	{	return new CommandEvent( type );	}
		
		public function setData( d : * ) 	: void 	{ _d =d; 		}
		public function getData() 			: * 	{ return _d; 	}
	}
}
