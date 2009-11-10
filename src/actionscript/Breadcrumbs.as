package
{
	public class Breadcrumbs
	{
		private var _a : Array;
		
		public function Breadcrumbs()
		{
			_a = new Array();
		}
		
		
		
		
		public function add( o : Object ) : void {
			
			_a.push( o );
		}

	}
}