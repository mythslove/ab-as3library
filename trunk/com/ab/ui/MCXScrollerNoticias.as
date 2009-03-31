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
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import com.ab.utils.Move
	import org.casalib.util.StageReference
	
	public class MCXScrollerNoticias extends EdigmaSprite
	{
		private var _INIT_X:Number
		private var _SCROLL_PERCENT:Number;
		private var _TARGET_CLIP:Object;
		private var rectangle:Rectangle;
		private var fx:Number;
		
		private var _TARGET_FINAL_X:Number;
		private var _TOTAL_SCROLL_H_DISTANCE:Number;
		private var _TARGET_WIDTH:Number;
		private var _VISIBLE_WIDTH:Number;
		private var _TARGET_MIN_X:Number;
		private var _MIN_SCROLLER_X:Number;
		private var _MAX_SCROLLER_X:Number;
		private var _TARGET_MAX_X:Number;
		private var indent:Number;
		private var _stage:StageReference;
		
		public function MCXScrollerNoticias(target_clip:Object, scroll_distance:Number, visible_width:Number)
		{
			super();
			
			trace( "MCXScrollerNoticias : target_clip = " + target_clip );
			trace( "MCXScrollerNoticias : scroll_distance = " + scroll_distance );
			trace( "MCXScrollerNoticias : visible_width = " + visible_width );
			
			this.alpha = 0
			
			_TARGET_CLIP = target_clip
			_VISIBLE_WIDTH = visible_width // - 20 y height
			
			_TARGET_MAX_X = _TARGET_CLIP.x
			_TARGET_MIN_X = _TARGET_MAX_X - target_clip.width + _VISIBLE_WIDTH
			
			trace( "MCXScrollerNoticias : _TARGET_MIN_X = " + _TARGET_MIN_X );
			trace( "MCXScrollerNoticias : _TARGET_MAX_X = " + _TARGET_MAX_X );
			
			_TARGET_WIDTH = _TARGET_CLIP.width
			
			trace( "MCXScrollerNoticias : _TARGET_WIDTH : " + _TARGET_WIDTH );
			
			_MAX_SCROLLER_X = this.x + scroll_distance - this.width // maximo x da scroll handle
			
			_TOTAL_SCROLL_H_DISTANCE = scroll_distance - this.width // altura total de movimento da scroll handle
		}
		
		public function init():void
		{
			_MIN_SCROLLER_X = this.x
			
			GoVisible()
			
			indent = _MAX_SCROLLER_X - _MIN_SCROLLER_X
			
			this.buttonMode = true;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, clickHandle, false, 0, true); 
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP, releaseHandle, false, 0, true);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
		}
		public function deActivate():void
		{
			this.buttonMode = false;
			this.removeEventListener(MouseEvent.MOUSE_DOWN, clickHandle); 
			StageReference.getStage().removeEventListener(MouseEvent.MOUSE_UP, releaseHandle);
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler); 
		}
		
		public function reActivate():void
		{
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN, clickHandle, false, 0, true);
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP, releaseHandle, false, 0, true);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
		}
		
		private function clickHandle(e:MouseEvent) 
		{
			rectangle = new Rectangle(_MIN_SCROLLER_X, this.y, _TOTAL_SCROLL_H_DISTANCE, 0);
			
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
			Move.ToPositionX(this, _MIN_SCROLLER_X, 0.2)
		}
		
		private function positionContent():void
		{
			//trace("MCXScrollerNoticias running");
			
			var downX:Number;
			var curX:Number;
			
			_SCROLL_PERCENT = (100 / indent) * (this.x - _MIN_SCROLLER_X);
			
			downX = _TARGET_CLIP.width - (_VISIBLE_WIDTH / 2)
			
			_TARGET_FINAL_X = _TARGET_MAX_X - (((downX - (_VISIBLE_WIDTH / 2)) / 100) * _SCROLL_PERCENT);
			
			var final_value:Number = _TARGET_CLIP.x;
			
			if (_TARGET_CLIP.x != _TARGET_FINAL_X) 
			{
				var diff:Number = _TARGET_FINAL_X - _TARGET_CLIP.x;
				
				final_value += diff / 4;
			}
			
			_TARGET_CLIP.x = Math.floor(final_value)
		}	
	}
}