package com.ab.utils 
{
	/**
	*
	* @author ABº
	* 
	*/
	
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
		
		///////////// MCS ///////////////////////
		
		public static function MCToColour(mc:Object, colour, time:Number ):void
		{
			TweenLite.to(mc, time, { tint:colour, ease:Linear.easeOut} );
		}
		
		///////////// ARRAYS ///////////////////////
		
		public static function MCArray(array:Array, colour, time:Number ):void
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				TweenLite.to(array[i], time, { tint:colour, ease:Linear.easeOut} );
			}
		}
		
		public static function ArrayExceptMC(array:Array, mc:Object, colour, time:Number ):void
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				if (array[i] != mc) 
				{
					TweenLite.to(array[i], time, { tint:colour, ease:Linear.easeOut} );
				}
				
			}
		}
	}
}