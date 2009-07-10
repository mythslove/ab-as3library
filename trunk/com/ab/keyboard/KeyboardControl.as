package com.ab.keyboard
{
	/**
	* @author ABº
	* http://www.antoniobrandao.com/
	* http://blog.antoniobrandao.com/
	* 
	* This class initializes keyboard control
	* 
	* Dependencies: StageReference by CASALIB: ( http://casalib.org/ )
	* 
	* 
	* usage:
	* 
	* var lalala = new KeyboardControl();
	* 
	* then you can start using the keys you define inside it
	*/
	
	import flash.ui.Keyboard
	import flash.events.KeyboardEvent;
	import org.casalib.ui.Key;
	import flash.display.Sprite;
	
	public class KeyboardControl extends Sprite
	{
		/// private
		protected var _key:Key;
		
		/// public
		public static var __singleton:KeyboardControl;
		
		public function KeyboardControl()
		{
			setSingleton();
			
			this._key = Key.getInstance();
			
			this._key.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler)
		}
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			trace ("KeyboardControl ::: keyDownHandler = " + e.keyCode); 
			
			switch (e.keyCode) 
			{
				case 49: /// key 0
					/// operation here
				break;
				case 50: /// key 1
					/// operation here
				break;
				case 51: /// key 2
					/// operation here
				break;
				case 52: /// key 3
					/// operation here
				break;
				case 53: /// key 4
					/// operation here
				break;
				case 54: /// key 5
					/// operation here
				break;
				case 55: /// key 6
					/// operation here
				break;
				case 56: /// key 7
					/// operation here
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
			}
		}
		
		public function start()
		{
			trace ("KeyboardControl ::: start()");
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("KeyboardControl ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function getSingleton():KeyboardControl
		{
			if (__singleton == null)
			{
				throw new Error("KeyboardControl ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)")
			}
			
			return __singleton;
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}
	
}