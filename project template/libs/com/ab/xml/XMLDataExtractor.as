package com.ab.xml
{
	/**
	* @author ABº
	* 
	* Class designed just to get the whole data out of a XML file.
	* 
	* 
	* Required parameters:
	* 
	* . XML File path
	* . Return Function
	* . Root node name
	* 
	*/
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class XMLDataExtractor 
	{
		private var return_function:Function;
		private var root_node_name:String;
		
		/// public
		public static var __singleton:XMLDataExtractor;
		
		public function XMLDataExtractor()  { setSingleton(); };
		
		public function getDataXML(return_func:Function, xml_file:String, _root_node_name:String):void
		{
			trace ("XMLDataExtractor ::: XML File path   = "	+ xml_file );
			trace ("XMLDataExtractor ::: Return Function = " 	+ return_func );
			trace ("XMLDataExtractor ::: Root node name  = " 	+ _root_node_name );
			
			return_function = return_func;
			root_node_name  = _root_node_name;
			
			if (xml_file != "") 
			{
				var xmlData:XML 		= new XML();
				var xmlLoader:URLLoader = new URLLoader();
				
				xmlLoader.load(new URLRequest(xml_file));
				
				xmlLoader.addEventListener(Event.COMPLETE, onXMLDataReceived, false, 0, true);
			}
			else
			{
				trace("XMLDataExtractor ::: XML FILE HAS NOT BEEN SPECIFIED");
			}
		}
		
		private function onXMLDataReceived(e:Event):void 
		{
			//trace ("XMLDataExtractor ::: onXMLDataReceived()"); 
			
			var xmlData:XML = new XML(e.target["root_node_name"]);
			
			return_function(xmlData);
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		private function setSingleton():void
		{
			if (__singleton != null)  { throw new Error("XMLDataExtractor ::: SINGLETON REPLICATION ATTEMPTED") }; __singleton = this;
		}
		public static function get singleton():XMLDataExtractor
		{
			if (__singleton == null) { throw new Error("XMLDataExtractor ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)") }; return __singleton;
		}
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}
	
}