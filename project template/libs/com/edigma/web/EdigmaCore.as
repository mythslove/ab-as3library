package com.edigma.web 
{
	/**
	* @author ABº
	* 
	* @EDIGMACOM
	*/
	
	import com.ab.apps.appgenerics.core.COREApi;
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.events.CentralEventSystem;
	import flash.events.Event;
	import com.edigma.xml.*;
	
	public class EdigmaCore extends Object
	{
		private static var __singleton:EdigmaCore
		
		/// generic
		public var DEBUG_MODE:Boolean;
		public var CONTENTS_PATH:String;
		public var FULL_SCREEN:String;
		public var INACTIVITY_TIME:int;
		public var XML_PATH:String;
		public var MAIN_XML_FILE:String;
		public var USE_MOUSE:Boolean;
		public var DATA_TYPE:String="XML";
		
		/// project specific
		public var APP1_SCREENSHOT:String;
		public var APP2_SCREENSHOT:String;
		
		public function EdigmaCore()
		{
			setSingleton();
			
			load();
		}
		
		private function load():void
		{
			XMLProperties.init("settings/settings.xml", settings_completeHandler);
		}
		
		private function settings_completeHandler(e:Event = null):void 
		{
			// SETTINGS XML
			
			/// project specific
			APP1_SCREENSHOT 			= XMLProperties.properties.APP1SCRENSHOT;
			APP2_SCREENSHOT 			= XMLProperties.properties.APP2SCRENSHOT;
			
			/// generic
			if (XMLProperties.properties.DEBUG_MODE == "true")  { DEBUG_MODE = true;  }
			if (XMLProperties.properties.DEBUG_MODE == "false") { DEBUG_MODE = false; }
			if (XMLProperties.properties.USE_MOUSE  == "true")  { USE_MOUSE  = true;  }
			if (XMLProperties.properties.USE_MOUSE  == "false") { USE_MOUSE  = false; }
			
			XML_PATH 					= XMLProperties.properties.XML_PATH;
			DATA_TYPE 					= XMLProperties.properties.DATA_TYPE;
			MAIN_XML_FILE 				= XMLProperties.properties.MAIN_XML_FILE;
			CONTENTS_PATH 				= XMLProperties.properties.CONTENTS_PATH;
			INACTIVITY_TIME 			= XMLProperties.properties.INACTIVITY_TIME;
			FULL_SCREEN 				= XMLProperties.properties.FULL_SCREEN;
			
			COREApi.dispatchEvent(new AppEvent(AppEvent.LOADED_SETTINGS, true));
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null)  { throw new Error("EdigmaCore ::: SINGLETON REPLICATION ATTEMPTED") }
			__singleton = this
		}
		
		public static function get singleton():EdigmaCore
		{
			if (__singleton == null) { throw new Error("EdigmaCore ::: SINGLETON DOES NOT EXIST") }
			return __singleton;
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
	}
}