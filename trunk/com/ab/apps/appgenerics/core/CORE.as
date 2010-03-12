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
	
	/// ab
	import com.ab.log.ABLogger;
	import com.ab.events.CentralEventSystem;
	/// ab app generics
	//import com.ab.apps.appgenerics.core.COREApi;
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.apps.appgenerics.core.AppManager;
	import com.ab.apps.appgenerics.core.DataManager;
	import com.ab.apps.appgenerics.core.InactivityManager;
	import com.ab.apps.appgenerics.core.ScreenSettings;
	
	public class CORE extends Sprite
	{
		public var APPLICATION_CLASS:Class = ARQUEHOJEVIDEOWALL; /// <------- REQUIRED - DEFINES MAIN APPLICATION CLASS
		
		/// private
		//protected static var _api:COREApi;
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
			trace ("CORE ::: step 1 ::: init()"); 
			
			StageReference.setStage(this.stage); 
			
			ScreenSettings.init();
			
			_appLevel  				= new Sprite();
			_appLogger 				= new ABLogger();
			_appInfo   				= new EdigmaCore();
			///_serverCommunication 	= new ServerCommunication();
			
			stage.addChild(_appLevel);
			
			_appLogger.x 			 = 100;
			_appLogger.y 			 = 50;
			//_appLogger.start_visible = true;
			
			stage.addChild(_appLogger);
			//_appLogger.x += 300;
		}
		
		private function loadedSettings(e:AppEvent):void 
		{
			trace ("CORE ::: step 2 ::: loadedSettings()"); 
			
			/// this setter is called after EdigmaCore finishes loading settings XML
			CentralEventSystem.singleton.removeEventListener(AppEvent.LOADED_SETTINGS, loadedSettings);
			
			initMainVars();
		}
		
		private function initMainVars():void
		{
			trace ("CORE ::: step 3 ::: initMainVars()");
			
			inactivityManager 		= new InactivityManager(_appInfo.INACTIVITY_TIME);
			appManager 				= new AppManager(_appLevel, APPLICATION_CLASS);
			dataManager 			= new DataManager("XML");
			
			dataManager.xml_path 	= "contents/CONTENTS.xml";
			
			dataManager.loadBaseData();
		}
		
		private function loadedData(e:AppEvent):void
		{
			trace ("CORE ::: step 4 ::: loaded Data, start AppManager");
			
			/// this setter is called after DataManager finishes loading data
			CentralEventSystem.singleton.removeEventListener(AppEvent.LOADED_DATA, loadedData);
			
			/// here the visual application actually starts
			appManager.startApplicationClass();
			
			/// add stats analyser
			//var _stats = stage.addChild(new Stats())
		    //_stats.y = -100;
		}
	} 
}

/**
	*   @notas
	*/
/*

 glGenTextures( 1, &textureAndInfo->texture );
    glBindTexture( GL_TEXTURE_2D, textureAndInfo->texture );
    glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, b.width(), b.height(), 0, GL_RGBA, GL_UNSIGNED_BYTE, b.bits() );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    glBindTexture( GL_TEXTURE_2D, 0 );
	
 if(position.x() >= _wallpapers[i]->getPosition().x() - _wallpapers[i]->getWidth()/2.0 * _wallpapers[i]->getScale()
	&& position.x() <= _wallpapers[i]->getPosition().x() + _wallpapers[i]->getWidth()/2.0 * _wallpapers[i]->getScale()
	&& position.y() >= _wallpapers[i]->getPosition().y()
	&& position.y() <= _wallpapers[i]->getPosition().y() + _wallpapers[i]->getHeight() * _wallpapers[i]->getScale())
	{
		qDebug() << "Wallpaper selected: " << _wallpapers[i]->getTexture()->fileName;
		_wallpaperSelected = i;

		_mustScaleUp = true;
		_mustScaleDown = false;

		_direction = 0;

		_wallpapers[i]->setTextTexture(drawText(_wallpapers[i]->getTexture()->fileName));

		selectionAnimation = new QPropertyAnimation(_wallpapers[i], "scale", this);
		selectionAnimation->setEndValue(20.0f);
		selectionAnimation->setDuration(1000);
		//selectionAnimation->setStartValue(_wallpapers[i]->getScale());
		selectionAnimation->setEasingCurve(QEasingCurve::InOutBack);
		selectionAnimation->start();

		break;
    }
*/
