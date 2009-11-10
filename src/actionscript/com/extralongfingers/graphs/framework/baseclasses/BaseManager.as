package com.extralongfingers.graphs.framework.baseclasses
{
	import com.extralongfingers.graphs.framework.interfaces.IManager;

	public class BaseManager implements IManager
	{
		protected static var _calledGetInstance : Boolean = false;
		
		public function BaseManager()
		{
		}
		
	}
}
