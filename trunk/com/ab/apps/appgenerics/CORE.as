package com.ab.apps.appgenerics
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
	*                             :::::::::::::''          
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
	
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.edigma.services.ServerCommunication;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import org.casalib.util.StageReference;
	
	import com.ab.log.ABLogger;
	import com.ab.events.CentralEventSystem;
	
	import net.hires.debug.Stats;
	import com.edigma.web.EdigmaCore;
	
	import com.ab.apps.appgenerics.AppManager;
	import com.ab.apps.appgenerics.DataManager;
	import com.ab.apps.appgenerics.InactivityManager;
	
	public class CORE extends Sprite
	{
		/// private
		private var _appInfo:EdigmaCore;
		private var _loadedSettings:Boolean=false;
		private var _loadedData:Boolean=false;
		private var _CentralEventSystem:CentralEventSystem;
		public var _serverCommunication:ServerCommunication;
		private var _appLogger:ABLogger;
		
		/// public
		public var appManager:AppManager;
		public var dataManager:DataManager;
		public var inactivityManager:InactivityManager;
		public var _appLevel:Sprite;
		public var _appClass:*;
		
		
		public function CORE()
		{
			stage.displayState = StageDisplayState.FULL_SCREEN;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			CentralEventSystem.singleton.addEventListener(AppEvent.LOADED_DATA, loadedData, false, 0 , true);
			CentralEventSystem.singleton.addEventListener(AppEvent.LOADED_SETTINGS, loadedSettings, false, 0 , true);
		}
		
		private function addedToStage(e:Event):void  { init(); }
		
		private function init():void
		{ 
			StageReference.setStage(this.stage); 
			
			_appLevel  				= new Sprite();
			_appLogger 				= new ABLogger();
			_appInfo   				= new EdigmaCore();
			_serverCommunication 	= new ServerCommunication();
			
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
			
			inactivityManager 	 = new InactivityManager(_appInfo.INACTIVITY_TIME);
			appManager 			 = new AppManager(_appLevel, _appClass);
			dataManager 		 = new DataManager("AMF");
			
			dataManager.start();
		}
		
		private function loadedData(e:AppEvent):void 
		{
			/// this setter is called after DataManager finishes loading data
			CentralEventSystem.singleton.removeEventListener(AppEvent.LOADED_DATA, loadedData);
			trace ("CORE ::: loadedData()");
			
			/// here the visual application actually starts
			appManager.start();
			
			/// add stats analyser
			var _stats = stage.addChild(new Stats())
		    _stats.y = -100;
		}
	} 
}

/**
 * @NOTES
 * 
 * tirar o video
 * 
 * * procurar nao passar referencias aos filhos
 * 
 * 
 * mudar a cena das cartas:
 * - usar um tweenzinho no inicio para as mexer: rotation e random +/-x  |||  +/-y
 * - nenhuma deve ter enterFrame no inicio
 * 
 * 
 **/

 /// last night a clichaved my life
 //aufgang baroque
 //run it duke dumont
 
//ambivalent creeps EP
//woody woodpecker
//hobo from A to B
//lessizmore
//tolga fidan violente
//minilogue animals remixes
//robag wruhme abusus adde
//dowski roulette
//booty loops
// minimize to maximize
 
 
 




