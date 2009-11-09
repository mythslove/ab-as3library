package
{
	/**
	* @author ABº
	* 
	*					  |//
	*			   		 (o o)
	*	+----------oOO----(_)------------------+
	*	|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
	*	|~~~~~~~~~~~~ ¤   ABº   ¤ ~~~~~~~~~~~~~|
	*	|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
	*	+---------------------oOO--------------+
    * 	               |__|__|
    *                   || ||
    *                  ooO Ooo
	* 
	* This class manages all application data collected from the XML
	* and provides data collection methods for the objects
	*/
	
	import CORE;
	import com.edigma.web.EdigmaCore;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import gs.dataTransfer.XMLManager;
	
	public class DataManager extends Sprite
	{
		/// public
		public static var __singleton:DataManager;
		
		/// private
		//private var _data:Object
		private var _data:XML
		private var _root:CORE;
		
		public function DataManager(root:CORE)
		{
			setSingleton();
			
			_root = root;
			
			initVars()
		}
		
		/// getters / setters
		public function get data():XML 				{ return _data; };
		public function set data(value:XML):void  	{ _data = value; };
		
		//public function start() 						{ getData(); };
		
		private function initVars():void 				{ _data = new XML() };
		
		public function getData():void 				
		{
			var xmlLoader:URLLoader = new URLLoader();
			var xmlData:XML = new XML();
			
			xmlLoader.addEventListener(Event.COMPLETE, onDataReceived);
			
			xmlLoader.load(new URLRequest(EdigmaCore.getSingleton().CONTENTS_XML_PATH + "data.xml"));
		}
		private function onDataReceived(e:Event):void 
		{
			var xmlData:XML = new XML(e.target.data);
			
			_data = xmlData;
			
			_root.loadedData = true;
			
			//trace(_data.pergunta[0].property.(attribute('id') == "grupo").text());
			//trace(xmlData..(attribute('id') == "grupo").text());
			//
			//for each(var p:String in xmlData.pergunta.property.(@id == "pergunta").text())
			//{
			//	trace(p);
			//}*/
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		private function setSingleton():void
		{
			if (__singleton != null)  { throw new Error("DataManager ::: SINGLETON REPLICATION ATTEMPTED") }; __singleton = this;
		}
		public static function getSingleton():DataManager
		{
			if (__singleton == null) { throw new Error("DataManager ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)") }; return __singleton;
		}
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
	}
}