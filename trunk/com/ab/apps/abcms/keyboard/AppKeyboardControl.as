package com.ab.apps.abcms.keyboard 
{
	/**
	* @author ABº
	*/
	
	import com.ab.keyboard.KeyboardControl;
	import flash.ui.Keyboard;
	import com.ab.log.ABLogger;
	
	public class AppKeyboardControl extends KeyboardControl
	{
		
		public function AppKeyboardControl()
		{
			trace("AppKeyboardControl()")
		}
		
		override public function parseKey(code:int):void
		{
			switch (code) 
			{
				case 49: /// key 0
					/// operation here
					trace("a 0")
					ABLogger.getSingleton().echo("yeah")
				break;
				case 50: /// key 1
					/// operation here
					trace("s 1")
					ABLogger.getSingleton().echo("jkdlas lasldalsdj lask jdaklsj jkdlas lasldalsdj lask jdaklsj ")
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
		
	}
	
}