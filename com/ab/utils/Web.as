package com.ab.utils 
{
	/**
	* @author ABº
	* http://blog.antoniobrandao.com/
	*/
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest
	import flash.net.navigateToURL;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class Web 
	{
		
		public static function getURL(url:String, windowtype:String = null):void
        {
            var req:URLRequest = new URLRequest(url);
            
			trace("getURL", url);
			
            try
            {
                navigateToURL(req, windowtype);
            }
            catch (e:Error)
            {
                trace("GetURL failed", e.message);
            }
        }
		
		public static function sendVariables(url:String, variables:URLVariables, onCompleteFunc:Function=null):void
        {
            var request:URLRequest 		= new URLRequest(url); 
			request.method 				= URLRequestMethod.POST; 
			
			request.data 				= variables; 
			
			var loader:URLLoader 		= new URLLoader (request); 
			
			if (onCompleteFunc != null) 
			{
				loader.addEventListener(Event.COMPLETE, onCompleteFunc); 
			}
			
			loader.addEventListener(ErrorEvent.ERROR, onError); 
			
			function onError():void { trace("sendVariables ERROR") };
			
			loader.dataFormat 			= URLLoaderDataFormat.VARIABLES; 
			loader.load(request);
        }
	}	
}