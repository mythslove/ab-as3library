package com.ab.utils 
{
	/**
	* 
	* @author ABº
	* 
	*/
	
	import flash.display.MovieClip
	import flash.system.System
	import flash.utils.setTimeout;
	import flash.display.Stage
	//import com.ab.as3websystem.core.system.ScreenSettings
	import caurina.transitions.Tweener
	
	//assim de repente era algo do tipo:
	//onComplete: function(args):void { onCompleteFunc1(args); onCompleteFunc2(args); ....  }
	
	public class Make2
	{
		
		//public var _stage:Stage
		
		public function Make2() 
		{
			// e quê tá tudo ?
			
			//_stage = ScreenSettings.getSingleton()._stage
		}
		
		///////////// MCS ///////////////////////////////////////////////////////////////////////////////////////
		///////////// MCS ///////////////////////////////////////////////////////////////////////////////////////
		///////////// MCS ///////////////////////////////////////////////////////////////////////////////////////
		///////////// MCS ///////////////////////////////////////////////////////////////////////////////////////
		
		//public static function MCCenteredInStage(mc:Object):void
		//{
			//
			//mc.x = ScreenSettings.getSingleton()._stage.stageWidth - (mc.width / 2)
			//mc.y = ScreenSettings.getSingleton()._stage.stageHeight - (mc.height / 2)
		//}
		
		/// Tweens an Object MovieClip to a specified hexadecimal colour value
		public static function MCColour(mc:Object, colour:Number,  tempo:Number=0.5, _transition:String="EaseOutSine"):void
		{
			Tweener.addTween(mc, { color:colour, time:tempo, transition:_transition } );
		}
		
		/// Tweens an Object MovieClip to a specified Alpha value with optional duration and onComplete Function
		public static function MCToAlpha(mc:Object, alphavalue:Number, duration:Number=NaN, onCompleteFunc:Function=null):void
		{
			if (onCompleteFunc != null)
			{
				Tweener.addTween(mc, {alpha:alphavalue, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine", onComplete:onCompleteFunc, onCompleteParams:[mc]})
			}
			else
			{
				Tweener.addTween(mc, {alpha:alphavalue, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine"})
			}
		}
		
		/// Makes an Object MovieClip visible with optional duration and onComplete Function
		public static function MCVisible(mc:Object, duration:Number=0.5, onCompleteFunc:Function=null, _delay:Number=0.0):void
		{
			mc.alpha = 0
			mc.visible = true
			
			if (onCompleteFunc != null)
			{
				Tweener.addTween(mc, {alpha:1, time:duration, transition:"EaseOutSine", delay:_delay, onComplete:onCompleteFunc, onCompleteParams:[mc]})
			}
			else
			{
				Tweener.addTween(mc, {alpha:1, time:duration, transition:"EaseOutSine", delay:_delay })
			}	
		}
		
		public static function MCInvisible(mc:Object, duration:Number=NaN):void
		{
			Tweener.addTween(mc, { alpha:0, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine", onComplete:function(){mc.visible = false}} )
		}
		public static function MCInvisibleWithOnComplete(mc:Object, oncompletefunc:Function=null, duration:Number=NaN):void
		{
			Tweener.addTween(mc, { alpha:0, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine", onComplete:oncompletefunc } )
		}
		
		public static function MCAppearAtPos(mc:Object, xpos:Number, ypos:Number, _time:Number = 0.5, _transition:String = "EaseOutSine", _delay:Number = 0):void
		{
			Tweener.addTween(mc, { alpha:1, x:xpos, y:ypos, time:_time, transition:"EaseOutSine", delay:_delay } )
		}
		
		public static function MCDisappearAtPos(mc:Object, xpos:Number, ypos:Number, duration:Number):void
		{
			Tweener.addTween(mc, { alpha:1, x:xpos, y:ypos, time:duration, transition:"EaseOutSine", onComplete:unVisibleMovieClip, onCompleteParams:[mc] } )
		}
		
		///////////// ARRAYS /////////////////////////////////////////////////////////////////////////////////////
		///////////// ARRAYS /////////////////////////////////////////////////////////////////////////////////////
		///////////// ARRAYS /////////////////////////////////////////////////////////////////////////////////////
		///////////// ARRAYS /////////////////////////////////////////////////////////////////////////////////////
		
		public static function ArrayFadeOut(array:Array, duration:Number, exception:Object=null, onitemcomplete_function:Function=null, on_total_complete_function:Function=null):void
		{
			var tmpArray = new Array()
			
			for (var i:int = 0; i < array.length; i++) 
			{
				if (exception != null) 
				{
					if (array[i] != exception) 
					{
						tmpArray.push(array[i])
					}
				}
				else
				{
					tmpArray.push(array[i])
				}
			}
			
			for (var x:int = 0; x < tmpArray.length; x++) 
			{
				if (x == tmpArray.length-1)
				{
					Tweener.addTween(tmpArray[x], { alpha:0, time:duration, transition:"EaseOutSine", onComplete:on_total_complete_function, onCompleteParams:[tmpArray[x]] } )
				}
				else
				{
					Tweener.addTween(tmpArray[x], { alpha:0, time:duration, transition:"EaseOutSine", onComplete:onitemcomplete_function, onCompleteParams:[tmpArray[x]] } )
				}
				
			}
		}
		
		public static function ArrayFadeOutAndDie(array:Array, duration:Number, exception:Object, oncomplete_function:Function=null):void
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				if (array[i] != exception) 
				{
					Tweener.addTween(array[i], { alpha:0, time:duration, transition:"EaseOutSine", onComplete:killMovieClip, onCompleteParams:[array[i]] } )
				}
				
				if (i == array.length-1) 
				{
					if (oncomplete_function != null) 
					{
						oncomplete_function()
					}
				}
			}
		}
		
		///////////// TIME ///////////////////////////////////////////////////////////////////////////////////////
		
		/// Makes times (in seconds) and executes a given function
		public static function TimeAndExecuteFunction(duration:Number, func:Function)
		{
			var auxTimeVar = duration * 1000
			
			setTimeout(func, auxTimeVar)
		}
		
		/////////////////////////////////////////////////////// SYSTEM
		/////////////////////////////////////////////////////// SYSTEM
		/////////////////////////////////////////////////////// SYSTEM
		
		static private function unVisibleMovieClip(params:Array):void
		{
			for (var i:int = 0; i < params.length; i++) 
			{
				params[i].visible = false
			}		
		}
		
		public static function destroyTweens():void
		{
			Tweener.removeAllTweens()
		}
		
		static private function killMovieClip(mc:Object):void
		{
			mc.removeChild()
			
			System.gc()
		}
	}
	
}