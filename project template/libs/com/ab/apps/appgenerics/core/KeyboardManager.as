package com.ab.apps.appgenerics.core
{
	/**
	* @author AB
	*/
	
	/// KEYBOARD MANAGER - FEATURES LIST
	
	/// Keyboard manager instantiation
	/// a few predefined keyboard shortcuts (ex: start screensaver / set debug mode / set fullscreen / set normal screen) room for more 
	
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
				
				//case Keyboard.F8:
					// toggle Logger
				//break;
				
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