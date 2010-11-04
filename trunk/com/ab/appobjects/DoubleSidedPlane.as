package com.ab.appobjects 
{
	/**
	* @author AB
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.display.geometry.PolygonQuad;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import uk.co.soulwire.display.PaperSprite;
	
	public class DoubleSidedPlane extends PaperSprite
	{
		private var _busy:Boolean=false;
		
		public function DoubleSidedPlane( __front:DisplayObject = null, __back:DisplayObject = null )
		{
			if (__front != null && __back != null)
			{
				back = __back;	front = __front;
			}
			
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			x = 200;
			y = 200;
		}
		
		public function flipRight(_time:Number=0.5, _transition:String="EaseOutSine"):void
		{
			if (!_busy) 
			{
				_busy = true;
				
				Tweener.addTween(this, { rotationY:this.rotationY-180, time:_time, transition:_transition, onComplete:setSystemFree } );
			}
		}
		
		public function flipLeft(_time:Number=0.5, _transition:String="EaseOutSine"):void
		{
			if (!_busy) 
			{
				_busy = true;
				
				Tweener.addTween(this, { rotationY:this.rotationY+180, time:_time, transition:_transition, onComplete:setSystemFree } );
			}
		}
		
		private function setSystemFree():void { _busy = false; }
		
		public function clickHandler(e:MouseEvent):void 
		{
			flipRight();
		}
		
	}
	
}