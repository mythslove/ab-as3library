package com.ab.utils 
{
	/**
	* @author ABº
	* http://blog.antoniobrandao.com/
	*/
	
	import flash.net.URLRequest
	import flash.net.navigateToURL;
	
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
	}	
}