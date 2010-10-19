package com.ab.ui 
{
	/**
	* @author ABº
	*/
	
	/// flash
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	/// ab
	import com.ab.display.geometry.PolygonQuad;
	
	public class SimpleFrame extends Sprite
	{
		private var top_bar:PolygonQuad;
		private var bottom_bar:PolygonQuad;
		private var left_bar:PolygonQuad;
		private var right_bar:PolygonQuad;
		
		public function SimpleFrame(_target_object:DisplayObject, _thickness:Number = 10, _colour:uint = 0xFFFFFF)
		{
			if (_target_object == null)
			{
				trace("SimpleFrame ::: provided DisplayObject cannot be null")
			}
			else
			{
				top_bar 		= new PolygonQuad(_target_object.width, _thickness, _colour);
				bottom_bar 		= new PolygonQuad(_target_object.width, _thickness, _colour);
				left_bar 		= new PolygonQuad(_thickness, _target_object.height - (_thickness * 2), _colour);
				right_bar 		= new PolygonQuad(_thickness, _target_object.height - (_thickness * 2), _colour);
				
				top_bar.x 			= 0;
				top_bar.y 			= 0;
				
				bottom_bar.x 		= 0;
				bottom_bar.y 		= _target_object.height - _thickness;
				
				left_bar.x 			=  0;
				left_bar.y 			=  _thickness;
				
				right_bar.y 		=  _thickness;
				right_bar.x 		= _target_object.width - _thickness;
				
				this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			}
		}
		
		private function addedHandler(e:Event):void 
		{
			trace ("SimpleFrame ::: addedHandler()"); 
			
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			addChild(top_bar);
			addChild(bottom_bar);
			addChild(left_bar);
			addChild(right_bar);
		}
		
	}
	
}