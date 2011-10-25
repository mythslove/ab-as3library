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
		public var swfAddressManager:SWFAddressManager;
		
		/// core levels
		public var _appLevel:Sprite;
		public var _loggerLevel:Sprite;
		public var _statsLevel:Sprite;
		
		/// Vector Fonts Manager
		public var _vectorFontsManager:VectorFontsManager;
		
		public function CORE()
		{
			trace("ABº AS3 CORE System - Constructor");
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void 
		{ 
			"CORE added to stage"; 
			
			COREApi.addEventListener(AppEvent.LOADED_SETTINGS, loadedSettings, false, 0 , true);
			
			_appInfo = new XMLSettings();
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
			
			StageReference.setStage(stage);
			
			ScreenSettings.init();
			
			_appLevel  				= new Sprite();
			_loggerLevel			= new Sprite();
			_statsLevel				= new Sprite();
			///_serverCommunication 	= new ServerCommunication();
			
			_appLevel.tabChildren = false;
			
			stage.addChildAt(_appLevel,    0);
			stage.addChildAt(_statsLevel,  1);
			stage.addChildAt(_loggerLevel, 2);
			
			initMainVars();
			loadFontManager();
		}
		
		private function loadFontManager():void 
		{
			COREApi.addEventListener(AppEvent.LOADED_FONTS, loadedFontsHandler);
			
			/// create vector fonts manager
			_vectorFontsManager = new VectorFontsManager();
			_vectorFontsManager.init();
		}
		
		private function loadedFontsHandler(e:AppEvent):void 
		{
			e.stopPropagation();
			
			COREApi.removeEventListener(AppEvent.LOADED_FONTS, loadedFontsHandler);
			
			//initMainVars();
		}
		
		private function initMainVars():void
		{
			trace ("CORE ::: step 3 ::: initMainVars()");
			
			/// app manager
			appManager 		= new AppManager(_appLevel, APPLICATION_CLASS, XMLSettings.setting.PROJECT_TYPE);
			appManager.core = this;
			
			/// keyboard manager
			keyboardManager = new KeyboardManager();
			
			/// swfaddress manager
			swfAddressManager = new SWFAddressManager();
			
			DataManager.singleton.xml_path = XMLSettings.setting.XML_PATH;
			
			/// load XML/AMF data
			if (XMLSettings.setting.LOAD_XML_FILES == true)
			{
				COREApi.addEventListener(AppEvent.LOADED_DATA, loadedBaseData);
				
				DataManager.singleton.loadXMLFiles(XMLSettings.setting.XML_FILES_TO_LOAD);
			}
			else
			{
				loadedBaseData(null);
			}
		}
		
		private function loadedBaseData(e:AppEvent=null):void
		{
			if (e) { e.stopPropagation(); };
			
			/// this setter is called after DataManager finishes loading base data
			COREApi.removeEventListener(AppEvent.LOADED_DATA, loadedBaseData);
			
			/// add extra tools on debug mode
			if (XMLSettings.setting.DEBUG_MODE == true) 
			{
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
			
			trace ("CORE ::: step 4 ::: loaded Data, start Application class");
			/// a "start()" method will be called from the application class when it is ADDED_TO_STAGE
			AppManager.singleton.addApplicationClassToStage();
			
			if (XMLSettings.setting.FULL_SCREEN == true)  		{ COREApi.setFullscreen(); };
		}
		
		/// setting the application outside will call the ini() method
		public function set APPLICATION_CLASS(value:Class):void { _APPLICATION_CLASS = value; } //init();
		public function get APPLICATION_CLASS():Class 			{ return _APPLICATION_CLASS;  }
		
	} 
}