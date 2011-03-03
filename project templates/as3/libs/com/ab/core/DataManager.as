package com.ab.core
{
	/**
	* @author ABº
	* 
	*					  |//
	*			   		 (o o)
	*	+----------oOO----)_(--------------------------------+
	*	|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
	*	|~~~~~~~This class manages all application data~~~~~~|
	*	|~~~~~~~~and provides data collection methods~~~~~~~~|
	*	|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
	*	+-----------------------oOO--------------------------+
    * 	                |__|__|
    *                    || ||
    *                   ooO Ooo
	* 
	*/
	
	import com.ab.events.AppEvent;
	//import com.edigma.services.ServerCommunication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import gs.dataTransfer.XMLManager;
	import com.ab.events.CentralEventSystem;
	import org.casalib.util.StageReference;
	
	public class DataManager extends Object
	{
		/// singleton
		private static var __singleton:DataManager = new DataManager();
		
		/// paths
		private var _xml_path:String="";
		private var _main_xml_file:String="";
		private var _amf_gateway:String="";
		
		/// private
		private var _main_xml_data:XML = new XML(); 
		private var _amfresults_num:int = 0;
		
		/// xmldatagetter instance
		public function DataManager()
		{
			
		}
		
		/// getters / setters
		public function get main_xml_data():* 					{ return _main_xml_data; };
		public function set main_xml_data(value:*):void  		{ _main_xml_data = value; };
		
		public function get xml_path():String 					{ return _xml_path;  }
		public function set xml_path(value:String):void  		{ _xml_path = value; }
		
		public function get main_xml_file():String 				{ return _main_xml_file;  }
		public function set main_xml_file(value:String):void  	
		{ 
			_main_xml_file = value;
			
			if (_xml_path != "")  { getMainXMLData(); };
		}
		
		public function getMainXMLData(path:String="", file:String=""):void
		{
			_main_xml_file 	= file;
			_xml_path 		= path;
			
			COREApi.getXMLdata(path + _main_xml_file, onXMLDataReceived);
		}
		
		private function onXMLDataReceived(e:XML):void 
		{
			trace ("DataManager ::: onXMLDataReceived()"); 
			
			var xmlData:XML = new XML(e); /// assuming root node is named "data"
			
			_main_xml_data = xmlData;
			
			COREApi.dispatchEvent(new AppEvent(AppEvent.LOADED_DATA, true));
		}
		
		public function getAMFData(cat:String):void
		{
			/// insert AMF requests here
			//ServerCommunication.singleton.listarRequest(onAMFImagesOnlyDataReceived, _CATIMG, 1);
		}
		
		private function onAMFDataReceived(o:Object):void 
		{
			/// AMF results handling here
			//trace ("DataManager ::: onAMFDataReceived");
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON 
		public static function get singleton():DataManager
		{
			if (__singleton == null) { throw new Error("DataManager ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)") }; return __singleton;
		}
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
	}
}