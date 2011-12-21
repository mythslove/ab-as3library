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
		private var originalValues:Object = new Object();
		
		public function PolygonQuad(__width:Number=0, __height:Number=0, __colour:uint=0x000000, __ellipseWidth:Number=0, __ellipseHeight:Number=0, __line_thickness:Number=0, __line_colour:uint=0x000000)
		{
			originalValues._width				=		_width 				= __width;
			originalValues._height				=		_height 			= __height;
			originalValues._colour				=		_colour 			= __colour;
			originalValues._ellipseWidth		=		_ellipseWidth 		= __ellipseWidth;
			originalValues._ellipseHeight		=		_ellipseHeight 		= __ellipseHeight;
			originalValues._ellipseHeight		=		_line_thickness 	= __line_thickness;
			originalValues._line_colour			=		_line_colour 		= __line_colour;
			
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
				this.scale9Grid = new Rectangle(_ellipseWidth, _ellipseHeight, originalValues._width - _ellipseWidth * 2, originalValues._height - _ellipseHeight * 2);
			}
		}
		/**
		 * Method to retrieve the original value for any of teh initialised items
		 *   note that the return value is flexible.
		 */
		public function getOriginalValue(val:String):*
		{
			for (var key:String in originalValues)
			{
				if (key == val)
				{
					return originalValues[key];
				}
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