package com.ab.display.geometry.special 
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.geometry.PolygonQuad;
	import com.ab.display.PatternFill;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class PolygonQuadPixelChess extends Sprite
	{
		private var _layer_bg1:PatternFill;
		private var _layer_bg2:PatternFill;
		
		public var _width:Number;
		public var _height:Number;
		public var _colour:uint;
		
		public function PolygonQuadPixelChess(__width:Number=0, __height:Number=0, __colour:uint=0x000000)
		{
			_width 				= __width;
			_height 			= __height;
			_colour 			= __colour;
			
			design();
		}
		
		private function design():void 
		{
			_layer_bg1 = new PatternFill(_width, _height, ["*", "  "], _colour);
			//_layer_bg2 = new PatternFill(_width, _height, ["*", " "], _colour);
			
			//_layer_bg2.y = 1;
			//_layer_bg2.x = 1;
			
			this.addChild(_layer_bg1)
			//this.addChild(_layer_bg2)
			
		}
		
	}
	
}