package com.ab.display.shapes 
{
	/**
	* @author ABº
	*/
	
	import flash.display.Sprite;
	
	public class Circle extends Sprite
	{
		public function Circle(radius:Number=50, _colour:uint=0x000000, _alpha:Number=1)
		{
			this.graphics.beginFill(_colour);
			this.graphics.moveTo(radius, 0);
			this.graphics.curveTo(radius, Math.tan(Math.PI/8)*radius, Math.sin(Math.PI/4)*radius, Math.sin(Math.PI/4)*radius);
			this.graphics.curveTo(Math.tan(Math.PI/8)*radius, radius, 0, radius);
			this.graphics.curveTo(-Math.tan(Math.PI/8)*radius, radius, -Math.sin(Math.PI/4)*radius, Math.sin(Math.PI/4)*radius);
			this.graphics.curveTo(-radius, Math.tan(Math.PI/8)*radius, -radius, 0);
			this.graphics.curveTo(-radius, -Math.tan(Math.PI/8)*radius, -Math.sin(Math.PI/4)*radius, -Math.sin(Math.PI/4)*radius);
			this.graphics.curveTo(-Math.tan(Math.PI/8)*radius, -radius, this.x, -radius);
			this.graphics.curveTo(Math.tan(Math.PI/8)*radius, -radius, Math.sin(Math.PI/4)*radius, -Math.sin(Math.PI/4)*radius);
			this.graphics.curveTo(radius, -Math.tan(Math.PI/8)*radius, radius, 0);
			this.graphics.endFill();
			
			this.alpha = _alpha;
		}
		
	}
	
}