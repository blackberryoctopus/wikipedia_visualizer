                                                        


package com.extralongfingers.graphs.client.loader
{                                                
 
	    
	import  flash.net.URLLoader;
	import flash.net.URLRequest; 
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	
	    
  
	
	
	public class JSONLoader
	{  
	    public static const REQUEST_COMPLETE : String = "requestComplete";
		public static const REQUEST_ERROR : String = "requestError";
		
		
		private var urlLoader : URLLoader;
		private var urlRequest : URLRequest;
		private var _url:String;
		private var _dispatcher:EventDispatcher;
	
		function JSONLoader()
		{    
			_dispatcher = new EventDispatcher();
			
		   
			
		} 
		
		public function submitRequest() : void
		{
			if(_url)
			{
				urlLoader = new URLLoader( new URLRequest( _url ) 			);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioError 	);
			   	urlLoader.addEventListener(Event.COMPLETE, complete 		); 
			}   	
		} 
		
		
		private function ioError( e : IOErrorEvent )  : void
		{
			_dispatcher.dispatchEvent( new Event(REQUEST_ERROR) );
		}   
		
		private function complete( e : Event ) : void
		{
			_dispatcher.dispatchEvent( new Event(REQUEST_COMPLETE) );
			
			
		}
		
		
		public function set url( value : String ) { _url = value; }  
		
	
	
 	}
	
}
 