package com.ab.apps.appgenerics.core
{
	/**
	* @author AB
	*/
	
	
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.properties.FilterShortcuts;
	import com.edigma.web.EdigmaCore;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.casalib.ui.Key;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import org.casalib.util.StageReference;
	
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.events.CentralEventSystem;
	import com.edigma.log.Logger;
	import flash.display.DisplayObject;
	import com.ab.apps.appgenerics.core.InactivityManager;
	
	public class AppManager extends Sprite
	{
		/// private
		private var _SCREENSAVER_LEVEL:Sprite;
		private var _ALERT_LEVEL:Sprite;
		private var _APP_LEVEL:Sprite;
		private var _TOP_LEVEL:Sprite;
		private var _MENU_LEVEL:Sprite;
		private var _MAIN_LEVEL:Sprite;
		private var _BACK_LEVEL:Sprite;
		
		private var _APP_CLASS:Class;
		private var _MAIN_MENU_OPEN:Boolean;
		
		/// inactivity
		public var inactivityManager:InactivityManager;
		
		/// SCREENSAVER
		private var _SCREEN_SAVER_TIME:Number=20;
		private var _SCREEN_SAVER_CLASS:Class;
		private var _SCREEN_SAVER_ACTIVE:Boolean=false;
		
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
			
			createAppLevels();
			
			ColorShortcuts.init();
			FilterShortcuts.init();
			
			this._key = Key.getInstance();
			
			this._key.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP, 	mouseUpHandler);
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_DOWN,	mouseDownHandler);
		}
		
		private function createAppLevels():void
		{
			_BACK_LEVEL  		= new Sprite();
			_MAIN_LEVEL  		= new Sprite();
			_MENU_LEVEL  		= new Sprite();
			_TOP_LEVEL   		= new Sprite();
			_ALERT_LEVEL 		= new Sprite();
			_SCREENSAVER_LEVEL 	= new Sprite();
			
			_APP_LEVEL.addChildAt(_BACK_LEVEL,  		0);
			_APP_LEVEL.addChildAt(_MAIN_LEVEL,  		1);
			_APP_LEVEL.addChildAt(_MENU_LEVEL,  		2);
			_APP_LEVEL.addChildAt(_TOP_LEVEL,   		3);
			_APP_LEVEL.addChildAt(_ALERT_LEVEL, 		4);
			_APP_LEVEL.addChildAt(_SCREENSAVER_LEVEL, 	5);
		}
		
		private function mouseUpHandler(e:MouseEvent):void  	{ _MOUSE_STATE = "up";   };
		private function mouseDownHandler(e:MouseEvent):void  	{ _MOUSE_STATE = "down"; };
		
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
				break;
				
				case 56:
				break;
				
				case 57:
				break;
				
				case Keyboard.F6:
					callScreenSaver();
				break;
				
				case Keyboard.F9:
					EdigmaCore.singleton.DEBUG_MODE = true;
					CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.MODE_CHANGE, "debug"));
				break;
				//case Keyboard.F5:
					//COREApi.log("F5");
					/// podia ser ir para home / close all
				//break;
			}
		}
		
		public function startApplicationClass():void
		{
			_APP_INSTANCE = new _APP_CLASS();
			
			_APP_INSTANCE.start();
		}
		
		public function addApplicationClassToStage():void
		{
			trace ("AppManager ::: addApplicationClassToStage()");
			
			/// here the "APP CLASS" is added in the "APP LEVEL";
			
			_APP_INSTANCE = new _APP_CLASS();
			
			addChildToLevel(_APP_INSTANCE, "MAIN");
			
			_APP_INSTANCE.start();
		}
		
		/// create objects in specific application levels
		
		public function addChildToLevel(object:DisplayObject, level:String="MAIN", coordinates:Point=null):void
		{
			trace ("AppManager ::: addChildToLevel ::: LEVEL = " + level);
			
			if (coordinates == null)  { coordinates = new Point(0, 0); }
			
			if (object != null)
			{
				if (object is DisplayObject)
				{
					object.x = coordinates.x;
					object.y = coordinates.y;
					
					switch(level)
					{
						case "BACK":		_BACK_LEVEL.addChild(object);		  break;
						case "MAIN":		_MAIN_LEVEL.addChild(object);		  break;
						case "MENU":		_MENU_LEVEL.addChild(object);		  break;
						case "TOP":			_TOP_LEVEL.addChild(object);		  break;
						case "ALERT":		_ALERT_LEVEL.addChild(object);		  break;
						case "SCREENSAVER":	_SCREENSAVER_LEVEL.addChild(object);  break;
					}
				}
				else { trace ("ERROR: AppManager ::: addChildToLevel() -> PROVIDED OBJECT IS NOT DISPLAYOBJECT"); }
			}
			else { trace ("ERROR: AppManager ::: addChildToLevel() -> PROVIDED OBJECT IS NULL"); }
		}
		
		/// set up inactivity handler
		
		public function setScreenSaver(_class:*, _active:Boolean=true, _time:Number=NaN):void
		{
			_SCREEN_SAVER_CLASS 	= _class;
			_SCREEN_SAVER_ACTIVE	= _active;
			_SCREEN_SAVER_TIME 		= isNaN(_time) ? 20000 : _time;
			
			inactivityManager = new InactivityManager(_SCREEN_SAVER_TIME);
		}
		
		/// action to perform on inactivity
		
		public function inactivityDetectedCommand():void
		{
			//trace ("AppManager ::: inactivityDetected ");
			CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.INACTIVITY_DETECTED, ""));
			
			callScreenSaver();
		}
		
		private function callScreenSaver():void
		{
			if (_SCREEN_SAVER_CLASS != null && _SCREEN_SAVER_ACTIVE == true)
			{
				var ss = new _SCREEN_SAVER_CLASS();
				
				addChildToLevel(ss, "TOP");
			}
		}
		
		/// action to perform on inactivity end
		
		public function inactivityEndedCommand():void
		{
			//trace ("AppManager ::: activityDetected ");
			CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.ACTIVITY_RESUMED, ""));
		}
		
		/// getters // setters
		
		public function get MAIN_MENU_OPEN():Boolean 					{ return _MAIN_MENU_OPEN;  		};
		public function set MAIN_MENU_OPEN(value:Boolean):void  		{ _MAIN_MENU_OPEN = value; 		};
		
		public function get SCREEN_SAVER_ACTIVE():Boolean 				{ return _SCREEN_SAVER_ACTIVE;  };
		public function set SCREEN_SAVER_ACTIVE(value:Boolean):void  	{ _SCREEN_SAVER_ACTIVE = value; };
		public function get SCREEN_SAVER_CLASS():Class 					{ return _SCREEN_SAVER_CLASS;   };
		public function set SCREEN_SAVER_CLASS(value:Class):void  		{ _SCREEN_SAVER_CLASS = value;  };
		public function get SCREEN_SAVER_TIME():Number 					{ return _SCREEN_SAVER_TIME; 	};
		public function set SCREEN_SAVER_TIME(value:Number):void  		{ _SCREEN_SAVER_TIME = value; 	};
		
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