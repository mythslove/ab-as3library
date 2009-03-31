package com.ab.utils 
{
	/**
	* @author ABº
	*/
	
	public class PatternFrame
	{
		private var _TARGET_OBJECT:Object;
		private var _FRAME_OBJECT:Object;
		private var _FRAME_SIZE:Number;
		private var _PATTERN:*;
		
		
		public function PatternFrame(target_object:Object, frame_object:Object, pattern:*, frame_size:Number=10)
		{
			_TARGET_OBJECT = target_object;
			_FRAME_OBJECT = frame_object;
			_PATTERN = pattern;
			_FRAME_SIZE = frame_size;
			
			start()
		}
		
		private function start():void
		{
			var final_frame_width = _TARGET_OBJECT.width + (_FRAME_SIZE * 2)
			var final_frame_height = _TARGET_OBJECT.height + (_FRAME_SIZE * 2)
			
			_FRAME_OBJECT.graphics.clear()
			_FRAME_OBJECT.graphics.beginBitmapFill(new _PATTERN(0, 0));
			_FRAME_OBJECT.graphics.drawRect(0, 0, final_frame_width, final_frame_height);
			_FRAME_OBJECT.graphics.endFill();
		}
	}
}