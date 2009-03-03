package com.ab.utils 
{
	/**
	*
	* @author ABº
	* 
	*/
	
	import flash.display.MovieClip
	
	import com.ab.as3websystem.util.TweenLite
	import fl.motion.easing.*
	
	public class Size 
	{
		public function Size()
		{
			
		}
		
		///////////// MCS ///////////////////////
		
		////////////////////////// TO WIDTH
		
		public static function ToWidth(mc:MovieClip, rate:Number, time:Number ):void
		{
			TweenLite.to(mc, time, { width:rate, ease:Linear.easeOut} );
		}
		
		////////////////////////// TO X SCALE
		
		public static function ToXScale(mc:MovieClip, scale:Number, time:Number ):void
		{
			TweenLite.to(mc, time, { xscale:scale, ease:Linear.easeOut} );
		}
	}
}