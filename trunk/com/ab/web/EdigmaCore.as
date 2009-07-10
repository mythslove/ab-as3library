package com.edigma.web 
{
	/**
	* @author ABº
	* 
	* @EDIGMACOM
	*/
	
	import ecomuseu.CORE;
	import flash.events.Event;
	import com.edigma.xml.*;
	
	public class EdigmaCore 
	{
		private static var __singleton:EdigmaCore
		
		private var _root:CORE;
		
		public var CONTENTS_PATH:String;
		public var CONTENTS_XML_PATH:String;
		public var CONTENTS_PATH_IMAGES:String;
		public var BACKGROUND_VIDEO_PATH:String;
		public var GALLERY_INFOTIP:String;
		public var LIST_HEADLINE:String;
		public var INACTIVITY_TIME:int;
		public var SENSOR_THRESHOLD:uint;
		public var SENSOR_PORT:uint;
		public var SENSOR_HOST:String;
		
		public var MIDDLE_X:String;
		public var MIDDLE_Y:String;
		public var LEFT_X:String;
		public var LEFT_Y:String;
		public var RIGHT_X:String;
		public var RIGHT_Y:String;
		//private static var sett:XMLList;	
		
		public function EdigmaCore(root:CORE) 
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
			
			CONTENTS_PATH 			= XMLProperties.properties.CONTENTS_PATH;
			CONTENTS_XML_PATH 		= XMLProperties.properties.CONTENTS_XML_PATH;
			INACTIVITY_TIME 		= XMLProperties.properties.INACTIVITY_TIME;
			SENSOR_THRESHOLD 		= XMLProperties.properties.SENSOR_THRESHOLD;
			SENSOR_PORT 			= XMLProperties.properties.SENSOR_PORT;
			SENSOR_HOST 			= XMLProperties.properties.SENSOR_HOST;
			LIST_HEADLINE 			= XMLProperties.properties.LIST_HEADLINE;
			GALLERY_INFOTIP 		= XMLProperties.properties.GALLERY_INFOTIP;
			BACKGROUND_VIDEO_PATH 	= XMLProperties.properties.BACKGROUND_VIDEO_PATH;
			CONTENTS_PATH_IMAGES 	= XMLProperties.properties.CONTENTS_PATH_IMAGES;
			
			MIDDLE_X			 	= XMLProperties.properties.MIDDLE_X;
			MIDDLE_Y 				= XMLProperties.properties.MIDDLE_Y;
			LEFT_X 					= XMLProperties.properties.LEFT_X;
			LEFT_Y 					= XMLProperties.properties.LEFT_Y;
			RIGHT_X 				= XMLProperties.properties.RIGHT_X;
			RIGHT_Y 				= XMLProperties.properties.RIGHT_Y;
			
			//trace ("EdigmaCore ::: BACKGROUND_VIDEO_PATH = " + BACKGROUND_VIDEO_PATH ); 
			
			_root.loadedXML = true;
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("EdigmaCore ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function getSingleton():EdigmaCore
		{
			if (__singleton == null)
			{
				throw new Error("EdigmaCore ::: SINGLETON DOES NOT EXIST")
			}
			
			return __singleton;
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}
	
}