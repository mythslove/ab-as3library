﻿package com.ab.apps.abcms.mainmodules.menu
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.ABSprite;
	import flash.events.Event;
	
	public class MainMenu extends ABSprite
	{
		
		public function MainMenu() 
		{
			initVars()
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true)
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler)
			
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