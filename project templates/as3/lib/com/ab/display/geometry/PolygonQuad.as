package com.ab.display.geometry 
{
	/**
	* @author ABº
	*/
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class PolygonQuad extends Sprite
	{
		public var init_x:Number;
		public var init_y:Number;
		
		public var _width:Number;
		public var _height:Number;
		public var _colour:uint;
		public var _ellipseWidth:Number;
		public var _ellipseHeight:Number;
		public var _line_thickness:Number;
		public var _line_colour:uint;
		
		public function PolygonQuad(__width:Number=0, __height:Number=0, __colour:uint=0x000000, __ellipseWidth:Number=0, __ellipseHeight:Number=0, __line_thickness:Number=0, __line_colour:uint=0x000000)
		{
			_width 				= __width;
			_height 			= __height;
			_colour 			= __colour;
			_ellipseWidth 		= __ellipseWidth;
			_ellipseHeight 		= __ellipseHeight;
			_line_thickness 	= __line_thickness;
			_line_colour 		= __line_colour;
			
			design();
			
			addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		public function design():void 
		{
			if (_line_thickness != 0)  { this.graphics.lineStyle(_line_thickness, _line_colour); }
			
			this.graphics.beginFill(_colour);
			this.graphics.drawRoundRect(0, 0, _width, _height, _ellipseWidth, _ellipseHeight);
			this.graphics.endFill();
			
			if (_ellipseWidth != 0 && _ellipseHeight != 0) 
			{
				this.scale9Grid = new Rectangle(_ellipseWidth, _ellipseHeight, _width - _ellipseWidth * 2, _height - _ellipseHeight * 2);
			}
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			init_x = this.x;
			init_y = this.y;
		}
		
	}
	
}