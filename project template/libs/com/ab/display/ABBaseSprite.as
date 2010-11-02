package com.ab.display
{
	/**
	* @author ABº
	*/
	
	import flash.display.Sprite;
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	
	public class ABBaseSprite extends CasaSprite
	{
		public function ABBaseSprite()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			start();
		}
		
		public function start():void
		{
			
		}
	}
}