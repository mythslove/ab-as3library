package com.ab.display 
{
	/**
	* @author ABº
	* 
	* http://blog.antoniobrandao.com/
	* http://www.antoniobrandao.com/
	*/
	
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class GradientBox 
	{
		
		public function GradientBox() 
		{
			
		}
		
		public static function createShape(_colour1:uint=0xffffff, _colour2:uint=0x000000, _width:Number=100, _height:Number=100, _start_alpha:Number=1.0, _end_alpha:Number=1.0, _rotation:Number=1.5707963267948966):Shape
		{
			/// default _rotation is (Math.PI/180)*90
			
			var shape1:Shape = new Shape();
			var colors:Array = [ _colour1, _colour2 ];
			var alphas:Array = [ _start_alpha, _end_alpha ];
			var ratios:Array = [ 0, 255 ];
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(_width, _height, _rotation, 0, 0);
			//shape1.graphics.lineStyle(2,0xa1b0b6);
			shape1.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
			shape1.graphics.drawRect( 0.0, 0.0, _width, _height);
			shape1.graphics.endFill();
			
			return shape1;
		}
		
		/*
		public static function createSprite(_colour1:uint=0xffffff, _colour2:uint=0x000000, _width:Number=100, _height:Number=100, _start_alpha:Number=1.0, _end_alpha:Number=1.0, _rotation:Number=1.5707963267948966):Shape
		{
			/// default _rotation is (Math.PI/180)*90
			
			var sprite:Sprite = new Sprite();
			var shape1:Shape  = new Shape();
			var colors:Array  = [ _colour1, _colour2 ];
			var alphas:Array  = [ _start_alpha, _end_alpha ];
			var ratios:Array  = [ 0, 255 ];
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(_width, _height, _rotation, 0, 0);
			//shape1.graphics.lineStyle(2,0xa1b0b6);
			shape1.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
			shape1.graphics.drawRect( 0.0, 0.0, _width, _height);
			shape1.graphics.endFill();
			
			sprite.addChild(shape1);
			
			return shape1;
		}*/
		
	}
	
}