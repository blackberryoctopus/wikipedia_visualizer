package com.extralongfingers.graphs.framework.baseclasses
{
	import com.extralongfingers.graphs.framework.interfaces.IData;
	
	import mx.utils.ObjectProxy;
	
	public class BaseData extends ObjectProxy implements IDomainData
	{
		protected var _data : *;
		
		public function get get_data ( ) : * { return _data; }
		public function set set_data ( data : * ) : void { _data = data; }		
	}
}
