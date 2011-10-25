package com.ab.display 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.casalib.display.CasaMovieClip;
	import org.casalib.display.CasaSprite;
	
	public class SmartStageMovieClip extends CasaMovieClip
	{
		public function SmartStageMovieClip() 
		{
			addEventListener(Event.ADDED_TO_STAGE, 		addedHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, 	removedHandler);
			
			if (stage) 
			{
				stage.addEventListener(Event.RESIZE, 		resizeHandler);
			}
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			onStage();
		}
		
		private function removedHandler(e:Event):void 
		{
			offStage();
			
			if (stage) 
			{
				stage.removeEventListener(Event.RESIZE, 	resizeHandler);
			}
			
			removeEventListener(Event.REMOVED_FROM_STAGE, 	removedHandler);
		}
		
		public function onStage():void
		{
			/// override
		}
		
		public function offStage():void 
		{
			/// override
		}
		
		private function resizeHandler(e:Event):void 
		{
			onResize();
		}
		
		public function onResize():void 
		{
			/// override
		}
		
	}

}