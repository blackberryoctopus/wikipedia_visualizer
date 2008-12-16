package com.extralongfingers.graphs.client.model
{
	import flare.vis.Visualization;
	
	public class VisModel
	{
		private static var _i : VisModel ;
		private var _vis : Visualization;
		
		public function VisModel( p : Private)
		{
			_vis = new Visualization( DataModel.getInstance().getData() );
		}
		
		
		public static function getInstance() : VisModel {
			if( _i == null )  _i = new VisModel( new Private() );
			return _i;
		}
		
		
		public function getVisualization() : Visualization {
			return _vis;
		}

	}
}
internal class Private{}