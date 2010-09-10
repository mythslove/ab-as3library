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
	
	/// from other libs
	import org.casalib.util.StageReference;
	import net.hires.debug.Stats;
	
	/// edigma
	import com.edigma.web.EdigmaCore;
	import com.edigma.services.ServerCommunication;
	import com.ab.log.Logger;
	
	/// ab
	//import com.ab.log.ABLogger;
	import com.ab.events.CentralEventSystem;
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
		public var _appLevel:Sprite;
		
		public function CORE()
		{
			trace("ABº AS3 CORE System - Constructor");
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			CentralEventSystem.singleton.addEventListener(AppEvent.LOADED_DATA, loadedBaseData, false, 0 , true);
			CentralEventSystem.singleton.addEventListener(AppEvent.LOADED_SETTINGS, loadedSettings, false, 0 , true);
		}
		
		//private function addedToStage(e:Event):void  { init(); }
		private function addedToStage(e:Event):void  {  "CORE added to stage"; }
		
		public function init():void
		{ 
			trace ("CORE ::: step 1 ::: init()"); 
			
			StageReference.setStage(stage);
			
			ScreenSettings.init();
			
			_appLevel  				= new Sprite();
			_appInfo   				= new EdigmaCore();
			///_serverCommunication 	= new ServerCommunication();
			
			stage.addChild(_appLevel);
		}
		
		private function loadedSettings(e:AppEvent):void 
		{
			trace ("CORE ::: step 2 ::: settings loaded"); 
			
			/// this setter is called after EdigmaCore finishes loading settings XML
			COREApi.removeEventListener(AppEvent.LOADED_SETTINGS, loadedSettings);
			
			initMainVars();
		}
		
		private function initMainVars():void
		{
			trace ("CORE ::: step 3 ::: initMainVars()");
			
			appManager 					= new AppManager(_appLevel, APPLICATION_CLASS);
			
			dataManager 				= new DataManager(EdigmaCore.singleton.DATA_TYPE);
			
			if (EdigmaCore.singleton.DATA_TYPE == "XML") 
			{
				dataManager.xml_path 		= EdigmaCore.singleton.XML_PATH;
				dataManager.main_xml_file	= EdigmaCore.singleton.MAIN_XML_FILE;
			}
			
			dataManager.loadBaseData();
		}
		
		private function loadedBaseData(e:AppEvent):void
		{
			trace ("CORE ::: step 4 ::: loaded Data, start AppManager");
			
			/// this setter is called after DataManager finishes loading base data
			CentralEventSystem.singleton.removeEventListener(AppEvent.LOADED_DATA, loadedBaseData);
			
			/// here the visual application actually starts
			appManager.addApplicationClassToStage(); // the application class should catch the ADDED_TO_STAGE event to start
			
			/// add extra tools on debug mode
			if (EdigmaCore.singleton.DEBUG_MODE == true) 
			{
				/// add stats analyser
				var _stats 		= new Stats();
				_stats.x 		= 50;
				_stats.y 		= 50;
				
				/// add AB logger
				_appLogger 		= new Logger();
				_appLogger.x 	= 100;
				_appLogger.y 	= 50;
				
				COREApi.addChildToLevel(_stats, 	COREApi.LEVEL_ALERT );
				COREApi.addChildToLevel(_appLogger, COREApi.LEVEL_ALERT );
			}
		}
		
		/// setting the application outside will call the ini() method
		public function set APPLICATION_CLASS(value:Class):void { _APPLICATION_CLASS = value; init();}
		public function get APPLICATION_CLASS():Class 			{ return _APPLICATION_CLASS;  }
		
	} 
}