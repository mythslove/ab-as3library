package com.ab.core
{
	/**
	* @author ABº
	* http://www.antoniobrandao.com/
	* http://blog.antoniobrandao.com/
	* 
	* Keyboard manager instantiation
	* 
	* usage:
	* KeyboardManager.init();
	* 
	* then you can start using the keys you define inside it
	*/
	
	/// flash
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	/// ab lib
	import com.ab.core.COREApi;
	
	public class KeyboardManager extends Object
	{
		private static var _keysDown:Dictionary;
		private static var _keysTyped:Array;
		
		public static function init(_stage:Stage)
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, _onKeyUp);
			
			_keysDown     = new Dictionary();
			_keysTyped    = new Array();
		}
		
		/**
			Determines if is key is down.
			
			@param keyCode: The key code value assigned to a specific key or a Keyboard class constant associated with the key.
			@return Returns <code>true</code> if key is currently pressed; otherwise <code>false</code>.
		*/
		public static function isDown(keyCode:uint):Boolean 
		{
			return _keysDown[keyCode];
		}
		
		/**
			@sends KeyboardEvent#KEY_DOWN - Dispatched when the user presses a key.
		*/
		private static function _onKeyDown(e:KeyboardEvent):void 
		{
			_keysDown[e.keyCode] = true;
			
			dispatchEvent(e.clone());
			
			keyDownHandler(e.clone());
		}
		
		/**
			@sends KeyboardEvent#KEY_UP - Dispatched when the user releases a key.
		*/
		private static function _onKeyUp(e:KeyboardEvent):void 
		{
			delete _keysDown[e.keyCode];
			
			dispatchEvent(e.clone());
		}
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// BASE KEY FUNCTIONS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// BASE KEY FUNCTIONS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// BASE KEY FUNCTIONS
		
		private static function keyDownHandler(e:KeyboardEvent):void 
		{
			//trace ("KeyboardManager ::: keyDownHandler = " + e.keyCode);
			
			switch (e.keyCode) 
			{
				case Keyboard.F6:
					AppManager.startScreenSaver();
				break;
				
				case Keyboard.F8:
					/// assigned in logger as toggleVisibility
				break;
				
				case Keyboard.F9:
					//XMLSettings.singleton.DEBUG_MODE = true;
					COREApi.setApplicationMode(AppModes.DEBUG);
				break;
				
				case Keyboard.F11:
					ScreenSettings.setFullScreen();
				break;
				
				case Keyboard.F12:
					ScreenSettings.setNormalScreen();
				break;
				
				case Keyboard.UP:
					/// operation here
				break;
				case Keyboard.DOWN:
					/// operation here
				break;
				case Keyboard.LEFT:
					/// operation here
				break;
				case Keyboard.RIGHT:
					/// operation here
				break;
				
				case 49: /// key 0
					/// operation here
					trace("0")
				break;
				case 50: /// key 1
					trace("1")
				break;
				case 51: /// key 2
					trace("2")
				break;
				case 52: /// key 3
					trace("3")
				break;
				case 53: /// key 4
					trace("4")
				break;
				case 54: /// key 5
					trace("5")
				break;
				case 55: /// key 6
					trace("6")
				break;
				case 56: /// key 7
					trace("7")
				break;
				case 57: /// key 8
					trace("8")
				break;
				case 58: /// key 9
					trace("9")
				break;
			}
		}
		
	}
	
}