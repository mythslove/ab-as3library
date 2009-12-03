package com.ab.apps.appgenerics
{
	/**
	* @author AB
	*/
	
	//import CORE;
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.events.ItemEvent;
	import com.ab.events.CentralEventSystem;
	import com.ab.log.ABLogger;
	import org.casalib.ui.Key;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import org.casalib.util.StageReference;
	
	public class AppManager extends Sprite
	{
		/// private
		private var _APP_LEVEL:Sprite;
		private var _APP_CLASS:Class;
		
		/// protected	
		protected var _key:Key;
		
		/// public
		public static var __singleton:AppManager;
		
		
		public function AppManager(applevel:Sprite, appClass:Class)
		{
			setSingleton();
			
			_APP_LEVEL = applevel;
			_APP_CLASS = appClass;
			
			trace ("AppManager ::: _APP_CLASS = " + _APP_CLASS ); 
			
			this._key = Key.getInstance();
			
			this._key.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			//trace ("AppManager ::: keyDownHandler = " + e.keyCode); 
			
			switch (e.keyCode) 
			{
				case 49:
				break;
				
				case 50:
				break;
				
				case 51:
				break;
				
				case 52:
				break;
				
				case 53:
				break;
				
				case 54:
				break;
				
				case 55:
					//openItem(6)                     
				break;
				case 56:
					//openItem(7)
				break;
				case 57:
					//openItem(7)
				break;
				case Keyboard.F8:
					//openItem(7)
					ABLogger.getSingleton().toggleVisible();
				break;
				case Keyboard.F5:
					/// podia ser ir para home / close all
				break;
			}
		}
		
		public function start()
		{
			trace ("AppManager ::: start()");
			
			/// here the "APP CLASS" is added in the "APP LEVEL";
			
			_APP_LEVEL.addChild(new _APP_CLASS());
		}
		
		/// action to perform on inactivity
		public function inactivityDetectedCommand():void
		{
			trace ("AppManager ::: inactivityDetected ");
			CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.INACTIVITY_DETECTED, ""));
		}
		
		/// action to perform on inactivity end
		public function inactivityEndedCommand():void
		{
			trace ("AppManager ::: activityDetected ");
			CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.ACTIVITY_RESUMED, ""));
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		private function setSingleton():void
		{
			if (__singleton != null)  { throw new Error("AppManager ::: SINGLETON REPLICATION ATTEMPTED") }
			__singleton = this
		}
		public static function get singleton():AppManager
		{
			if (__singleton == null) { throw new Error("AppManager ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)") }
			return __singleton;
		}
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
	}
	
}