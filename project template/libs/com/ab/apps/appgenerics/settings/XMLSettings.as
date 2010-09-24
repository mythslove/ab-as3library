package com.ab.apps.appgenerics.settings
{
	///  flash
	import flash.events.Event;
	/// ab
	import com.ab.apps.appgenerics.settings.*
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.events.CentralEventSystem;
	
	public class XMLSettings 
	{
		private static var __singleton:XMLSettings
		
		/// generic
		public var FULL_SCREEN:Boolean;
		public var DEBUG_MODE:Boolean;
		public var CONTENTS_PATH:String;
		public var INACTIVITY_TIME:int;
		public var XML_PATH:String;
		public var MAIN_XML_FILE:String;
		
		/// project specific
		//public var TITLE_ES:String;
		//public var TITLE_EN:String;
		//public var TITLE_PT:String;
		
		public function XMLSettings()
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
			//TITLE_ES 					= XMLProperties.properties.TITLE_ES;
			//TITLE_EN 					= XMLProperties.properties.TITLE_EN;
			//TITLE_PT 					= XMLProperties.properties.TITLE_PT;
			
			/// generic
			if (XMLProperties.properties.DEBUG_MODE == "true")   { DEBUG_MODE = true;  };
			if (XMLProperties.properties.DEBUG_MODE == "false")  { DEBUG_MODE = false; }
			
			XML_PATH 					= XMLProperties.properties.XML_PATH;
			MAIN_XML_FILE 				= XMLProperties.properties.MAIN_XML_FILE;
			CONTENTS_PATH 				= XMLProperties.properties.CONTENTS_PATH;
			INACTIVITY_TIME 			= XMLProperties.properties.INACTIVITY_TIME;
			FULL_SCREEN 				= XMLProperties.properties.FULL_SCREEN;
			
			CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.LOADED_SETTINGS, true));
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null)  { throw new Error("XMLSettings ::: SINGLETON REPLICATION ATTEMPTED") }
			__singleton = this
		}
		
		public static function get singleton():XMLSettings
		{
			if (__singleton == null) { throw new Error("XMLSettings ::: SINGLETON DOES NOT EXIST") }
			return __singleton;
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
	}
}