﻿package com.ab.apps.abcms.mainmodules.browsers
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.ABSprite;
	import flash.events.Event;
	
	public class MediaBrowser extends ABSprite
	{
		
		public function MediaBrowser()
		{
		
		public function MainMenu() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true)
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler)
			
			initVars()
			
			start()
		}
		
		private function initVars():void
		{
			
		}
		
		private function start():void
		{
			/// uma entrada porreira
			
			/// create here
		}
		
	}
	
}