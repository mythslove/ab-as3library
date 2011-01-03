package com.ab.core
{
	/**
	* @author AB
	*/
	
	/// APP MANAGER - FEATURES LIST
	
	/// APPLICATION LEVELS construction & management
	/// instantiation of APPLICATION MODES manager
	/// initialization of ColorShortcuts and FilterShortcuts
	/// Vector Fonts manager
	/// "please wait message" handling
	/// screensaver system
	/// inactivity system
	/// var for app LANG && LANG_CHANGE event dispatching on LANG change
	/// var for mouse state (up/down)
	/// some other useful "state" vars
	
	/// flash
	import caurina.transitions.properties.CurveModifiers;
	import com.ab.utils.ContextMenuManager;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/// libs
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.properties.FilterShortcuts;
	import org.casalib.util.StageReference;
	
	/// ab lib
	//import com.ab.log.Logger;
	import com.ab.events.CentralEventSystem;
	import com.ab.core.AppModesManager;
	import com.ab.events.AppEvent;
	import com.ab.events.ItemEvent;
	import com.ab.core.InactivityManager;
	
	public class AppManager extends Object
	{
		/// APP MODES MANAGER
		private var _app_modes_manager:AppModesManager;
		
		/// APP LEVELS
		private var _LOGGER_LEVEL:Sprite;
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
		
		/// context menu manager
		private var _context_menu_manager:ContextMenuManager;
		
		/// please wait message
		private var _pleasewaitmessage:*;
		private var _please_wait_message_class:Class;
		private var _please_wait_message_class_set:Boolean=false;
		
		/// CORE instance
		private var _core:CORE;
		
		/// Vector Fonts Manager
		private var _vectorFontsManager:VectorFontsManager;
		
		/// system ::: don't touch these
		public var APP_INSTANCE:*;
		private var _APP_CLASS:Class;
		
		/// Temporary Object
		private var _globalvars:Object = new Object();
		
		/// singleton
		private static var __singleton:AppManager;
		
		public function AppManager(applevel:Sprite, appClass:Class)
		{
			setSingleton();
			
			_APP_LEVEL 			= applevel;
			_APP_CLASS 			= appClass;
			
			/// create application modes manager
			_app_modes_manager 	= new AppModesManager();
			
			/// create vector fonts manager
			_vectorFontsManager = new VectorFontsManager();
			_vectorFontsManager.init();
			
			ColorShortcuts.init(); 	/// init color tweening
			FilterShortcuts.init();	/// init filters tweening
			CurveModifiers.init();	/// init bezier tweening
			
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP, 	mouseUpHandler);
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_DOWN,	mouseDownHandler);
		}
		
		public function writeVectorText(_graphics:Graphics, _text:String, _font:String, _colour:uint=0x00ff00, _size:Number=24, _leading:Number=0, _x:Number=0, _y:Number=0, _kerning:Number=0):void
		{
			_vectorFontsManager.write(_graphics, _text, _font, _colour, _size, _leading, _x, _y, _kerning);
		}
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APP LEVELS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APP LEVELS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APP LEVELS
		
		private function createAppLevels(app_instance:DisplayObjectContainer):void
		{
			_BACKGROUND_LEVEL	= new Sprite();
			_BACK_LEVEL  		= new Sprite();
			_MAIN_LEVEL  		= new Sprite();
			_MENU_LEVEL  		= new Sprite();
			_TOP_LEVEL   		= new Sprite();
			_ALERT_LEVEL 		= new Sprite();
			_SCREENSAVER_LEVEL 	= new Sprite();
			_LOGGER_LEVEL	 	= new Sprite();
			
			app_instance.addChildAt(_BACKGROUND_LEVEL,	0);
			app_instance.addChildAt(_BACK_LEVEL,  		1);
			app_instance.addChildAt(_MAIN_LEVEL,  		2);
			app_instance.addChildAt(_MENU_LEVEL,  		3);
			app_instance.addChildAt(_TOP_LEVEL,   		4);
			app_instance.addChildAt(_ALERT_LEVEL, 		5);
			app_instance.addChildAt(_SCREENSAVER_LEVEL, 6);
			app_instance.addChildAt(_LOGGER_LEVEL, 		7);
		}
		
		public function addApplicationClassToStage():void
		{
			trace ("AppManager ::: addApplicationClassToStage()");
			
			/// create an instance of the main application class
			APP_INSTANCE = new _APP_CLASS();
			
			/// create the application levels within the application instance
			createAppLevels(APP_INSTANCE);
			
			/// wait until the application instance is added to stage to invoke it's start method
			DisplayObject(APP_INSTANCE).addEventListener(Event.ADDED_TO_STAGE, applicationInstanceAddedToStageHandler);
			
			/// create context menu manager in application instance
			_context_menu_manager = new ContextMenuManager(APP_INSTANCE);
			
			/// add the instance of the main application class to the stage
			_APP_LEVEL.addChild(APP_INSTANCE);
		}
		
		public function addContextMenuItem(caption:String, handler:Function, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true):void
		{
			_context_menu_manager.add(caption, handler, separatorBefore, enabled, visible);
		}
		
		private function applicationInstanceAddedToStageHandler(e:Event):void 
		{
			DisplayObject(APP_INSTANCE).removeEventListener(Event.ADDED_TO_STAGE, applicationInstanceAddedToStageHandler);
			
			/// invoke the application's start method
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
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION LEVELS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION LEVELS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION LEVELS
		
		/// create objects in specific application levels
		public function addChildToLevel(object:DisplayObject, level:String="MAIN", propsObj:Object=null):void
		{
			trace ("AppManager ::: addChildToLevel ::: LEVEL = " + level);
			
			if (object != null)
			{
				if (object is DisplayObject)
				{
					for (var property:String in propsObj)
					{
						if (object.hasOwnProperty(property))  { object[property] = propsObj[property]; }
					}
					
					switch(level)
					{
						case "BACKGROUND":	_BACKGROUND_LEVEL.addChild(object);	  	break;
						case "BACK":		_BACK_LEVEL.addChild(object);		  	break;
						case "MAIN":		_MAIN_LEVEL.addChild(object);		  	break;
						case "MENU":		_MENU_LEVEL.addChild(object);		  	break;
						case "TOP":			_TOP_LEVEL.addChild(object);		  	break;
						case "ALERT":		_ALERT_LEVEL.addChild(object);		  	break;
						case "SCREENSAVER":	_SCREENSAVER_LEVEL.addChild(object);  	break;
						case "LOGGER":		_LOGGER_LEVEL.addChild(object);  		break;
					}
				}
				else { trace ("ERROR: AppManager ::: addChildToLevel() -> PROVIDED OBJECT IS NOT A 	DISPLAYOBJECT"); }
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
				
				var screensaver:* = new _screen_saver_class();
				
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
			if (__singleton != null)  { return; }; //throw new Error("AppManager ::: SINGLETON REPLICATION ATTEMPTED")
			__singleton = this;
		}
		public static function get singleton():AppManager
		{
			if (__singleton == null) { throw new Error("AppManager ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)") }
			return __singleton;
		}
		
		public function get core():CORE 			{ return _core;  }
		public function set core(value:CORE):void  	{ _core = value; }
		
		public function get globalvars():Object 			{ return _globalvars; }
		public function set globalvars(value:Object):void  	{ _globalvars = value; }
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
	}
	
}