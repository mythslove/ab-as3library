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
	
	/// from other libs
	import org.casalib.util.StageReference;
	import net.hires.debug.Stats;
	
	/// edigma
	import com.edigma.web.EdigmaCore;
	import com.edigma.services.ServerCommunication;
	
	/// ab
	import com.ab.log.ABLogger;
	import com.ab.events.CentralEventSystem;
	/// ab app generics
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.apps.appgenerics.core.AppManager;
	import com.ab.apps.appgenerics.core.DataManager;
	import com.ab.apps.appgenerics.core.InactivityManager;
	import com.ab.apps.appgenerics.core.ScreenSettings;
	
	public class CORE extends Sprite
	{
		public var APPLICATION_CLASS:Class = ARQUEHOJEVIDEOWALL; /// <------- REQUIRED - DEFINES MAIN APPLICATION CLASS
		
		/// private
		private var _appInfo:EdigmaCore;
		private var _loadedSettings:Boolean = false;
		private var _loadedData:Boolean 	= false;
		private var _CentralEventSystem:CentralEventSystem;
		private var _appLogger:ABLogger;
		
		/// public
		//public var _serverCommunication:ServerCommunication;
		public var appManager:AppManager;
		public var dataManager:DataManager;
		public var inactivityManager:InactivityManager;
		public var _appLevel:Sprite;
		
		
		public function CORE()
		{
			trace("ABº AS3 CORE System - Constructor");
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			CentralEventSystem.singleton.addEventListener(AppEvent.LOADED_DATA, loadedData, false, 0 , true);
			CentralEventSystem.singleton.addEventListener(AppEvent.LOADED_SETTINGS, loadedSettings, false, 0 , true);
		}
		
		private function addedToStage(e:Event):void  { init(); }
		
		private function init():void
		{ 
			StageReference.setStage(this.stage); 
			
			ScreenSettings.init();
			
			_appLevel  				= new Sprite();
			_appLogger 				= new ABLogger();
			_appInfo   				= new EdigmaCore();
			///_serverCommunication 	= new ServerCommunication();
			
			stage.addChild(_appLevel);
			stage.addChild(_appLogger);
			
			_appLogger.x += 300;
		}
		
		private function loadedSettings(e:AppEvent):void 
		{
			trace ("CORE ::: loadedSettings()"); 
			
			/// this setter is called after EdigmaCore finishes loading settings XML
			CentralEventSystem.singleton.removeEventListener(AppEvent.LOADED_SETTINGS, loadedSettings);
			
			initMainVars();
		}
		
		private function initMainVars():void
		{
			trace ("CORE ::: initMainVars()"); 
			
			inactivityManager 	= new InactivityManager(_appInfo.INACTIVITY_TIME);
			appManager 			= new AppManager(_appLevel, APPLICATION_CLASS);
			dataManager 		= new DataManager("XML");
			
			dataManager.loadBaseData();
		}
		
		private function loadedData(e:AppEvent):void 
		{
			/// this setter is called after DataManager finishes loading data
			CentralEventSystem.singleton.removeEventListener(AppEvent.LOADED_DATA, loadedData);
			trace ("CORE ::: loaded Data, start AppManager");
			
			/// here the visual application actually starts
			appManager.start();
			
			/// add stats analyser
			//var _stats = stage.addChild(new Stats())
		    //_stats.y = -100;
		}
	} 
}

/**
 * @NOTES
 **/
