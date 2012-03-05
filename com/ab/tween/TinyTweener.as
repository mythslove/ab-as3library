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
		private static var _runningTweens:Vector.<TinyTween> = new Vector.<TinyTween>;
		
		public static function addTween(_displayObject:DisplayObject, _props:Object, _time:Number=0.5, _curve:String = "easeOut"):void
		{
			removeDisplayObjectTween(_displayObject);
			
			var newtween:TinyTween = new TinyTween(_displayObject, _props, _time, _curve);
			
			_runningTweens.push(newtween);
		}
		
		public static function stopTween(_displayObject:DisplayObject):void
		{
			if (removeDisplayObjectTween(_displayObject))
			{
				CONFIG::debug { trace("TinyTweener ::: STOPPING ONE TWEEN"); };
			}
		}
		
		static private function removeDisplayObjectTween(_displayObject:DisplayObject):Boolean
		{
			for (var i:int = 0; i < _runningTweens.length; i++) 
			{
				if (TinyTween(_runningTweens[i]).displayObject == _displayObject)
				{
					TinyTween(_runningTweens[i]).destroy();
					
					_runningTweens.splice(i, 1);
					
					return true;
				}
			}
			
			return false;
		}
		
		public static function cleanTween(tween:TinyTween):void
		{
			for (var i:int = 0; i < _runningTweens.length; i++)
			{
				if (TinyTween(_runningTweens[i]) == tween) 
				{
					_runningTweens[i] = null;
					
					_runningTweens.splice(i, 1);
					
					CONFIG::debug { trace("TinyTweener ::: CLEANING ONE TWEEN"); };
				}
			}
		}
		
	}

}