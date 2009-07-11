package com.ab.utils 
{
	/**
	* @author ABº
	* http://blog.antoniobrandao.com/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip
	import flash.filters.*
	import flash.text.TextField
	import flash.system.System
	import flash.utils.setTimeout;
	import flash.display.Stage
	import caurina.transitions.*
	import caurina.transitions.properties.ColorShortcuts
	import flash.events.MouseEvent
	
	//assim de repente era algo do tipo:
	//onComplete: function(args):void { onCompleteFunc1(args); onCompleteFunc2(args); ....  }
	//
	public class Make
	{
		public function Make() 
		{
			// e quê tá tudo ?
			ColorShortcuts.init();
		}
		
		///////////// MCS ///////////////////////////////////////////////////////////////////////////////////////
		///////////// MCS ///////////////////////////////////////////////////////////////////////////////////////
		///////////// MCS ///////////////////////////////////////////////////////////////////////////////////////
		///////////// MCS ///////////////////////////////////////////////////////////////////////////////////////
		
		/// Tweens an Object to a specified hexadecimal colour value
		public static function MCColour(mc:Object, colour:uint,  tempo:Number=0.5, _transition:String="EaseOutSine", _alpha:Number=1):void
		{
			ColorShortcuts.init();
			Tweener.addTween(mc, { _color:colour, time:tempo, alpha:_alpha, transition:_transition } );
		}
		
		/// Tweens a TextField to a specified hexadecimal colour value
		public static function TFColour(tf:TextField, colour:Number,  tempo:Number=0.5, _transition:String="EaseOutSine"):void
		{
			Tweener.addTween(tf, { textColor:colour, time:tempo, transition:_transition } );
		}
		
		/// applies rollOver and rollOut effect to clip
		public static function MCRollOverRollOut(mc:Object, func_over:Function, func_out:Function):void
		{
			mc.addEventListener(MouseEvent.ROLL_OVER, func_over, false, 0, true)
			mc.addEventListener(MouseEvent.ROLL_OUT, func_out, false, 0, true)
		}
		
		/// Makes an object clickable
		public static function MCClickable(mc:Object, func:Function):void
		{
			mc.addEventListener(MouseEvent.CLICK, func, false, 0, true)
			mc.buttonMode = true
			mc.useHandCursor = true
			mc.mouseChildren = false
			mc.tabChildren = false
		}
		
		/// Tweens an Object MovieClip to a specified Alpha value with optional duration and onComplete Function
		public static function MCToAlpha(mc:Object, alphavalue:Number, duration:Number=0.5, onCompleteFunc:Function=null, _delay:Number=0):void
		{
			if (onCompleteFunc != null)
			{
				Tweener.addTween(mc, {alpha:alphavalue, time:duration, transition:"EaseOutSine", delay:_delay, onComplete:onCompleteFunc, onCompleteParams:[mc]})
			}
			else
			{
				Tweener.addTween(mc, {alpha:alphavalue, time:duration, delay:_delay, transition:"EaseOutSine"})
			}
		}
		
		/// Makes an Object MovieClip visible with optional duration and onComplete Function
		public static function MCVisible(mc:Object, duration:Number=0.5, onCompleteFunc:Function=null, _delay:Number=0.0):void
		{
			if (mc.alpha == 0 || mc.visible == false) 
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
		
		
		/// Makes the objects from an array clickable
		public static function MCArrayClickable(_array:Array, func:Function):void
		{
			for (var i:int = 0; i < _array.length; i++) 
			{
				_array[i].addEventListener(MouseEvent.CLICK, func, false, 0, true)
				_array[i].buttonMode = true
				_array[i].useHandCursor = true
			}
		}
		/// CALCEL the clickability of objects from an array 
		public static function MCArrayClickableCancel(_array:Array, func:Function):void
		{
			for (var i:int = 0; i < _array.length; i++) 
			{
				_array[i].useHandCursor = false
				_array[i].buttonMode = false
				_array[i].removeEventListener(MouseEvent.CLICK, func)
			}
		}
		
		
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