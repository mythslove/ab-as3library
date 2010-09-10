package com.ab.apps.appgenerics.core
{
	/**
	* @author AB
	*/
	
	/// APP MANAGER - FEATURES LIST
	
	/// APPLICATION LEVELS construction & management
	/// instantiation of APPLICATION MODES manager
	/// initialization of ColorShortcuts and FilterShortcuts
	/// "please wait message" handling
	/// screensaver system
	/// inactivity system
	/// a few predefined keyboard shortcuts (ex: start screensaver / set debug mode / set fullscreen / set normal screen) room for more 
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
	
	/// ab lib
	import com.ab.log.Logger;
	import com.ab.events.CentralEventSystem;
	import com.ab.apps.appgenerics.core.AppModesManager;
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.apps.appgenerics.core.InactivityManager;
	import com.ab.apps.appgenerics.settings.XMLSettings;
	
	public class AppManager extends Object
	{
		/// APP MODES MANAGER
		private var _app_modes_manager:AppModesManager;
		
		/// APP LEVELS
		private var _SCREENSAVER_LEVEL:Sprite;
		private var _ALERT_LEVEL:Sprite;
		private var _APP_LEVEL:Sprite;
		private var _TOP_LEVEL:Sprite;
		private var _MENU_LEVEL:Sprite;
		private var _MAIN_LEVEL:Sprite;
		private var _BACK_LEVEL:Sprite;
		private var _BACKGROUND_LEVEL:Sprite;
		
		/// helper "state" vars
		private var _mode:String = "";
		private var _lang:String = "";
		public var PLAYING_VIDEO:Boolean=false;
		public var MOUSE_STATE:String = "UP"; // or "DOWN"
		
		/// INACTIVITY
		public var inactivityManager:InactivityManager;
		
		/// SCREENSAVER
		public var screenSaver_InactivityManager:InactivityManager;
		private var _screen_saver_set:Boolean=false;
		private var _screen_saver_on:Boolean=true;
		private var _screen_saver_active:Boolean=false;
		private var _screen_saver_time:Number=20000;
		private var _screen_saver_class:Class;
		
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
			
			_APP_LEVEL 			= applevel;
			_APP_CLASS 			= appClass;
			_app_modes_manager 	= new AppModesManager();
			
			createAppLevels();
			
			ColorShortcuts.init();
			FilterShortcuts.init();
			
			this._key = Key.getInstance();
			
			this._key.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP, 	mouseUpHandler);
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_DOWN,	mouseDownHandler);
		}
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APP LEVELS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APP LEVELS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APP LEVELS
		
		private function createAppLevels():void
		{
			_BACKGROUND_LEVEL	= new Sprite();
			_BACK_LEVEL  		= new Sprite();
			_MAIN_LEVEL  		= new Sprite();
			_MENU_LEVEL  		= new Sprite();
			_TOP_LEVEL   		= new Sprite();
			_ALERT_LEVEL 		= new Sprite();
			_SCREENSAVER_LEVEL 	= new Sprite();
			
			_APP_LEVEL.addChildAt(_BACKGROUND_LEVEL,	0);
			_APP_LEVEL.addChildAt(_BACK_LEVEL,  		1);
			_APP_LEVEL.addChildAt(_MAIN_LEVEL,  		2);
			_APP_LEVEL.addChildAt(_MENU_LEVEL,  		3);
			_APP_LEVEL.addChildAt(_TOP_LEVEL,   		4);
			_APP_LEVEL.addChildAt(_ALERT_LEVEL, 		5);
			_APP_LEVEL.addChildAt(_SCREENSAVER_LEVEL, 	6);
		}
		
		public function addApplicationClassToStage():void
		{
			trace ("AppManager ::: addApplicationClassToStage()");
			
			// here the "APP CLASS" is added in the "APP LEVEL";
			
			APP_INSTANCE = new _APP_CLASS();
			
			addChildToLevel(APP_INSTANCE, "MAIN");
			
			APP_INSTANCE.start();
		}
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// PLEASE WAIT MESSAGE
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// PLEASE WAIT MESSAGE
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// PLEASE WAIT MESSAGE
		
		public function setPleasewaitMessageClass(_class:Class):void
		{
			_please_wait_message_class 		= _class;
			_please_wait_message_class_set 	= true;
		}
		
		public function invokePleaseWaitMessage():void
		{
			if (_please_wait_message_class_set == true && _pleasewaitmessage == null)
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
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// MOUSE UP / DOWN REGISTRY
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// MOUSE UP / DOWN REGISTRY
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// MOUSE UP / DOWN REGISTRY
		
		private function mouseUpHandler(e:MouseEvent):void  	{ MOUSE_STATE = "UP";   };
		private function mouseDownHandler(e:MouseEvent):void  	{ MOUSE_STATE = "DOWN"; };
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// BASE KEY FUNCTIONS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// BASE KEY FUNCTIONS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// BASE KEY FUNCTIONS
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			//trace ("AppManager ::: keyDownHandler = " + e.keyCode);
			switch (e.keyCode) 
			{
				case Keyboard.F6:
					startScreenSaver();
				break;
				
				//case Keyboard.F8:
					// toggle Logger
				//break;
				
				case Keyboard.F9:
					XMLSettings.singleton.DEBUG_MODE = true;
					_app_modes_manager.mode = "debug"
				break;
				
				case Keyboard.F11:
					ScreenSettings.setFullScreen();
				break;
				
				case Keyboard.F12:
					ScreenSettings.setNormalScreen();
				break;
			}
		}
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION LEVELS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION LEVELS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION LEVELS
		
		/// create objects in specific application levels
		public function addChildToLevel(object:DisplayObject, level:String="MAIN", coordinates:Point=null):void
		{
			trace ("AppManager ::: addChildToLevel ::: LEVEL = " + level);
			
			if (object != null)
			{
				if (object is DisplayObject)
				{
					if (coordinates != null)  { object.x = coordinates.x; object.y = coordinates.y; };
					
					switch(level)
					{
						case "BACKGROUND":	_BACKGROUND_LEVEL.addChild(object);	  break;
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
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// SCREENSAVER
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// SCREENSAVER
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// SCREENSAVER
		
		public function setScreenSaver(_class:Class, _time:Number=20000):void
		{
			_screen_saver_class 		 = _class;	// given screensaver class must extend ApplicationScreensaver
			_screen_saver_time 			 = _time;
			
			if (_screen_saver_set != true) 
			{
				screenSaver_InactivityManager = new InactivityManager(_screen_saver_time, stopScreenSaver, startScreenSaver);
			}
			else
			{
				screenSaver_InactivityManager.die();
				
				screenSaver_InactivityManager = null;
				screenSaver_InactivityManager = new InactivityManager(_screen_saver_time, stopScreenSaver, startScreenSaver);
			}
			
			_screen_saver_set = true;
		}
		
		/// invoke screensaver
		public function startScreenSaver():void
		{
			if (_screen_saver_class != null && _screen_saver_set == true && _screen_saver_active == false)
			{
				screen_saver_active = true;
				
				var screensaver = new _screen_saver_class();
				
				addChildToLevel(screensaver, "SCREENSAVER");
			}
		}
		
		private function stopScreenSaver():void
		{
			if (_screen_saver_active == true) 
			{
				screen_saver_active = false;
				
				COREApi.dispatchEvent(new AppEvent(AppEvent.ACTIVITY_RESUMED, ""));
			}
		}
		
		/// getters // setters
		public function get screen_saver_set():Boolean 					{ return _screen_saver_set;  	};
		public function set screen_saver_set(value:Boolean):void  		{ _screen_saver_set = value; 	};
		public function get screen_saver_class():Class 					{ return _screen_saver_class;   };
		public function set screen_saver_class(value:Class):void  		{ _screen_saver_class = value;  };
		public function get screen_saver_time():Number 					{ return _screen_saver_time; 	};
		public function set screen_saver_time(value:Number):void  		{ _screen_saver_time = value; 	};
		public function get screen_saver_active():Boolean 			 	{ return _screen_saver_active;  };
		public function set screen_saver_active(value:Boolean):void  	{ _screen_saver_active = value; };
		public function get screen_saver_on():Boolean 					{ return _screen_saver_on; 		};
		public function set screen_saver_on(value:Boolean):void  		{ _screen_saver_on = value; 	};
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// INACTIVITY
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// INACTIVITY
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// INACTIVITY
		
		/// set up inactivity handler
		public function armInactivityAlert(time:Number):void
		{
			inactivityManager = new InactivityManager(time, inactivityEndedCommand, inactivityDetectedCommand);
		}
		
		/// action to perform on inactivity
		public function inactivityDetectedCommand():void
		{
			//trace ("AppManager ::: inactivityDetected ");
			COREApi.dispatchEvent(new AppEvent(AppEvent.INACTIVITY_DETECTED, ""));
		}
		
		/// action to perform on inactivity end
		public function inactivityEndedCommand():void
		{
			//trace ("AppManager ::: activityDetected ");
			COREApi.dispatchEvent(new AppEvent(AppEvent.ACTIVITY_RESUMED, ""));
		}
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION MODES
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION MODES
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION MODES
		
		public function addApplicationMode(mode_name:String, function_call:Function):void
		{
			_app_modes_manager.addMode(mode_name, function_call);
		}
		
		public function get mode():String  				{  return _app_modes_manager.mode; }
		public function set mode(value:String):void  	{ _app_modes_manager.mode = value; }
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// LANG
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// LANG
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// LANG
		
		public function get LANG():String 				{ return _lang; }
		public function set LANG(value:String):void 
		{
			if (_lang != value) 
			{
				_lang = value;
				
				COREApi.dispatchEvent(new AppEvent(AppEvent.LANG_CHANGE, value));
			}
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
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
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
	}
	
}