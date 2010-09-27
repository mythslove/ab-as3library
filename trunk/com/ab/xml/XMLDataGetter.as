package com.ab.apps.appgenerics.xml
{
	/**
	 * A simple class to get the data from a XML file
	* @author ABº
	*/
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class XMLDataGetter 
	{
		public var root_node_name:String;
		private var return_function:Function;
		
		/// public
		private static var __singleton:XMLDataGetter;
		
		public function XMLDataGetter()  { setSingleton(); };
		
		public function getDataXML(return_func:Function, xml_file_path:String="", root_node_name:String=""):void
		{
			//trace ("XMLDataGetter ::: xml_file_path = " + xml_file_path ); 
			//trace ("XMLDataGetter ::: return_func = " + return_func ); 
			
			if (xml_file_path != "") 
			{
				//if (root_node_name != "") 
				//{
					return_function = return_func;
					this.root_node_name = root_node_name;
					
					var xmlData:XML 		= new XML();
					var xmlLoader:URLLoader = new URLLoader();
					
					xmlLoader.load(new URLRequest(xml_file_path));
					
					xmlLoader.addEventListener(Event.COMPLETE, onXMLDataReceived, false, 0, true);
				//}
				//else
				//{
					//trace("XMLDataGetter ::: XML ROOT NODE NAME HAS NOT BEEN SPECIFIED");
				//}
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
			if (__singleton == null) { throw new Error("XMLDataGetter ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)") }; return __singleton;
		}
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}
	
}