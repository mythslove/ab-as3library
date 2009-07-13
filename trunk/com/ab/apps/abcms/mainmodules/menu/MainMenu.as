package com.ab.apps.abcms.mainmodules.menu
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.ABSprite;
	import com.ab.menu.SideTabMenu;
	import flash.events.Event;
	
	public class MainMenu extends SideTabMenu
	{
		
		public function MainMenu() 
		{
			initVars()
			
			//this.addEventListener(Event.ENTER_FRAME, test)
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true)
		}
		
		//private function test(e:Event):void 
		//{
			//trace("MainMenu ::: this.y = " + this.y)
		//}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler)
			
			//trace("main menu added to stage _custom_height = " + _custom_height) 
			
			start()
		}
		
		private function initVars():void
		{
			
		}
		
		private function start():void
		{
			/// uma entrada porreira
			
			/// create here main menu centered	
			
			
		}
		
	}
	
}