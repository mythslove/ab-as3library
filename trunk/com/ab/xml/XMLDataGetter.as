package com.ab.xml
{
	/**
	 * A simple class to get the data from a XML file
	* @author ABº
	*/
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class XMLDataGetter 
	{
		private var return_function:Function;
		
		/// public
		private static var __singleton:XMLDataGetter;
		
		public function XMLDataGetter()  { setSingleton(); };
		
		public function getDataXML(return_func:Function, xml_file_path:String=""):void
		{
			//trace ("XMLDataGetter ::: xml_file_path = " + xml_file_path ); 
			//trace ("XMLDataGetter ::: return_func = " + return_func ); 
			
			if (xml_file_path != "") 
			{
				return_function 			= return_func;
				
				var xmlLoader:URLLoader 	= new URLLoader();
				var header:URLRequestHeader = new URLRequestHeader("pragma", "no-cache");
				var request:URLRequest  	= new URLRequest(xml_file_path);
				request.data 				= new URLVariables("name=lalala");
				request.method 				= URLRequestMethod.POST;
				
				xmlLoader.load(new URLRequest(xml_file_path));
				
				xmlLoader.addEventListener(Event.COMPLETE, onXMLDataReceived, false, 0, true);
			}
			else
			{
				trace("XMLDataGetter ::: XML FILE HAS NOT BEEN SPECIFIED");
			}
		}
		
		private function onXMLDataReceived(e:Event):void 
		{
			//trace ("XMLDataGetter ::: onXMLDataReceived()"); 
			
			var xmlData:XML = new XML(e.target.data);
			
			return_function(xmlData);
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		private function setSingleton():void
		{
			if (__singleton != null)  { return; }; __singleton = this; //throw new Error("XMLDataGetter ::: SINGLETON REPLICATION ATTEMPTED")
		}
		public static function get singleton():XMLDataGetter
		{
			if (__singleton == null) { __singleton = new XMLDataGetter() }
			
			return __singleton;
		}
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}
	
}