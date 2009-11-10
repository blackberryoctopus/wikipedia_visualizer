package com.extralongfingers.graphs.framework.baseclasses
{
	import com.extralongfingers.graphs.framework.interfaces.IController;
	
	import flash.events.EventDispatcher;

	public class BaseController implements IController
	{
		protected var _view : *;
		
		public function BaseController()
		{
			super();
		}	
		
		public function init ( args : Object ) : void
		{	
		}
		
		public function set set_ui ( view : * ) : void { _view = view; }
	}
}
