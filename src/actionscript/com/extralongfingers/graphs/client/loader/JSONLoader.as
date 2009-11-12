                                                        


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
		
		
	   
		private var _url:String;
		private var _dispatcher:EventDispatcher;
	    private var _jsonData:String;  
	
		function JSONLoader()
		{      
			 log( "")
			
			_dispatcher = new EventDispatcher();
			
		   
			
		} 
		
		public function submitRequest() : void
		{  
			log( "submitRequest()")
			
			if(_url)
			{
				var urlLoader : URLLoader = new URLLoader( new URLRequest( _url ) 			);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioError 	);
			   	urlLoader.addEventListener(Event.COMPLETE, complete 		); 
			}   	
		} 
		
		
		private function ioError( e : IOErrorEvent )  : void
		{ 
			log( "ioError()")
			
			_dispatcher.dispatchEvent( new Event(REQUEST_ERROR) );  
		}   
		
		private function complete( e : Event ) : void
		{   
			log( "complete()")
			
			_jsonData = e.target.data as String;
			
			_dispatcher.dispatchEvent( new Event(REQUEST_COMPLETE) );  
			
			
			
		}   
		
		
	    public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
	    {     
			log( "addEventlistener() "+type)
			_dispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		public function set url( value : String ) : void { _url = value; }  
	  	public function get jsonData():String
	  	{
	  		return _jsonData;
	  	}	
		private function log( msg : String):void
		{                                 
			trace( "JSONLoader."+msg);
			
		}
 	}
	
}
 