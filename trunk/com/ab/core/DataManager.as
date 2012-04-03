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
	import com.ab.settings.XMLSettings;
	import com.ab.xml.XMLDataGetter;
	import flash.utils.Dictionary;
	//import com.edigma.services.ServerCommunication;
	
	public class DataManager extends Object
	{
		/// singleton
		private static var __singleton:DataManager = new DataManager();
		
		/// paths
		private var _xml_path:String="";
		private var _main_xml_file:String="";
		private var _amf_gateway:String = "";
		
		private var data_objects:Dictionary = new Dictionary();
		
		/// private
		private var _main_xml_data:XML = new XML(); 
		private var _amfresults_num:int = 0;
		private var multiple_xml_files_load_current:Number;
		private var multiple_xml_files_load_total:int;
		private var init_xml_files_object:XML;
		
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
		
		public function getMainXMLData():void
		{
			COREApi.getXMLdata(_main_xml_file, onXMLDataReceived);
		}
		
		public function getXMLDataEnhanced(xml_path:String, return_func:Function=null, id:String="none"):void
		{
			if (data_objects[id]) 
			{
				return_func(DataManagerDataObject(data_objects[id]).data);
			}
			else
			{
				var data_fetch_process:DataManagerDataProcess = new DataManagerDataProcess(data_objects, "XML", id, xml_path, return_func);
			}
		}
		
		public function getXMLDataObject(id:String):XML
		{
			if (data_objects[id]) 
			{
				return DataManagerDataObject(data_objects[id]).data;
			}
			else
			{
				return null;
				trace("DataManager : getXMLDataObject : ID not found");
			}
		}
		
		public function requestDataObjectData(id:String):Object
		{
			return DataManagerDataObject(data_objects[id]).data;
		}
		
		public function loadXMLFiles(list_file:String):void
		{
			XMLDataGetter.singleton.getDataXML(XMLSettings.setting.XML_PATH + list_file, severalXMLFilesLoadStart);
		}
		
		private function severalXMLFilesLoadStart(o:XML):void 
		{
			trace("DataManager : severalXMLFilesLoadStart");
			init_xml_files_object 			= o;
			multiple_xml_files_load_current = 0;
			multiple_xml_files_load_total 	= init_xml_files_object.items.item.length();
			
			DataManager.singleton.getXMLDataEnhanced(XMLSettings.setting.XML_PATH + init_xml_files_object.items.item[multiple_xml_files_load_current].@name, multipleXMLFilesLoadedHandler, init_xml_files_object.items.item[multiple_xml_files_load_current].@id);
		}
		
		private function multipleXMLFilesLoadedHandler(o:XML):void 
		{
			trace("LOADED ONE XML FILE");
			
			multiple_xml_files_load_current = multiple_xml_files_load_current + 1;
			
			if (multiple_xml_files_load_current < multiple_xml_files_load_total)
			{
				DataManager.singleton.getXMLDataEnhanced(XMLSettings.setting.XML_PATH + init_xml_files_object.items.item[multiple_xml_files_load_current].@name, multipleXMLFilesLoadedHandler, init_xml_files_object.items.item[multiple_xml_files_load_current].@id);
			}
			else
			{
				COREApi.dispatchEvent(new AppEvent(AppEvent.LOADED_DATA, true));
			}
		}
		
		private function onXMLDataReceived(e:XML):void 
		{
			trace ("DataManager ::: onXMLDataReceived()"); 
			
			var xmlData:XML = new XML(e); /// assuming root node is named "data"
			
			_main_xml_data = xmlData;
			
			COREApi.dispatchEvent(new AppEvent(AppEvent.LOADED_DATA, true));
		}
		
		public function getAMFData():void
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