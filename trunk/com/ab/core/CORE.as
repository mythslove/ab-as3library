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
	import com.ab.swfaddress.SWFAddressManager;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/// from other libs
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
	
	public class CORE
	{
		/// application class
		//private var _APPLICATION_CLASS:Class; /// <------- REQUIRED - DEFINES MAIN APPLICATION CLASS -> set this class in the constructor of a class that extends CORE
		
		/// private
		private var _appInfo:XMLSettings;
		//private var _CentralEventSystem:CentralEventSystem;
		private var _appLogger:Logger;
		
		/// public
		public var stage:Stage;
		
		/// services
		//public var _serverCommunication:ServerCommunication;
		
		/// managers
		public var dataManager:DataManager;
		//public var keyboardManager:KeyboardManager;
		
		/// core levels
		public var _appLevel:Sprite;
		public var _loggerLevel:Sprite;
		public var _statsLevel:Sprite;
		
		public function CORE()
		{
			trace("ABº AS3 CORE System - Constructor");
			
			start();
		}
		
		private function start():void 
		{
			_appInfo = new XMLSettings();
			
			COREApi.addEventListener(AppEvent.LOADED_SETTINGS, loadedSettings);
		}
		
		private function loadedSettings(e:AppEvent):void
		{
			trace ("CORE ::: step 2 ::: loadedSettings()");
			
			e.stopPropagation();
			
			/// this setter is called after XMLSettings finishes loading settings XML
			COREApi.removeEventListener(AppEvent.LOADED_SETTINGS, loadedSettings);
			
			init();
		}
		
		public function init():void
		{ 
			trace ("CORE ::: step 1 ::: init()"); 
			
			SWFWheel.initialize(stage);
			
			_appLevel  				= new Sprite();
			_loggerLevel			= new Sprite();
			_statsLevel				= new Sprite();
			///_serverCommunication 	= new ServerCommunication();
			
			_appLevel.tabChildren = false;
			
			stage.addChildAt(_appLevel,    0);
			stage.addChildAt(_statsLevel,  1);
			stage.addChildAt(_loggerLevel, 2);
			
			/// app manager
			AppManager.init(stage, _appLevel, XMLSettings.setting.PROJECT_TYPE);
			
			ScreenSettings.init();
			
			COREApi.addEventListener(AppEvent.LOADED_FONTS, loadedFontsHandler);
			
			AppManager.loadFonts();
		}
		
		private function loadedFontsHandler(e:AppEvent):void 
		{
			COREApi.removeEventListener(AppEvent.LOADED_FONTS, loadedFontsHandler);
			
			initMainVars();
		}
		
		private function initMainVars():void
		{
			trace ("CORE ::: step 3 ::: initMainVars()");
			
			DataManager.singleton.xml_path = XMLSettings.setting.XML_PATH;
			
			/// load XML/AMF data
			if (XMLSettings.setting.LOAD_XML_FILES == true)
			{
				trace("load");
				COREApi.addEventListener(AppEvent.LOADED_DATA, loadedBaseData);
				
				DataManager.singleton.loadXMLFiles(XMLSettings.setting.XML_FILES_TO_LOAD);
			}
			else
			{
				trace("DONT load");
				loadedBaseData(null);
			}
		}
		
		private function loadedBaseData(e:AppEvent=null):void
		{
			if (e) { e.stopPropagation(); };
			
			/// this setter is called after DataManager finishes loading base data
			COREApi.removeEventListener(AppEvent.LOADED_DATA, loadedBaseData);
			trace("fsdfsdfsdfd logger")
			
			/// add extra tools on debug mode
			if (XMLSettings.setting.DEBUG_MODE == true) 
			{
				trace("creating logger")
				trace("(XMLSettings.setting.DEBUG_MODE == true) : ");
				
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
			
			//trace ("CORE ::: step 4 ::: loaded Data, start Application class");
			// a "start()" method will be called from the application class when it is ADDED_TO_STAGE
			AppManager.createAppLevels();
			
			if (XMLSettings.setting.FULL_SCREEN == true)  		{ COREApi.setFullscreen(); };
			
			/// keyboard manager
			//keyboardManager = new KeyboardManager();
			
			/// activate swfaddress manager
			SWFAddressManager.activate();
			
			COREApi.dispatchEvent(new AppEvent(AppEvent.APPLICATION_READY, ""));
		}
		
		/// setting the application outside will call the ini() method
		//public function set APPLICATION_CLASS(value:Class):void { _APPLICATION_CLASS = value; } //init();
		//public function get APPLICATION_CLASS():Class 			{ return _APPLICATION_CLASS;  }
		
	} 
}