package com.extralongfingers.graphs.framework.baseclasses
{
	import com.extralongfingers.graphs.framework.interfaces.ICommand
	import flash.events.EventDispatcher;

	public class BaseCommand extends EventDispatcher implements ICommand
	{
		public function BaseCommand()
		{
		}

		public function execute():void
		{
		}		
	}
}
