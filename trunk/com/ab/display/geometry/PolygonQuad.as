package com.ab.display.geometry 
{
	/**
	* @author ABº
	*/
	
	import flash.display.Sprite;
	
	public class PolygonQuad extends Sprite
	{
		public function PolygonQuad(_width:Number=0, _height:Number=0, _colour:uint=0x000000, _ellipseWidth:Number=0, _ellipseHeight:Number=0, _line_thickness:Number=0, _line_colour:uint=0x000000)
		{
			if (_line_thickness != 0)  { this.graphics.lineStyle(_line_thickness, _line_colour); }
			this.graphics.beginFill(_colour);
			this.graphics.drawRoundRect(0, 0, _width, _height, _ellipseWidth, _ellipseHeight);
			this.graphics.endFill();
		}
		
	}
	
}