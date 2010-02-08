package com.ab.display.geometry 
{
	/**
	* @author ABº
	*/
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class PolygonQuad extends Sprite
	{
		public function PolygonQuad(_width:Number=0, _height:Number=0, _colour:uint=0x000000)
		{
			this.graphics.beginFill(_colour);
			this.graphics.drawRoundRect(0, 0, _width, _height, 0, 0);
			this.graphics.endFill();
		}
		
	}
	
}