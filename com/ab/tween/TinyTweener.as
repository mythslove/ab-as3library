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
	import flash.utils.ByteArray;
	
	public class TinyTweener 
	{
		private static var _runningTweens:Vector.<TinyTween> = new Vector.<TinyTween>;
		private static var _overrideTweens:Boolean = true;
		
		public static var fps:int = 30;
		
		public static function addTween(_displayObject:DisplayObject, _props:Object, _time:Number=0.5, _curve:String = "easeOut", _delay:Number=0, _onComplete:Function=null):void
		{
			if (_displayObject != null) 
			{
				if (_displayObject.stage != null) 
				{
					fps = _displayObject.stage.frameRate;
				}
				
				if (!equalTweenIsRunning(_displayObject, _props))
				{
					if (_overrideTweens)
					{
						for (var i:int = 0; i < _runningTweens.length; i++) 
						{
							if (TinyTween(_runningTweens[i]).displayObject == _displayObject)
							{
								for (var prop:* in _props)
								{
									if (TinyTween(_runningTweens[i]).props[prop] != null)
									{
										delete TinyTween(_runningTweens[i]).props[prop];
									}
								}
							}
						}
					}
					else
					{
						removeDisplayObjectTween(_displayObject);
					}
					
					var newtween:TinyTween = new TinyTween(_displayObject, _props, _time, _curve, _delay, _onComplete);
					
					_runningTweens.push(newtween);
				}
				else
				{
					trace("equalTweenIsRunning!!");
				}
			}
			else
			{
				trace("TinyTweener ::: displayObject is null");
			}
		}
		
		static private function equalTweenIsRunning(_displayObject:DisplayObject, _props:Object):Boolean 
		{
			for (var i:int = 0; i < _runningTweens.length; i++) 
			{
				if (TinyTween(_runningTweens[i]).displayObject == _displayObject)
				{
					if (compareObject(TinyTween(_runningTweens[i]).props, _props) == true)
					{
						return true;
					}
				}
			}
			
			return false;
		}
		
		private static function compareObject(obj1:Object,obj2:Object):Boolean
		{
			var buffer1:ByteArray = new ByteArray();
			buffer1.writeObject(obj1);
			
			var buffer2:ByteArray = new ByteArray();
			buffer2.writeObject(obj2);
		 
			// compare the lengths
			var size:uint = buffer1.length;
			
			if (buffer1.length == buffer2.length) 
			{
				buffer1.position = 0;
				buffer2.position = 0;
				
				// then the bits
				while (buffer1.position < size)
				{
					var v1:int = buffer1.readByte();
					
					if (v1 != buffer2.readByte()) 
					{
						return false;
					}
				}
				
				return true;
			}
			
			return false;
		}
		
		public static function stopTween(_displayObject:DisplayObject):void
		{
			if (removeDisplayObjectTween(_displayObject))
			{
				//CONFIG::debug { trace("TinyTweener ::: STOPPING ONE TWEEN"); };
			}
		}
		
		static public function removeDisplayObjectTween(_displayObject:DisplayObject):Boolean
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
					
					//CONFIG::debug { trace("TinyTweener ::: CLEANING ONE TWEEN"); };
				}
			}
		}
		
		///
		///
		///
		
		static private function getTweenFromDisplayObject(_displayObject:DisplayObject):TinyTween
		{
			for (var i:int = 0; i < _runningTweens.length; i++) 
			{
				if (TinyTween(_runningTweens[i]).displayObject == _displayObject)
				{
					return TinyTween(_runningTweens[i]);
				}
			}
			
			return null;
		}
		
	}

}