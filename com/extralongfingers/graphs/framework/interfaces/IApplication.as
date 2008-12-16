package com.domain.framework.interfaces
{
	import com.domain.framework.baseclasses.DomainCanvas;
	
	public interface IApplication
	{
		function init ( newapplication : domainApplication, baseForm : DomainCanvas, args : Object ) : void;
		function restart ( ) : void;
	}
}
