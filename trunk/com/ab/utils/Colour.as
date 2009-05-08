/**
* 
* @author ABº
* http://blog.antoniobrandao.com/
* 
* Handy class to tween the colour of objects on stage or an array of objects
* 
* USAGE : 
* 
* 	  import com.ab.utils.Colour
* 
* 	  Colour.MCToColour(object_instance_name, 0xFF0000, 1)
* 
* DEPENDENCIES :
* 
* 	  TweenLite
* 
*/

package com.ab.utils 
{
	import fl.motion.Color;
	import fl.motion.CustomEase;
	import flash.display.MovieClip
	
	import fl.motion.easing.*
	import gs.TweenLite
	
	public class Colour 
	{
		public function Colour() 
		{
			
		}
		
		/// OBJECTS ///////////////////////
		
		public static function ObjectToColour(mc:Object, colour:uint, time:Number = 0.5 ):void
		{
			TweenLite.to(mc, time, { tint:colour, ease:Linear.easeOut} );
		}
		
		/// ARRAYS ///////////////////////
		
		public static function ObjectsArray(array:Array, colour:uint, time:Number = 0.5 ):void
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				TweenLite.to(array[i], time, { tint:colour, ease:Linear.easeOut} );
			}
		}
		
		public static function ObjectArrayExcept(array:Array, exception:Object, colour:uint, time:Number = 0.5 ):void
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				if (array[i] != exception) 
				{
					TweenLite.to(array[i], time, { tint:colour, ease:Linear.easeOut} );
				}
				
			}
		}
	}
}