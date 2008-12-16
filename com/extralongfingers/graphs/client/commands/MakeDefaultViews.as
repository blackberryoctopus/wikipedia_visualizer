package com.extralongfingers.graphs.client.commands
{
	import com.extralongfingers.graphs.framework.baseclasses.BaseCommand;
	
	import flash.display.DisplayObject;

	public class MakeDefaultViews extends BaseCommand
	{
		
		private var _d : DisplayObject;
		
		public function MakeDefaultViews()
		{
			super();
		}
		
		override public function execute():void
		{
			txt = new TextField();
			txt.x = 400;
			addChild( txt );
		}
		
		
		public function set baseClip( d : DisplayObject ) { _d = d; }
	}
}