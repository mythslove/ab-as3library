package com.ab.utils
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
   
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.casalib.util.StageReference;
   
	public class HitTest
	{
		public static function MouseHitObject(_object_ref:Object, _stage_ref:Stage):Boolean
		{
			if (_object_ref.hitTestPoint(_stage_ref.mouseX, _stage_ref.mouseY, true)) 
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public static function MouseHitAnyObjectFromArray(_array_ref:Object, _stage_ref:Stage):Boolean
		{
			var hit_found:Boolean = false;
			
			for (var i:int = 0; i < _array_ref.length; i++) 
			{
				if (_array_ref[i].hitTestPoint(_stage_ref.mouseX, _stage_ref.mouseY, true)) 
				{
					hit_found = true;
				}
			}
			
			return hit_found;
		}
	}
}