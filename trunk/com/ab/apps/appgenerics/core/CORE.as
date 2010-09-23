package com.ab.apps.appgenerics.core
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
	import org.libspark.ui.SWFWheel;
	
	/// from other libs
	import org.casalib.util.StageReference;
	import net.hires.debug.Stats;
	
	/// edigma
	import com.edigma.web.EdigmaCore;
	//import com.edigma.services.ServerCommunication;
	
	/// ab
	import com.ab.events.CentralEventSystem;
	import com.ab.log.Logger;
	/// ab app generics
	//import com.ab.apps.appgenerics.core.COREApi;
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.apps.appgenerics.core.AppManager;
	import com.ab.apps.appgenerics.core.DataManager;
	import com.ab.apps.appgenerics.core.ScreenSettings;
	
	public class CORE extends Sprite
	{
		private var _APPLICATION_CLASS:Class; /// <------- REQUIRED - DEFINES MAIN APPLICATION CLASS -> define this class in a class that extends CORE
		
		/// private
		private var _appInfo:EdigmaCore;
		private var _CentralEventSystem:CentralEventSystem;
		private var _appLogger:Logger;
		
		/// public
		//public var _serverCommunication:ServerCommunication;
		public var appManager:AppManager;
		public var dataManager:DataManager;
		public var keyboardManager:KeyboardManager;
		public var _appLevel:Sprite;
		public var _loggerLevel:Sprite;
		public var _statsLevel:Sprite;
		
		private var _loaderinfo_parameters:Object=new Object();
		
		public function CORE()
		{
			trace("ABº AS3 CORE System - Constructor");
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			COREApi.addEventListener(AppEvent.LOADED_DATA, loadedBaseData, false, 0 , true);
			COREApi.addEventListener(AppEvent.LOADED_SETTINGS, loadedSettings, false, 0 , true);
		}
		
		//private function addedToStage(e:Event):void  { init(); }
		private function addedToStage(e:Event):void  {  "CORE added to stage"; }
		
		public function init():void
		{ 
			trace ("CORE ::: step 1 ::: init()"); 
			
			SWFWheel.initialize(stage);
			
			StageReference.setStage(stage);
			
			ScreenSettings.init();
			
			_appLevel  				= new Sprite();
			_loggerLevel			= new Sprite();
			_statsLevel				= new Sprite();
			_appInfo   				= new EdigmaCore();
			///_serverCommunication 	= new ServerCommunication();
			
			stage.addChildAt(_appLevel,    0);
			stage.addChildAt(_statsLevel,  1);
			stage.addChildAt(_loggerLevel, 2);
			
			//loadedSettings(new AppEvent(AppEvent.LOADED_SETTINGS, ""));
			loadedSettings();
		}
		
		//private function loadedSettings(e:AppEvent):void 
		private function loadedSettings():void 
		{
			trace ("CORE ::: step 2 ::: settings loaded"); 
			
			/// this setter is called after EdigmaCore finishes loading settings XML
			//COREApi.removeEventListener(AppEvent.LOADED_SETTINGS, loadedSettings);
			//
			initMainVars();
		}
		
		private function initMainVars():void
		{
			trace ("CORE ::: step 3 ::: initMainVars()");
			
			appManager 		= new AppManager(_appLevel, APPLICATION_CLASS);
			keyboardManager = new KeyboardManager();
			
			//appManager.core 			= this;
			/*
			dataManager 				= new DataManager(EdigmaCore.singleton.DATA_TYPE);
			
			if (EdigmaCore.singleton.DATA_TYPE == "XML") 
			{
				dataManager.xml_path 		= EdigmaCore.singleton.XML_PATH;
				dataManager.main_xml_file	= EdigmaCore.singleton.MAIN_XML_FILE;
			}
			
			dataManager.loadBaseData();*/
			loadedBaseData(new AppEvent(AppEvent.LOADED_DATA, ""));
		}
		
		private function loadedBaseData(e:AppEvent):void
		{
			e.stopPropagation();
			trace ("CORE ::: step 4 ::: loaded Data, start AppManager");
			
			/// this setter is called after DataManager finishes loading base data
			COREApi.removeEventListener(AppEvent.LOADED_DATA, loadedBaseData);
			
			/// here the visual application actually starts
			AppManager.singleton.addApplicationClassToStage(); // the application class should catch the ADDED_TO_STAGE event to start
			
			/// add extra tools on debug mode
			//if (EdigmaCore.singleton.DEBUG_MODE == true) 
			//{
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
			//}
		}
		
		/// setting the application outside will call the ini() method
		public function set APPLICATION_CLASS(value:Class):void { _APPLICATION_CLASS = value; init();}
		public function get APPLICATION_CLASS():Class 			{ return _APPLICATION_CLASS;  }
		
		public function get loaderinfo_parameters():Object { return _loaderinfo_parameters; }
		
		public function set loaderinfo_parameters(value:Object):void 
		{
			_loaderinfo_parameters = value;
			
			//AppManager.singleton.loaderinfo_parameters = loaderinfo_parameters;
		}
		
	} 
}