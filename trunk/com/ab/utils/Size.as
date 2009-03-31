package com.ab.utils 
{
	/**
	*
	* @author ABº
	* 
	*/
	
	import flash.display.MovieClip
	
	import gs.TweenLite
	import caurina.transitions.Tweener
	import fl.motion.easing.*
	
	public class Size 
	{
		public function Size()
		{
			
		}
		
		///////////// MCS ///////////////////////
		
		/// SIZE TO NEW WIDTH
		public static function ToWidth(mc:Object, new_width:Number, _time:Number = 0.5, _transition:String="EaseOutsine", _delay:Number = 0 ):void
		{
			Tweener.addTween(mc, {width:new_width, time:_time, transition:_transition, delay:_delay})
		}
		
		/// SIZE TO NEW HEIGHT
		public static function ToHeight(mc:Object, new_height:Number, _time:Number = 0.5, _transition:String="EaseOutsine", _delay:Number = 0 ):void
		{
			Tweener.addTween(mc, {height:new_height, time:_time, transition:_transition, delay:_delay})
		}
		
		/// SIZE TO NEW HEIGHT & WIDTH
		public static function ToWidthHeight(mc:Object, new_width:Number, new_height:Number, _time:Number = 0, _transition:String="EaseOutsine", _delay:Number = 0):void
		{
			Tweener.addTween(mc, {width:new_width, height:new_height, time:_time, transition:_transition, delay:_delay})
		}
		
		/// SIZE TO XY SCALE
		public static function ToXYScale(mc:Object, scale:Number, _time:Number=0.5, _transition:String="EaseOutsine", _delay:Number = 0 ):void
		{
			Tweener.addTween(mc, {scaleX:scale, scaleY:scale, time:_time, transition:_transition, delay:_delay})
		}
		
		/// SIZE TO X SCALE
		public static function ToXScale(mc:Object, scale:Number, _time:Number=0.5, _transition:String="EaseOutsine", _delay:Number = 0 ):void
		{
			Tweener.addTween(mc, {scaleX:scale, time:_time, transition:_transition, delay:_delay})
		}
		
		/// SIZE TO Y SCALE
		public static function ToYScale(mc:Object, scale:Number, _time:Number=0.5, _transition:String="EaseOutsine", _delay:Number = 0 ):void
		{
			Tweener.addTween(mc, {scaleY:scale, time:_time, transition:_transition, delay:_delay})
		}
	}
}