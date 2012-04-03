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
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/// libs
	import caurina.transitions.properties.CurveModifiers;
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.properties.FilterShortcuts;
	
	/// ab lib
	//import com.ab.core.ZipManager;
	import com.ab.utils.ContextMenuManager;
	import com.ab.events.CentralEventSystem;
	import com.ab.core.AppModesManager;
	import com.ab.events.AppEvent;
	import com.ab.events.ItemEvent;
	import com.ab.core.InactivityManager;
	
	public class AppManager
	{
		/// APP MODES MANAGER
		private static var _app_modes_manager:AppModesManager;
		
		/// APP LEVELS
		public static var app_level:Sprite;
		public static var logger_level:Sprite;
		public static var screensaver_level:Sprite;
		public static var alert_level:Sprite;
		public static var top_level:Sprite;
		public static var menu_level:Sprite;
		public static var main_level:Sprite;
		public static var back_level:Sprite;
		public static var background_level:Sprite;
		
		/// helper "state" vars
		private static var _mode:String = "";
		private static var _lang:String = "";
		public static var PLAYING_VIDEO:Boolean=false;
		public static var MOUSE_STATE:String = "UP"; // or "DOWN"
		
		/// INACTIVITY
		public static var inactivityManager:InactivityManager;
		
		/// SCREENSAVER
		public static var screenSaver_InactivityManager:InactivityManager;
		private static var _screen_saver_set:Boolean=false;
		private static var _screen_saver_on:Boolean=true;
		private static var _screen_saver_active:Boolean=false;
		private static var _screen_saver_time:Number=20000;
		private static var _screen_saver_class:Class;
		
		/// context menu manager
		private static var _context_menu_manager:ContextMenuManager;
		
		/// please wait message
		private static var _pleasewaitmessage:*;
		private static var _please_wait_message_class:Class;
		private static var _please_wait_message_class_set:Boolean=false;
		
		/// vector writing
		private static var _vectorWritingInitialized:Boolean = false;
		
		/// CORE instance
		public static var core:CORE;
		
		/// system ::: don't touch these
		public static var APP_INSTANCE:*;
		
		/// global vars
		public static var globalvars:Object;
		
		/// vector fonts manager
		public static var _vectorFontsManager:VectorFontsManager;
		
		/// stage
		public static var stage:Stage;
		
		/// zip
		//public static var zip_manager:ZipManager;
		
		public static function init(_stage:Stage, _applevel:Sprite, project_type:String="AS3"):void
		{
			stage 				= _stage;
			app_level 			= _applevel;
			
			/// create global vars object 
			globalvars 			= new Object();
			
			/// create application modes manager
			_app_modes_manager 	= new AppModesManager();
			
			//if (project_type.toUpperCase() == "AIR")  { zip_manager = new ZipManager(); }
			
			ColorShortcuts.init(); 	/// init color tweening
			FilterShortcuts.init();	/// init filters tweening
			CurveModifiers.init();	/// init bezier tweening
			
			stage.addEventListener(MouseEvent.MOUSE_UP, 	mouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,	mouseDownHandler);
		}
		
		//public function createZip(_files:Array, _text:String):void
		//{
			//if (zip_manager != null) 
			//{
				//zip_manager.createZIP(_files, _text);
			//}
			//else
			//{
				//trace("WARNING: ZipManager is null");
			//}
		//}
		
		public static function loadFonts():void 
		{
			/// create vector fonts manager
			_vectorFontsManager = new VectorFontsManager();
			_vectorFontsManager.init();
		}
		
		public static function writeVectorText(_graphics:Graphics, _text:String, _font:String, _colour:uint=0x00ff00, _size:Number=24, _leading:Number=0, _x:Number=0, _y:Number=0, _kerning:Number=0):void
		{
			if (_vectorWritingInitialized) 
			{
				_vectorFontsManager.write(_graphics, _text, _font, _colour, _size, _leading, _x, _y, _kerning);
			}
		}
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APP LEVELS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APP LEVELS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APP LEVELS
		
		public static function createAppLevels():void
		{
			background_level	= new Sprite();
			back_level  		= new Sprite();
			main_level  		= new Sprite();
			menu_level  		= new Sprite();
			top_level   		= new Sprite();
			alert_level 		= new Sprite();
			screensaver_level 	= new Sprite();
			logger_level	 	= new Sprite();
			
			app_level.addChildAt(background_level,	0);
			app_level.addChildAt(back_level,  		1);
			app_level.addChildAt(main_level,  		2);
			app_level.addChildAt(menu_level,  		3);
			app_level.addChildAt(top_level,   		4);
			app_level.addChildAt(alert_level, 		5);
			app_level.addChildAt(screensaver_level, 6);
			app_level.addChildAt(logger_level, 		7);
		}
		
		public static  function addContextMenuItem(caption:String, handler:Function, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true):void
		{
			_context_menu_manager.add(caption, handler, separatorBefore, enabled, visible);
		}
		
		//private static function applicationInstanceAddedToStageHandler(e:Event):void 
		//{
			//DisplayObject(APP_INSTANCE).removeEventListener(Event.ADDED_TO_STAGE, applicationInstanceAddedToStageHandler);
			//
			/// invoke the application's start method
			//APP_INSTANCE.start();
		//}
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// PLEASE WAIT MESSAGE
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// PLEASE WAIT MESSAGE
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// PLEASE WAIT MESSAGE
		
		public static function setPleasewaitMessageClass(_class:Class):void
		{
			_please_wait_message_class 		= _class;
			_please_wait_message_class_set 	= true;
		}
		
		public static function invokePleaseWaitMessage():void
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
		
		public static function closePleaseWaitMessage():void
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
		
		private static function mouseUpHandler(e:MouseEvent):void  		{ MOUSE_STATE = "UP";   };
		private static function mouseDownHandler(e:MouseEvent):void 	{ MOUSE_STATE = "DOWN"; };
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION LEVELS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION LEVELS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION LEVELS
		
		/// create objects in specific application levels
		public static function addChildToLevel(object:DisplayObject, level:String="MAIN", propsObj:Object=null):void
		{
			//trace ("AppManager ::: addChildToLevel ::: LEVEL = " + level);
			
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
						case "BACKGROUND":	background_level.addChild(object);	  	break;
						case "BACK":		back_level.addChild(object);		  	break;
						case "MAIN":		main_level.addChild(object);		  	break;
						case "MENU":		menu_level.addChild(object);		  	break;
						case "TOP":			top_level.addChild(object);		  		break;
						case "ALERT":		alert_level.addChild(object);		  	break;
						case "SCREENSAVER":	screensaver_level.addChild(object);  	break;
						case "LOGGER":		logger_level.addChild(object);  		break;
					}
				}
				else { trace ("ERROR: AppManager ::: addChildToLevel() -> PROVIDED OBJECT IS NOT A 	DISPLAYOBJECT"); }
			}
			else { trace ("ERROR: AppManager ::: addChildToLevel() -> PROVIDED OBJECT IS NULL"); }
		}
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// SCREENSAVER
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// SCREENSAVER
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// SCREENSAVER
		
		public static function setScreenSaver(_class:Class, _time:Number=20000):void
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
		public static function startScreenSaver():void
		{
			if (_screen_saver_class != null && _screen_saver_set == true && _screen_saver_active == false)
			{
				screen_saver_active = true;
				
				var screensaver:* = new _screen_saver_class();
				
				addChildToLevel(screensaver, "SCREENSAVER");
			}
		}
		
		private static function stopScreenSaver():void
		{
			if (_screen_saver_active == true) 
			{
				screen_saver_active = false;
				
				COREApi.dispatchEvent(new AppEvent(AppEvent.ACTIVITY_RESUMED, ""));
			}
		}
		
		/// getters // setters
		public static function get screen_saver_set():Boolean 					{ return _screen_saver_set;  	};
		public static function set screen_saver_set(value:Boolean):void  		{ _screen_saver_set = value; 	};
		public static function get screen_saver_class():Class 					{ return _screen_saver_class;   };
		public static function set screen_saver_class(value:Class):void  		{ _screen_saver_class = value;  };
		public static function get screen_saver_time():Number 					{ return _screen_saver_time; 	};
		public static function set screen_saver_time(value:Number):void  		{ _screen_saver_time = value; 	};
		public static function get screen_saver_active():Boolean 			 	{ return _screen_saver_active;  };
		public static function set screen_saver_active(value:Boolean):void  	{ _screen_saver_active = value; };
		public static function get screen_saver_on():Boolean 					{ return _screen_saver_on; 		};
		public static function set screen_saver_on(value:Boolean):void  		{ _screen_saver_on = value; 	};
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// INACTIVITY
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// INACTIVITY
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// INACTIVITY
		
		/// set up inactivity handler
		public static function armInactivityAlert(time:Number):void
		{
			inactivityManager = new InactivityManager(time, inactivityEndedCommand, inactivityDetectedCommand);
		}
		
		/// action to perform on inactivity
		public static function inactivityDetectedCommand():void
		{
			//trace ("AppManager ::: inactivityDetected ");
			COREApi.dispatchEvent(new AppEvent(AppEvent.INACTIVITY_DETECTED, ""));
		}
		
		/// action to perform on inactivity end
		public static function inactivityEndedCommand():void
		{
			//trace ("AppManager ::: activityDetected ");
			COREApi.dispatchEvent(new AppEvent(AppEvent.ACTIVITY_RESUMED, ""));
		}
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION MODES
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION MODES
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// APPLICATION MODES
		
		public static function addApplicationMode(mode_name:String, function_call:Function):void
		{
			_app_modes_manager.addMode(mode_name, function_call);
		}
		
		public static function get mode():String  				{  return _app_modes_manager.mode; };
		public static function set mode(value:String):void  	{ _app_modes_manager.mode = value; };
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// LANG
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// LANG
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// LANG
		
		public static function get LANG():String 				{ return _lang; };
		public static function set LANG(value:String):void 
		{
			if (_lang != value) 
			{
				_lang = value;
				
				COREApi.dispatchEvent(new AppEvent(AppEvent.LANG_CHANGE, value));
			}
		}
	}
	
}