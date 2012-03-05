package com.ab.tween
{
	/**
	* @TinyTweener
	* @author Antonio Brandao
	* 
	* Usage: 
	* 	TinyTweener.singleton.addTween(some_display_object, { alpha:0, y:20 }, 0.2, "easeOutSine );
	* 	TinyTweener.singleton.addTween(some_display_object, { alpha:0, y:20 } );
	* 
	* Time and transition equation are optional parameters.
	* 
	* If provided, the name of the transition type - e.g. "easeOutSine" must be provided correctly. Please check available equations in the TinyTween class.
	*/
	
	import flash.display.DisplayObject;
	
	public class TinyTweener 
	{
		private static var instance:TinyTweener 				= new TinyTweener();
		private static var _runningTweens:Vector.<TinyTween> 	= new Vector.<TinyTween>;
		
		public static function addTween(displayObject:DisplayObject, props:Object, time:Number=0.5, curve:String = "easeOut"):void
		{
			for (var i:int = 0; i < _runningTweens.length; i++) 
			{
				if (TinyTween(_runningTweens[i])["displayObject"] == displayObject) 
				{
					TinyTween(_runningTweens[i]).interruptAndDestroy();
					
					_runningTweens.splice(i, 1);
					
					CONFIG::debug { trace("TinyTweenr ::: REMOVING ONE TWEEN"); };
				}
			}
			
			var newtween:TinyTween = new TinyTween(displayObject, props, time, curve);
			
			_runningTweens.push(newtween);
		}
		
		public static function cleanTween(tween:TinyTween):void
		{
			for (var i:int = 0; i < _runningTweens.length; i++) 
			{
				if (TinyTween(_runningTweens[i]) == tween) 
				{
					_runningTweens.splice(i, 1);
					
					CONFIG::debug { trace("TinyTweenr ::: CLEANING ONE TWEEN"); };
				}
			}
		}
		
	}

}