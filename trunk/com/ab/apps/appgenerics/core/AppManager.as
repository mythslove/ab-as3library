package com.ab.apps.appgenerics.core
{
	/**
	* @author AB
	*/
	
	/// features list
	
	/// APP LEVELS construction & management
	/// "please wait message" handling
	/// inactivity system
	/// screensaver handling (integrated with inactivity system);
	/// a few predefined keyboard shortcuts, room for more
	/// var for app MODE && MODE_CHANGE event dispatching on MODE change
	/// var for app LANG && LANG_CHANGE event dispatching on LANG change
	/// var for mouse state (up/down)
	/// some other useful "state" vars
	
	/// flash
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/// libs
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.properties.FilterShortcuts;
	import org.casalib.ui.Key;
	import org.casalib.util.StageReference;
	
	/// ab
	import com.ab.log.Logger;
	import com.ab.events.CentralEventSystem;
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.apps.appgenerics.core.InactivityManager;
	import com.ab.apps.appgenerics.settings.XMLSettings;
	
	public class AppManager extends Sprite
	{
		/// APP LEVELS
		private var _SCREENSAVER_LEVEL:Sprite;
		private var _ALERT_LEVEL:Sprite;
		private var _APP_LEVEL:Sprite;
		private var _TOP_LEVEL:Sprite;
		private var _MENU_LEVEL:Sprite;
		private var _MAIN_LEVEL:Sprite;
		private var _BACK_LEVEL:Sprite;
		
		/// helper "state" vars
		private var _MODE:String = "";
		private var _LANG:String = "";
		public var PLAYING_VIDEO:String=false;
		public var MOUSE_STATE:String = "UP"; // or "DOWN"
		
		/// INACTIVITY
		public var inactivityManager:InactivityManager;
		
		/// SCREENSAVER
		private var _screen_saver_time:Number=20000;
		private var _screen_saver_class:Class;
		private var _screen_saver_set:Boolean=false;
		
		/// keyboard
		protected var _key:Key;
		
		/// please wait message
		private var _pleasewaitmessage:*;
		private var _please_wait_message_class:Class;
		private var _please_wait_message_class_set:Boolean=false;
		
		/// system ::: don't touch these
		public var APP_INSTANCE:*;
		private var _APP_CLASS:Class;
		private static var __singleton:AppManager;
		
		
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
		
		public function setPleasewaitMessageClass(_class:Class):void
		{
			_please_wait_message_class 		= _class;
			_please_wait_message_class_set 	= true;
		}
		
		public function invokePleaseWaitMessage():void
		{
			if (_please_wait_message_class_set == true) 
			{
				_pleasewaitmessage = new _please_wait_message_class();
				
				addChildToLevel(_pleasewaitmessage, COREApi.LEVEL_ALERT);
			}
			else
			{
				trace("PleasewaitMessage Class not defined yet");
			}
		}
		
		public function closePleaseWaitMessage():void
		{
			if (_pleasewaitmessage != null) 
			{
				_pleasewaitmessage.close();
				
				_pleasewaitmessage = null;
			}
		}
		
		private function mouseUpHandler(e:MouseEvent):void  	{ MOUSE_STATE = "UP";   };
		private function mouseDownHandler(e:MouseEvent):void  	{ MOUSE_STATE = "DOWN"; };
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			//trace ("AppManager ::: keyDownHandler = " + e.keyCode); 
			
			switch (e.keyCode) 
			{
				case 57:
				break;
				
				case Keyboard.F6:
					callScreenSaver();
				break;
				
				case Keyboard.F9:
					XMLSettings.singleton.DEBUG_MODE = true;
					CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.MODE_CHANGE, "debug"));
				break;
				//case Keyboard.F5:
					//COREApi.log("F5");
					// podia ser ir para home / close all
				//break;
			}
		}
		
		public function addApplicationClassToStage():void
		{
			trace ("AppManager ::: addApplicationClassToStage()");
			
			/// here the "APP CLASS" is added in the "APP LEVEL";
			
			APP_INSTANCE = new _APP_CLASS();
			
			addChildToLevel(APP_INSTANCE, "MAIN");
			
			APP_INSTANCE.start();
		}
		
		/// create objects in specific application levels
		
		public function addChildToLevel(object:DisplayObject, level:String="MAIN", coordinates:Point=null):void
		{
			trace ("AppManager ::: addChildToLevel ::: LEVEL = " + level);
			
			if (object != null)
			{
				if (object is DisplayObject)
				{
					if (coordinates != null)  { object.x = coordinates.x; object.y = coordinates.y; }
					
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
		
		public function armInactivityAlert(time:Number):void
		{
			inactivityManager = new InactivityManager(time);
		}
		
		public function setScreenSaver(_class:*, _active:Boolean=true, _time:Number=20000):void
		{
			_screen_saver_class 	= _class;
			_screen_saver_set		= _active;
			_screen_saver_time 		= _time;
			
			inactivityManager 		= new InactivityManager(_screen_saver_time);
		}
		
		/// action to perform on inactivity
		public function inactivityDetectedCommand():void
		{
			//trace ("AppManager ::: inactivityDetected ");
			
			CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.INACTIVITY_DETECTED, ""));
			
			callScreenSaver();
		}
		
		/// action to perform on inactivity end
		public function inactivityEndedCommand():void
		{
			//trace ("AppManager ::: activityDetected ");
			CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.ACTIVITY_RESUMED, ""));
		}
		
		private function callScreenSaver():void
		{
			if (_screen_saver_class != null && _screen_saver_set == true)
			{
				var ss = new _screen_saver_class();
				
				addChildToLevel(ss, "SCREENSAVER");
			}
		}
		
		public function get MODE():String { return _MODE; }
		
		public function set MODE(value:String):void 
		{
			if (_MODE != value) 
			{
				_MODE = value;
				
				COREApi.dispatchEvent(new AppEvent(AppEvent.MODE_CHANGE, value));
			}
		}
		
		public function get LANG():String { return _LANG; }
		
		public function set LANG(value:String):void 
		{
			if (_LANG != value) 
			{
				_LANG = value;
				
				COREApi.dispatchEvent(new AppEvent(AppEvent.LANG_CHANGE, value));
			}
		}
		
		/// getters // setters
		public function get screen_saver_set():Boolean 					{ return _screen_saver_set;  	};
		public function set screen_saver_set(value:Boolean):void  		{ _screen_saver_set = value; 	};
		public function get screen_saver_class():Class 					{ return _screen_saver_class;   };
		public function set screen_saver_class(value:Class):void  		{ _screen_saver_class = value;  };
		public function get screen_saver_time():Number 					{ return _screen_saver_time; 	};
		public function set screen_saver_time(value:Number):void  		{ _screen_saver_time = value; 	};
		
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