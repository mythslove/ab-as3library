package com.edigma.web 
{
	/**
	* @author ABº
	* 
	* @EDIGMACOM
	*/
	
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.events.CentralEventSystem;
	import flash.events.Event;
	import com.edigma.xml.*;
	
	public class EdigmaCore 
	{
		private static var __singleton:EdigmaCore
		
		public var CONTENTS_PATH:String;
		public var INACTIVITY_TIME:int;
		public var XML_PATH:String;
		
		/// project specific
		public var APPLICATION_CLASS:Class;
		public var FOTO_SLIDE_DURATION:Number;
		
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
			/// SETTINGS XML
			//APPLICATION_CLASS		= XMLProperties.properties.APPLICATION_CLASS as Class;
			
			//var test = Class(APPLICATION_CLASS)
			
			//import test;
			
			XML_PATH 				= XMLProperties.properties.XML_PATH;
			CONTENTS_PATH 			= XMLProperties.properties.CONTENTS_PATH;
			INACTIVITY_TIME 		= XMLProperties.properties.INACTIVITY_TIME;
			FOTO_SLIDE_DURATION 	= XMLProperties.properties.FOTO_SLIDE_DURATION;
			
			CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.LOADED_SETTINGS, true));
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