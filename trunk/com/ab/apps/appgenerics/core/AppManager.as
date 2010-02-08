package com.ab.apps.appgenerics.core
{
	/**
	* @author AB
	*/
	
	
	import flash.events.MouseEvent;
	import org.casalib.ui.Key;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import org.casalib.util.StageReference;
	
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.events.CentralEventSystem;
	import com.ab.log.ABLogger;
	
	public class AppManager extends Sprite
	{
		/// private
		private var _APP_LEVEL:Sprite;
		private var _APP_CLASS:Class;
		
		/// public
		public var _APP_INSTANCE:*;
		public var _MOUSE_STATE:String = "up"; // or "down"
		
		/// protected	
		protected var _key:Key;
		
		/// singleton
		public static var __singleton:AppManager;
		
		
		public function AppManager(applevel:Sprite, appClass:Class)
		{
			setSingleton();
			
			_APP_LEVEL = applevel;
			_APP_CLASS = appClass;
			
			//import _APP_CLASS;
			
			this._key = Key.getInstance();
			
			this._key.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP, 	mouseUpHandler);
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_DOWN,	mouseDownHandler);
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			_MOUSE_STATE = "up";
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			_MOUSE_STATE = "down";
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
					ABLogger.singleton.toggleVisible();
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
			
			_APP_INSTANCE = new _APP_CLASS();
			
			_APP_LEVEL.addChild(_APP_INSTANCE);
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