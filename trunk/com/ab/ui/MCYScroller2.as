package com.ab.ui 
{
	
	/**
	* ...
	* @author ABº
	* 
	* A clip in the library is required - associated with this class
	* 
	*/
	
	import com.edigma.display.EdigmaSprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System
	//import com.ab.utils.DebugTF
	import com.ab.utils.Move
	import caurina.transitions.Tweener
	import org.casalib.util.StageReference
	import flash.display.Stage
	
	public class MCYScroller2 extends EdigmaSprite
	{
		private var _PERCENT:Number;
		private var _TARGET_CLIP:Object;
		private var rectangle:Rectangle;
		private var fx:Number;
		
		private var _TARGET_FINAL_X:Number;
		private var _TOTAL_SCROLL_V_DISTANCE:Number;
		private var _TARGET_HEIGHT:Number;
		private var _VISIBLE_HEIGHT:Number;
		private var _TARGET_MIN_Y:Number;
		private var _MIN_SCROLLER_Y:Number;
		private var _MAX_SCROLLER_Y:Number;
		private var _TARGET_MAX_Y:Number;
		private var indent:Number;
		private var _stage:StageReference;
		
		public function MCYScroller2(target_clip:Object, scroll_distance:Number, visible_height:Number)
		{
			super();
			
			_TARGET_CLIP = target_clip
			_VISIBLE_HEIGHT = visible_height// - 20
			
			_TARGET_MIN_Y = _TARGET_CLIP.y
			_TARGET_MAX_Y = _TARGET_MIN_Y - target_clip.height + _VISIBLE_HEIGHT
			
			_TARGET_HEIGHT = _TARGET_CLIP.height
			
			_MAX_SCROLLER_Y = scroll_distance - this.height // maximo y da scroll handle
			
			_TOTAL_SCROLL_V_DISTANCE = scroll_distance - this.height // altura total de movimento da scroll handle
		}
		
		public function init():void
		{
			_MIN_SCROLLER_Y = this.y
			
			indent = _MAX_SCROLLER_Y - _MIN_SCROLLER_Y
			
			this.buttonMode = true;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, clickHandle); 
			
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP, releaseHandle);
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheelHandler);
		}
		
		public function mouseWheelHandler(event:MouseEvent):void 
		{
			trace("_MAX_SCROLLER_Y = " + _MAX_SCROLLER_Y)
			trace("this.y = " + this.y)
			
			trace("event.delta = " + event.delta)
			
			if (event.delta < 0) 
			{
				if (this.y < _TOTAL_SCROLL_V_DISTANCE)
				{
					this.y -= (event.delta * 2);
					
					if (this.y > _TOTAL_SCROLL_V_DISTANCE)
					{
						this.y = _TOTAL_SCROLL_V_DISTANCE;
					}
				}
			} 
			else 
			{
				if (this.y > _MIN_SCROLLER_Y) 
				{
					this.y -= (event.delta * 2);
					
					if (this.y < _MIN_SCROLLER_Y) 
					{
						this.y = _MIN_SCROLLER_Y;
					}
				}
			}
		}
		
		public function deActivate():void
		{
			this.buttonMode = false;
			this.removeEventListener(MouseEvent.MOUSE_DOWN, clickHandle); 
			stage.removeEventListener(MouseEvent.MOUSE_UP, releaseHandle);
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler); 
		}
		
		public function reActivate():void
		{
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN, clickHandle); 
			stage.addEventListener(MouseEvent.MOUSE_UP, releaseHandle);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function clickHandle(e:MouseEvent) 
		{
			rectangle = new Rectangle(this.x, _MIN_SCROLLER_Y, 0, _TOTAL_SCROLL_V_DISTANCE);
			this.startDrag(false, rectangle	);
		}
		
		private function releaseHandle(e:MouseEvent) 
		{
			this.stopDrag();
		}
		
		private function enterFrameHandler(e:Event)
		{
			positionContent();
		}
		
		public  function gotoZero():void
		{
			Move.ToPositionY(this, _MIN_SCROLLER_Y, 0.2)
		}
		
		private function positionContent():void
		{
			var downY:Number;
			var curY:Number;
			
			_PERCENT = (100 / indent) * (this.y - _MIN_SCROLLER_Y);
			
			downY = _TARGET_CLIP.height - (_VISIBLE_HEIGHT / 2)
			
			_TARGET_FINAL_X = _TARGET_MIN_Y - (((downY - (_VISIBLE_HEIGHT / 2)) / 100) * _PERCENT); 
			
			var final_value:Number = _TARGET_CLIP.y;
			
			if (_TARGET_CLIP.y != _TARGET_FINAL_X) 
			{
				var diff:Number = _TARGET_FINAL_X - _TARGET_CLIP.y;
				
				final_value += diff / 4;
			}
			
			_TARGET_CLIP.y = Math.floor(final_value)
		}	
	}
}