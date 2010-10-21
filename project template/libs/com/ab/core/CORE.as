package com.ab.core
{
	/**
	*   ABº AS3 CORE System
	* 
	*   @author ABº
	*                              .::::.                   
	*                            .::::::::.                 
	*                            :::::::::::                
	*                            ':::::::::::..             
	*                             :::::::::::::::'          
	*                              ':::::::::::.            
	*                                .::::::::::::::'       
	*                              .:::::::::::...          
	*                             ::::::::::::::''          
	*                 .:::.       '::::::::''::::           
	*               .::::::::.      ':::::'  '::::          
	*              .::::':::::::.    :::::    '::::.        
	*            .:::::' ':::::::::. :::::      ':::.       
	*          .:::::'     ':::::::::.:::::       '::.      
	*        .::::''         '::::::::::::::       '::.     
	*       .::''              '::::::::::::         :::... 
	*    ..::::                  ':::::::::'        .:' ''''
	* ..''''':'                    ':::::.'                 
	*/
	
	/// flash imports
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/// from other libs
	import org.casalib.util.StageReference;
	import net.hires.debug.Stats;
	import org.libspark.ui.SWFWheel;
	
	/// ab
	import com.ab.events.CentralEventSystem;
	import com.ab.log.Logger;
	/// ab app generics
	import com.ab.events.AppEvent;
	import com.ab.core.AppManager;
	import com.ab.core.DataManager;
	import com.ab.core.ScreenSettings;
	import com.ab.settings.XMLSettings;
	
	public class CORE extends Sprite
	{
		/// application class
		private var _APPLICATION_CLASS:Class; /// <------- REQUIRED - DEFINES MAIN APPLICATION CLASS -> set this class in the constructor of a class that extends CORE
		
		/// private
		private var _appInfo:XMLSettings;
		private var _CentralEventSystem:CentralEventSystem;
		private var _appLogger:Logger;
		
		/// services
		//public var _serverCommunication:ServerCommunication;
		
		/// managers
		public var appManager:AppManager;
		public var dataManager:DataManager;
		public var keyboardManager:KeyboardManager;
		
		/// core levels
		public var _appLevel:Sprite;
		public var _loggerLevel:Sprite;
		public var _statsLevel:Sprite;
		
		public function CORE()
		{
			trace("ABº AS3 CORE System - Constructor");
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			COREApi.addEventListener(AppEvent.LOADED_DATA, loadedBaseData, false, 0 , true);
			COREApi.addEventListener(AppEvent.LOADED_SETTINGS, loadedSettings, false, 0 , true);
		}
		
		private function addedToStage(e:Event):void { "CORE added to stage"; };
		
		public function init():void
		{ 
			trace ("CORE ::: step 1 ::: init()"); 
			
			SWFWheel.initialize(stage);
			
			StageReference.setStage(stage);
			
			ScreenSettings.init();
			
			_appLevel  				= new Sprite();
			_loggerLevel			= new Sprite();
			_statsLevel				= new Sprite();
			_appInfo   				= new XMLSettings();
			///_serverCommunication 	= new ServerCommunication();
			
			stage.addChildAt(_appLevel,    0);
			stage.addChildAt(_statsLevel,  1);
			stage.addChildAt(_loggerLevel, 2);
		}
		
		private function loadedSettings(e:AppEvent):void
		{
			trace ("CORE ::: step 2 ::: loadedSettings()");
			
			/// this setter is called after XMLSettings finishes loading settings XML
			COREApi.removeEventListener(AppEvent.LOADED_SETTINGS, loadedSettings);
			
			initMainVars();
		}
		
		private function initMainVars():void
		{
			trace ("CORE ::: step 3 ::: initMainVars()");
			
			/// app manager
			appManager 		= new AppManager(_appLevel, APPLICATION_CLASS);
			appManager.core = this;
			
			/// keyboard manager
			keyboardManager = new KeyboardManager();
			
			/// load XML/AMF data
			
			if (XMLSettings.setting.DATA_TYPE == "XML") 
			{
				DataManager.singleton.xml_path 		= XMLSettings.setting.XML_PATH;
				DataManager.singleton.main_xml_file = XMLSettings.setting.XML_PATH + XMLSettings.setting.MAIN_XML_FILE;
			}
		}
		
		private function loadedBaseData(e:AppEvent):void
		{
			e.stopPropagation();
			
			/// this setter is called after DataManager finishes loading base data
			COREApi.removeEventListener(AppEvent.LOADED_DATA, loadedBaseData);
			
			trace ("CORE ::: step 4 ::: loaded Data, start Application class");
			/// a "start()" method will be called from the application class when it is ADDED_TO_STAGE
			AppManager.singleton.addApplicationClassToStage();
			
			/// add extra tools on debug mode
			if (XMLSettings.setting.DEBUG_MODE == true) 
			{
				/// add stats analyser
				var _stats:Stats	= new Stats();
				_stats.x 			= 50;
				_stats.y 			= 50;
				
				/// add AB logger
				_appLogger 			= new Logger();
				_appLogger.x 		= 100;
				_appLogger.y 		= 50;
				
				_statsLevel.addChild(_stats);
				_loggerLevel.addChild(_appLogger);
			}
			
			if (XMLSettings.setting.FULL_SCREEN == true)  { COREApi.setFullscreen(); };
		}
		
		/// setting the application outside will call the ini() method
		public function set APPLICATION_CLASS(value:Class):void { _APPLICATION_CLASS = value; init();}
		public function get APPLICATION_CLASS():Class 			{ return _APPLICATION_CLASS;  }
		
	} 
}