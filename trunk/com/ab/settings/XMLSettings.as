package com.ab.settings
{
	///  flash
	import com.ab.core.COREApi;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	/// ab
	import com.ab.events.AppEvent;
	import com.ab.events.CentralEventSystem;
	
	dynamic public class XMLSettings extends Proxy
	{
		private static var __singleton:XMLSettings
		private var _data:XML;
		private var applicationSettings:Dictionary;
		private var xmlLoader:URLLoader;
		
		public function XMLSettings()
		{
			setSingleton();
			
			load("settings/banner_settings.xml");
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
		
		/// /////////////////////////////////////////////////////////////////////// PROXY
		/// /////////////////////////////////////////////////////////////////////// PROXY
		
		override flash_proxy function getProperty(name:*):*
		{
			return __singleton.settingValue(name);
		}
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			applicationSettings[name] = value;
		}
		
		override flash_proxy function callProperty(name:*, ... rest):*
		{
			var _item:Object = new Object();
			
			return _item[name].apply(_item, rest);
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null)  { throw new Error("XMLSettings ::: SINGLETON REPLICATION ATTEMPTED") }
			__singleton = this
		}
		
		public static function get setting():XMLSettings
		{
			if (__singleton == null) { __singleton = new XMLSettings() }
			return __singleton;
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
	}
}