package com.ab.apps.appgenerics.core
{
	/**
	* @author ABº
	* http://www.antoniobrandao.com/
	* http://blog.antoniobrandao.com/
	* 
	* Keyboard manager instantiation
	* 
	* Dependencies: StageReference by CASALIB: ( http://casalib.org/ )
	* 
	* usage:
	* var keyboardManager = new KeyboardManager();
	* 
	* then you can start using the keys you define inside it
	*/
	
	/// flash
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/// libs
	import org.casalib.ui.Key
	
	/// ab lib
	import com.ab.apps.appgenerics.core.COREApi;
	
	public class KeyboardManager extends Object
	{
		/// keyboard
		protected var _key:Key;
		
		private static var __singleton:KeyboardManager;
		
		public function KeyboardManager()
		{
			setSingleton();
			
			this._key = Key.getInstance();
			this._key.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// BASE KEY FUNCTIONS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// BASE KEY FUNCTIONS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// BASE KEY FUNCTIONS
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			//trace ("KeyboardManager ::: keyDownHandler = " + e.keyCode);
			switch (e.keyCode) 
			{
				case Keyboard.F6:
					AppManager.singleton.startScreenSaver();
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
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null)  { return; }; //throw new Error("KeyboardManager ::: SINGLETON REPLICATION ATTEMPTED")
			__singleton = this;
		}
		public static function get singleton():KeyboardManager
		{
			if (__singleton == null) { throw new Error("KeyboardManager ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)") }
			return __singleton;
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
	}
	
}