package com.ab.ui 
{
	
	/**
	* @author ABº
	* 
	* A clip in the library is required - associated with this class
	*/
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System
	//import com.ab.utils.DebugTF
	import com.ab.utils.Move
	import com.ab.display.ABMovieClip
	
	public class MCXScrollerOld extends ABMovieClip
	{
		private var _INIT_X:Number
		private var _MIN_X:Number;
		private var _MIN_SCROLLER_X:Number;
		private var _MAX_SCROLLER_X:Number;
		private var _PERCENT:Number;
		private var _TARGET_CLIP:Object;
		private var _VISIBLE_WIDTH:Number;
		private var _CONTENT_START_X:Number;
		private var rectangle:Rectangle;
		private var _MAX_X:Number
		private var fx:Number;
		private var _TARGET_FINAL_X:Number;
		
		//
		public function MCXScrollerOld(target_clip:Object, max_X:Number, visible_width:Number)
		{
			super();
			
			_TARGET_CLIP = target_clip
			_VISIBLE_WIDTH = visible_width // - 20
			
			_CONTENT_START_X = _TARGET_CLIP.x
			_MIN_X = _CONTENT_START_X
			
			_MIN_SCROLLER_X = this.x
			_MAX_SCROLLER_X = max_X - this.width
		}
		
		public function init():void
		{
			_INIT_X = this.x
			
			this.buttonMode = true;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, clickHandle); 
			stage.addEventListener(MouseEvent.MOUSE_UP, releaseHandle);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		
		
		private function clickHandle(e:MouseEvent) 
		{
			rectangle = new Rectangle(_INIT_X, this.y, _MAX_SCROLLER_X, 0);
			
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
			var downX:Number;
			var curX:Number;
			
			_PERCENT = (100 / _MAX_SCROLLER_X) * this.x;
			
			downX = _TARGET_CLIP.width - (_VISIBLE_WIDTH / 2) + 20;
			
			_TARGET_FINAL_X = _CONTENT_START_X - (((downX - (_VISIBLE_WIDTH / 2)) / 100) * _PERCENT); 
			
			
			var curry:Number = _TARGET_CLIP.x;
			
			if (_TARGET_CLIP.x != _TARGET_FINAL_X) 
			{
				var diff:Number = _TARGET_FINAL_X - _TARGET_CLIP.x;
				
				curry += diff / 4;
			}
			
			_TARGET_CLIP.x = curry
		}
		/*
		public  function close():void
		{
			destroy()
		}
		*/
		
		/*
		public function destroy():void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, clickHandle); 
			stage.removeEventListener(MouseEvent.MOUSE_UP, releaseHandle);
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler); 
			
			parent.removeChild(this)
			
			System.gc()
		}
		*/
	}
}