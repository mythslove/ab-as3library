package com.ab.apps.appgenerics.settings
{
	///  flash
	import com.ab.apps.appgenerics.core.COREApi;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/// ab
	//import com.ab.apps.appgenerics.settings.*
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.events.CentralEventSystem;
	
	public class XMLSettings 
	{
		private static var __singleton:XMLSettings
		private var _data:XML;
		private var applicationSettings:Dictionary;
		private var xmlLoader:URLLoader;
		
		public function XMLSettings()
		{
			setSingleton();
			
			load("settings/settings.xml");
		}
		
		private function load(source:String):void
		{
			xmlLoader = new URLLoader();
			
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoader_CompleteHandler);
			
			xmlLoader.load(new URLRequest(source));
		}
		
		private function xmlLoader_CompleteHandler(e:Event):void 
		{
			_data = new XML(e.target.data);
			_data.ignoreWhitespace = true;
			
			parseXMLData(_data);
		}
		
		private function parseXMLData(value:XML):void
		{
			applicationSettings = new Dictionary();
			
			for each (var property:XML in value..property)
			{
				var applicationSettingName:String  = property.@id;
				var applicationSettingValue:String = property.@value;
				
				applicationSettings[applicationSettingName] = applicationSettingValue;
			}
			
			COREApi.dispatchEvent(new AppEvent(AppEvent.LOADED_SETTINGS, ""));
		}
		
		public function settingValue(id:String):*
		{
			switch (applicationSettings[id]) 
			{
				case "true":
					return true;
				break;
				case "false":
					return false;
				break;
				case null:
					return null;
				break;
				default:
					return applicationSettings[id];
				break;
			}
			return ;
		}
		
		public static function setting(id:String):*
		{
			if (__singleton == null) 
			{ 
				trace("XMLSettings ::: SINGLETON DOES NOT EXIST") 
			}
			else
			{
				return __singleton.settingValue(id);
			}
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