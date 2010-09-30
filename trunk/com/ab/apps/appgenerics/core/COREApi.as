package com.ab.apps.appgenerics.core 
{
	/**
	* @author ABº
	* 
	* Esta classe reúne todos os métodos essenciais das classes centrais numa API prática
	*/
	
	import com.ab.apps.appgenerics.core.AppManager;
	import com.ab.display.FloatWarning;
	import com.ab.events.CentralEventSystem;
	import com.ab.log.Logger;
	import com.ab.xml.XMLDataGetter;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import org.casalib.util.StageReference;
	
	public class COREApi
	{
		public static const LEVEL_BACKGROUND:String  	= "BACKGROUND";
		public static const LEVEL_BACK:String 		 	= "BACK";
		public static const LEVEL_MAIN:String 		 	= "MAIN";
		public static const LEVEL_MENU:String 		 	= "MENU";
		public static const LEVEL_TOP:String  		 	= "TOP";	
		public static const LEVEL_ALERT:String  	 	= "ALERT";	
		public static const LEVEL_SCREENSAVER:String 	= "SCREENSAVER";	
		public static const LEVEL_LOGGER:String 		= "LOGGER";	
		
		/**
		 * ADD APPLICATION MODE
		 * Adds an application mode to the ApplicationModesManager.
		 * Each mode is identified by a string and handled by a given function.
		 * @return	Nothing.
		 */
		public static function addApplicationMode(mode_name:String, function_call:Function):void
		{
			AppManager.singleton.addApplicationMode(mode_name, function_call);
		}
		
		/**
		 * SET APPLICATION MODE
		 * Sets the application to a specified mode.
		 * Each mode must be already set using the "setApplicationMode" method.
		 * @return	Nothing.
		 */
		public static function setApplicationMode(mode_name:String):void
		{
			AppManager.singleton.mode = mode_name;
		}
		
		/**
		 * OBJECT CREATION IN LEVELS
		 * Adds a DisplayObject to a chosen Application Level. Default Application Level is "MAIN" and coordinates are optional.
		 * @param	child
		 * @param	level
		 * @param 	coordinates
		 * @return	Nothing.
		 */
		public static function addChildToLevel(child:DisplayObject, level:String="MAIN", propsObj:Object=null):void
		{
			if (child != null) 
			{
				if (child is DisplayObject) 
				{
					AppManager.singleton.addChildToLevel(child, level, propsObj);
				}
				else { trace("< ERROR > COREApi ::: addChildToLevel() ::: PROVIDED OBJECT IS NOT A DISPLAYOBJECT");  }
			}
			else { trace("< ERROR > COREApi ::: addChildToLevel() ::: DisplayObject is NULL or not specified");  }	
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
		 * @param 	_time
		 * @return	Nothing.
		 */
		public static function setScreenSaver(_class:*, _time:Number=NaN):void
		{
			if (_class != null) 
			{ 
				AppManager.singleton.setScreenSaver(_class, _time); 
			}			
			else  {  trace("< ERROR > COREApi ::: setScreenSaver() ::: Provided class NULL or not specified");  }
		}
		
		/**
		 * Sets the screen saver on.
		 */
		public static function setScreenSaverOn():void	{ AppManager.singleton.screen_saver_on = true;   };
		
		/**
		 * Sets the screen saver off.
		 */
		public static function setScreenSaverOff():void { AppManager.singleton.screen_saver_on = false;  };
		
		/**
		 * ADD EVENT LISTENER
		 * Registers an event listener in com.ab.events.CentralEventSystem.
		 * Only Events dispatched by the same CentralEventSystem will be received.
		 * @param	event
		 * @param	listener function
		 * @return	Nothing.
		 */
		public static function addEventListener(e:*, listener_function:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			CentralEventSystem.singleton.addEventListener(e, listener_function, useCapture, priority, useWeakReference);
		}
		
		/**
		 * REMOVE EVENT LISTENER
		 * Removes an event listener previously added in com.ab.events.CentralEventSystem.
		 * @param	event
		 * @param	listener function
		 * @return	Nothing.
		 */
		public static function removeEventListener(e:*, listener_function:Function):void
		{
			CentralEventSystem.singleton.removeEventListener(e, listener_function);
		}
		
		/**
		 * DISPATCH EVENT
		 * Dispatches an event through the com.ab.events.CentralEventSystem.
		 * Only listeners registered in the same CentralEventSystem receive the events.
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
		
		/**
		 * SHOW WARNING
		 * Displays a warning on top of everything (in the ALERT_LEVEL)
		 * @param	message
		 * @param	type
		 * @param 	time
		 * @return	Nothing.
		 */
		public static function showWarning(message:String, type:String="type_normal", origin:String="origin_top", time:Number=2, bg_colour:uint=0x000000):void
		{
			// "normal" or "error" types may be used
			var warning:FloatWarning = new FloatWarning(message, type, origin, time, bg_colour);
			
			addChildToLevel(warning, LEVEL_ALERT);
		}
		
		/**
		 * SET "PLEASE WAIT MESSAGE"
		 * Defines a class to be used when calling the "please wait" method.
		 * @return	Nothing.
		 */
		public static function setPleasewaitMessageClass(_class:Class):void
		{
			AppManager.singleton.setPleasewaitMessageClass(_class);
		}
		
		/**
		 * INVOKE "PLEASE WAIT MESSAGE"
		 * Creates a "pease wait message" instance, if there isn't one active.
		 * @return	Nothing.
		 */
		public static function invokePleaseWaitMessage():void
		{
			AppManager.singleton.invokePleaseWaitMessage();
		}
		
		/**
		 * CLOSE "PLEASE WAIT MESSAGE"
		 * Closes and destroys the "please wait message" instance, if there is one active.
		 * @return	Nothing.
		 */
		public static function closePleaseWaitMessage():void
		{
			AppManager.singleton.closePleaseWaitMessage();
		}
		
		/**
		 * Extract XML data from a file
		 * Retrieves XML data from given URL and returns the XML data object to a provided function
		 * @return	Nothing.
		 */
		public static function getXMLdata(xml_path:String, return_function:Function):void
		{
			XMLDataGetter.singleton.getDataXML(return_function, xml_path);
		}
		
		/**
		 * Insert custom ContexTMenu items in the application
		 * The handler function is mandatory
		 * @return	Nothing.
		 */
		public static function addContextMenuItem(caption:String, handler:Function, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true):void
		{
			AppManager.singleton.addContextMenuItem(caption, handler, separatorBefore, enabled, visible);
		}
		
		/**
		 * Draw vectorial text into a DisplayObject's graphics property
		 * This method works in conjunction with the AppManager's _vectorialTextManager instance
		 * @return	Nothing.
		 */
		public static function writeVectorText(_graphics:Graphics, _text:String, _font:String, _colour:uint=0x00ff00, _size:Number=24, _leading:Number=0, _x:Number=0, _y:Number=0, _kerning:Number=0):void
		{
			AppManager.singleton.writeVectorText(_graphics, _text, _font, _colour, _size, _leading, _x, _y, _kerning);
		}
		
		/**
		 * CORE instance acess
		 * This method provides direct access to the central instance of CORE
		 * @return	CORE instance.
		 */
		public static function get core():CORE
		{
			return AppManager.singleton.core;
		}
		
		/**
		 * Stage acess
		 * This method provides direct access to the stage
		 * @return	stage.
		 */
		public static function get stage():Stage
		{
			return StageReference.getStage();
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
