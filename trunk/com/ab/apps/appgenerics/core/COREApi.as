package com.ab.apps.appgenerics.core 
{
	/**
	* @author ABº
	* 
	* Esta classe reúne todos os métodos essenciais das classes centrais numa API prática
	*/
	
	import com.ab.apps.appgenerics.core.DataManager;
	import com.ab.apps.appgenerics.core.AppManager;
	import com.ab.apps.appgenerics.core.ScreenSettings;
	import com.ab.apps.appgenerics.core.InactivityManager;
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.events.CentralEventSystem;
	import com.ab.display.FloatWarning;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.geom.Point;
	import com.ab.log.Logger;
	import org.casalib.util.StageReference;
	
	public class COREApi
	{
		public static const LEVEL_BACK:String 		 = "BACK";
		public static const LEVEL_MAIN:String 		 = "MAIN";
		public static const LEVEL_MENU:String 		 = "MENU";
		public static const LEVEL_TOP:String  		 = "TOP";	
		public static const LEVEL_ALERT:String  	 = "ALERT";	
		public static const LEVEL_SCREENSAVER:String = "SCREENSAVER";	
		
		/**
		 * OBJECT CREATION IN LEVELS
		 * Adds a DisplayObject to a chosen Application Level. Default Application Level is "MAIN" and coordinates are optional.
		 * @param	child
		 * @param	level
		 * @param 	coordinates
		 * @return	Nothing.
		 */
		public static function addChildToLevel(child:DisplayObject, level:String="MAIN", coordinates:Point=null):void
		{
			if (child != null) 
			{
				if (child is DisplayObject) 
				{
					if (coordinates != null)   { child.x = coordinates.x; child.y = coordinates.y; }
					
					AppManager.singleton.addChildToLevel(child, level, coordinates);
				}
				else
				{
					trace("< ERROR > COREApi ::: addChildToLevel() ::: PROVIDED OBJECT IS NOT DISPLAYOBJECT"); 
				}
			}
			else 
			{ 
				trace("< ERROR > COREApi ::: addChildToLevel() ::: Object is NULL or not specified"); 
			}	
		}
		
		/**
		 * LOGGING TOOL
		 * Adds a log message to the Logger's window.
		 * @param	some_string
		 * @return	Nothing.
		 */
		public static function log(s:*):void
		{
			if (s) 
			{
				Logger.singleton.log(s); 
			} 
			else {  trace("< ERROR > COREApi ::: log() ::: String invalid or not specified"); }
		}
		
		/**
		 * SCREENSAVER
		 * Sets the class to be used as screensaver in the application. The class should listen to the event AppEvent.ACTIVITY_DETECTED to close.
		 * @param	_class
		 * @param	_active
		 * @param 	_time
		 * @return	Nothing.
		 */
		public static function setScreenSaver(_class:*, _active:Boolean=true, _time:Number=NaN):void
		{
			if (_class != null) 
			{ 
				AppManager.singleton.setScreenSaver(_class, _active, _time); 
			}			
			else  {  trace("< ERROR > COREApi ::: setScreenSaver() ::: Provided class NULL or not specified");  }
		}
		
		/**
		 * Sets the screen saver on.
		 */
		public static function setScreenSaverOn():void	{ AppManager.singleton.SCREEN_SAVER_ACTIVE = true;   };
		
		/**
		 * Sets the screen saver off.
		 */
		public static function setScreenSaverOff():void { AppManager.singleton.SCREEN_SAVER_ACTIVE = false;  };
		
		/**
		 * SHOW WARNING
		 * Displays a warning on top of everything (in the ALERT_LEVEL)
		 * @param	message
		 * @param	type
		 * @param 	time
		 * @return	Nothing.
		 */
		public static function showWarning(message:String, type:String="normal", time:Number=2):void
		{
			// "normal" or "error" types may be used
			var warning:FloatWarning = new FloatWarning(message, type, time);
			
			addChildToLevel(warning, LEVEL_ALERT);
		}
		
		/**
		 * DISPATCH EVENT
		 * Dispatches an event through the com.ab.events.CentralEventSystem. Only listeners registered in the same CentralEventSystem can receive the events.
		 * @param	event
		 * @return	Nothing.
		 */
		public static function dispatchEvent(e:*=null):void
		{
			if (e != null) { CentralEventSystem.singleton.dispatchEvent(e); }
		}
		
		/**
		 * SET FULLSCREEN
		 * Sets the screen mode to Full Screen.
		 * @return	Nothing.
		 */
		public static function setFullscreen():void
		{
			StageReference.getStage().displayState = StageDisplayState.FULL_SCREEN;
		}
		
		/**
		 * SET NORMAL SCREEN
		 * Sets the screen mode to Normal.
		 * @return	Nothing.
		 */
		public static function setNormalScreen():void
		{
			StageReference.getStage().displayState = StageDisplayState.NORMAL;
		}
	}
	
}

/*
	//COREApi.createSection(EmpresaSection, CoreAPI.LEVEL_MAIN);
	//COREApi.createSection(EmpresaSection, CoreAPI.LEVEL_MAIN, "path/to/section", true, {x:100, y:200, alpha:0.5} );
	//
	//COREApi.gotoSection(EmpresaSection);
	//
	//COREApi.setSWFAddress("path/to/section");
	//COREApi.setSWFAddress("path/to/section", null, true);
	//COREApi.setSWFAddress("path/to/section", {param1:"blah", param2:"blah2"});
	//COREApi.setSWFAddressParameter("param1", "blah3");
	//
	//COREApi.getSWFAddress();
	//COREApi.getSWFAddressParameters().param1;
	//
	//COREApi.addChildToLevel(CloseButton, CoreAPI.LEVEL_MAIN, { x:10, y:10, alpha:0.1, cacheAsBitmap:true } );
	//
	//COREApi.log();
*/
