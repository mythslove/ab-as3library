package com.ab.web 
{
	/**
	* @author ABº
	*/
	
	import ecomuseu.CORE;
	import flash.events.Event;
	//import com.ab.xml.*;
	import com.edigma.xml.*;
	
	public class ABCore 
	{
		private static var __singleton:ABCore
		
		private var _root:CORE;
		
		public var TITLE:String;
		public var XML_PATH:String;
		public var LOGO_PATH:String;
		public var CONTENTS_PATH:String;
		public var INACTIVITY_TIME:int;
		//private static var sett:XMLList;	
		
		public function ABCore(root:CORE) 
		{
			_root = root;
			
			setSingleton();
			
			load()
		}
		
		private function load():void
		{
			XMLProperties.init("settings/settings.xml", settings_completeHandler);
		}
		
		private function settings_completeHandler(e:Event = null):void 
		{
			/// SETTINGS XML
			
			TITLE 					= XMLProperties.properties.TITLE;
			XML_PATH 				= XMLProperties.properties.XML_PATH;
			LOGO_PATH			 	= XMLProperties.properties.LOGO_PATH;
			CONTENTS_PATH 			= XMLProperties.properties.CONTENTS_PATH;
			INACTIVITY_TIME 		= XMLProperties.properties.INACTIVITY_TIME;
			
			_root.loadedXML = true;
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("ABCore ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function getSingleton():ABCore
		{
			if (__singleton == null)
			{
				throw new Error("ABCore ::: SINGLETON DOES NOT EXIST")
			}
			
			return __singleton;
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}
	
}