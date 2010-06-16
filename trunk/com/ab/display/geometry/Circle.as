package com.ab.display.geometry 
{
	/**
	* @author ABº
	*/
	
	import flash.display.Sprite;
	
	public class Circle extends Sprite
	{
		public function Circle(_width:Number=0, _height:Number=0, _colour:uint=0x000000)
		{
			target_object.graphics.beginFill(_colour);
			target_object.graphics.moveTo(r, 0);
			target_object.graphics.curveTo(r, Math.tan(Math.PI/8)*r, Math.sin(Math.PI/4)*r, Math.sin(Math.PI/4)*r);
			target_object.graphics.curveTo(Math.tan(Math.PI/8)*r, r, 0, r);
			target_object.graphics.curveTo(-Math.tan(Math.PI/8)*r, r, -Math.sin(Math.PI/4)*r, Math.sin(Math.PI/4)*r);
			target_object.graphics.curveTo(-r, Math.tan(Math.PI/8)*r, -r, 0);
			target_object.graphics.curveTo(-r, -Math.tan(Math.PI/8)*r, -Math.sin(Math.PI/4)*r, -Math.sin(Math.PI/4)*r);
			target_object.graphics.curveTo(-Math.tan(Math.PI/8)*r, -r, target_object.x, -r);
			target_object.graphics.curveTo(Math.tan(Math.PI/8)*r, -r, Math.sin(Math.PI/4)*r, -Math.sin(Math.PI/4)*r);
			target_object.graphics.curveTo(r, -Math.tan(Math.PI/8)*r, r, 0);
			target_object.graphics.endFill();
		}
		
	}
	
}