package com.extralongfingers.graphs.client.model
{
	import flare.vis.data.Data;
	
	public class DataModel
	{
		private static var _i : DataModel;
		private var _d : Data;
		
		public function DataModel( p : Private){}
		
		public static function getInstance() : DataModel {
			if( _i == null )  _i = new DataModel( new Private() );
			return _i;
		}
		
		public function getData() : Data {
			return _d;
		}
		
		public function setData( d: Data ) : void {
			_d =d;
		}

	}
}

internal class Private{}