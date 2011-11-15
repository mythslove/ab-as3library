package com.ab.display 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import org.casalib.display.CasaSprite;
	
	public class SmartStageSprite extends CasaSprite
	{
		public var closed:Boolean = false;
		public var init_pos:Point;
		
		public function SmartStageSprite() 
		{
			addEventListener(Event.ADDED_TO_STAGE, 		addedInitPosSaverHandler);
			addEventListener(Event.ADDED_TO_STAGE, 		addedHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, 	removedHandler);
			stage.addEventListener(Event.RESIZE, 		resizeHandler);
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			init_pos = new Point(this.x, this.y);
			
			onStage();
		}
		
		private function removedHandler(e:Event):void 
		{
			offStage();
			
			closed = true;
			
			stage.removeEventListener(Event.RESIZE, 		resizeHandler);
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