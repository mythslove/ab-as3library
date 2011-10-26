package com.ab.core
{
	/**
	* @author ABº
	* 
	* Esta classe reúne todos os métodos essenciais das classes centrais numa API prática
	*/
	
	import com.ab.core.AppManager;
	import com.ab.display.FloatWarning;
	import com.ab.events.CentralEventSystem;
	import com.ab.log.Logger;
	import com.ab.settings.XMLSettings;
	import com.ab.swfaddress.SWFAddressManager;
	import com.ab.xml.XMLDataGetter;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import org.casalib.util.StageReference;
	import org.casalib.util.StringUtil;
	
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
		 * ACTIVATES SWFADDRESS HANDLING
		 * 
		 * @return	Nothing.
		 */
		public static function activateSWFAddress():void
		{
			SWFAddressManager.singleton.activate();
		}
		
		/**
		 * ADDS A SWFADDRESS SITUATION
		 * SWFAddress situations can invoke functions or create children in specific aplication levels.
		 * @return	Nothing.
		 */
		public static function addSWFAddress(_title:String, _address:String, _params:Object=null, _type:String="normal"):void
		{
			//trace("com.ab.core.COREApi.addSWFAddress > _title : " + _title + ", _address : " + _address + ", _params : " + _params + ", _type : " + _type);
			SWFAddressManager.singleton.addAddress(_title, _address, _params, _type);
		}
		
		/**
		 * GETS A PARAMETER from CURRENT SWFADDRESS
		 * 
		 * @return	String.
		 */
		public static function getSWFAddressParameterValue(parameter:String):String
		{
			var current_value:String	= StringUtil.remove(SWFAddressManager.singleton.getCurrentValue(), "/")
			var o:Object 				= new Object();
			var value:String 			= "";
			
			for each(var t:String in current_value.substr(0).split('&'))
			{
				var a:Array = t.split('=');
				o[a[0]] = a[1];
				
				if (a[0] == parameter) { value = a[1]; };
			}
			
			return value;
		}
		
		/**
		 * CHANGES THE SWFADDRESS TO A PRE-DEFINED ADDRESS
		 * The pre-defined address can be set using the "addSWFAddress" function above.
		 * @return	Nothing.
		 */
		public static function setSWFAddress(title:String, extra_params:Object = null):void
		{
			SWFAddressManager.singleton.setAddress(title, extra_params);
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
				if (XMLSettings.setting.DEBUG_MODE == true) 
				{
					Logger.singleton.log(s); 
				}
			}
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
		 * SET LANGUAGE
		 * @return	Nothing.
		 */
		public static function set language(_lang:String):void
		{
			AppManager.singleton.LANG = _lang; 
		}
		
		/**
		 * GET LANGUAGE
		 * @return	Nothing.
		 */
		public static function get language():String
		{
			return AppManager.singleton.LANG;
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
		 * HAS EVENT LISTENER
		 * Checks wether a certain Event handler is registered in the central event system.
		 * @param	Event
		 * @return	Boolean
		 */
		public static function hasEventListener(e:*):Boolean
		{
			return CentralEventSystem.singleton.hasEventListener(e);
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
			switch (XMLSettings.setting.PROJECT_TYPE) 
			{
				case "AIR":
					StageReference.getStage().displayState = "fullScreenInteractive";
				break;
				case "AS3":
					StageReference.getStage().displayState = "fullScreen";
				break;
			}
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
		 * Load XML data from a file
		 * Retrieves XML data from given URL and returns the XML data object to a provided function
		 * @return	Nothing.
		 */
		public static function getXMLdata(xml_path:String, return_function:Function):void
		{
			XMLDataGetter.singleton.getDataXML(xml_path, return_function);
		}
		
		/**
		 * Load XML data from a file. Optionally returns the XML data object to a provided function
		 * Also optionally save it in a reusable data object
		 * 
		 * @return	Nothing.
		 */
		public static function addXMLDataObject(xml_path:String, return_function:Function=null, id:String="none"):void
		{
			DataManager.singleton.getXMLDataEnhanced(xml_path, return_function, id);
		}
		
		/**
		 * Retrieves a XML data object from DataManager
		 * 
		 * @return	XML object.
		 */
		public static function getXMLDataObject(id:String):XML
		{
			return DataManager.singleton.getXMLDataObject(id);
		}
		
		/**
		 * Load data object from DataManager
		 * 
		 * @return	Nothing.
		 */
		public static function requestDataObjectData(id:String):Object
		{
			return DataManager.singleton.requestDataObjectData(id);
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
		 * Show the current Stack information in the outputpanel without throwing an Error
		 * @return	Nothing.
		 */
		public static function traceStack():void
		{
			var e:Error = new Error("Stack Trace");
			
			trace("---------------------------------------------");
			trace("---------------- Stack Trace ----------------");
			trace("---------------------------------------------");
			trace(e.getStackTrace());
			trace("---------------------------------------------");
			trace("---------------------------------------------");
			trace("---------------------------------------------");
		}
		
		//
		 //* Creates a ZIP file to be saved to disk
		 //* Provide an array of files and a message to be displayed in the save dialog
		 //* @return	Nothing.
		 //*/
		//public static function createZipFile(_files:Array, _text:String="Please include '.ZIP' in the end of the filename"):void
		//{
			//AppManager.singleton.createZip(_files, _text);
		//}
		
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
		
		/**
		 * Global Vars object acess
		 * This method provides direct access to the Global Vars object
		 * @return	Options object.
		 */
		public static function get globalvars():Object
		{
			return AppManager.singleton.globalvars;
		}
		
	}
	
}