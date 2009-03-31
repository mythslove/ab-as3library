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
	
	public class Move 
	{
		static private var _ASM_COUNTER:Number;
		static private var _ASM_ARRAY:Array;
		static private var _ASM_XPOS:Number
		static private var _ASM_TIME:Number
		static private var _ASM_ROOT:Object
		
		static private var _ASMV_COUNTER:Number;
		static private var _ASMV_ARRAY:Array;
		static private var _ASMV_XPOS:Number
		static private var _ASMV_TIME:Number
		static private var _ASM_PROPERTY_X:String;
		static private var _ASM_PROPERTY_Y:String;
		static private var _ASMX_PROPERTY_X:String;
		static private var _ASMY_PROPERTY_Y:String;
		static private var _ASMY_COUNTER:Number;
		static private var _ASMY_ARRAY:Array;
		static private var _ASMY_TIME:Number;
		static private var _ASMX_COUNTER:Number;
		static private var _ASMX_ARRAY:Array;
		static private var _ASMX_TIME:Number;
		static private var _ASM_POSITION_Y:Number;
		static private var _ASM_POSITION_X:Number;
		static private var _ASMX_POSITION_Y:Number;
		static private var _ASMY_POSITION_Y:Number;
		static private var _ASMY_ALPHA:Number;
		static private var _ASMX_EXCEPTION:Object;
		static private var _ASMY_EXCEPTION:Object;
		static private var _ASMX_POSITION_X:Number;
		static private var _ASMX_ALPHA:Number;
		static private var _ASMX_OC_FUNCTION:Function;
		static private var _ASMY_OC_FUNCTION:Function;
		
		public function Move() 
		{
			_ASM_ARRAY = new Array()
		}
		
		///////////// MCS ///////////////////////
		
		////////////////////////// TO POSITION X
		
		public static function ToPositionX(mc:Object, xpos:Number, _time:Number=0.5, alphavalue=NaN, _delay:Number=0, _transition:String="EaseOutSine"):void
		{
			Tweener.addTween(mc, {x:xpos, time:_time, alpha:isNaN(alphavalue) ? 1 : alphavalue, delay:_delay , transition:_transition})
		}
		
		////////////////////////// TO POSITION Y
		
		public static function ToPositionY(mc:Object, ypos:Number, _time:Number=0.5, alphavalue:Number=NaN, _delay:Number=0, _transition:String="EaseOutSine"):void
		{
			Tweener.addTween(mc, { y:ypos, time:_time, alpha:isNaN(alphavalue) ? 1 : alphavalue, delay:_delay , transition:_transition } )
			/*
			if (isNaN(alphavalue)) 
			{
				Tweener.addTween(mc, {y:ypos, time:_time, transition:_transition})
			}
			else
			{
				Tweener.addTween(mc, {y:ypos, alpha:alphavalue, time:_time, transition:_transition})
			}*/
		}
		
		////////////////////////// TO POSITION Y Custom Ease
		
		public static function ToPositionYCustomEase(mc:Object, ypos:Number, time:Number):void
		{
			TweenLite.to(mc, time, { y:ypos, ease:Bounce.easeInOut} );
		}
		
		////////////////////////// TO POSITION X Y
		
		public static function ToPositionXY(mc:Object, xpos:Number, ypos:Number, time:Number, alphavalue:Number=NaN, transitionstyle:Function=null):void
		{
			if (isNaN(alphavalue)) 
			{
				if (transitionstyle == null) 
				{
					TweenLite.to(mc, time, { x:xpos, y:ypos, ease:Sine.easeOut } );
				}
				else
				{
					TweenLite.to(mc, time, { x:xpos, y:ypos, ease:transitionstyle } );
				}
			}
			else
			{
				if (transitionstyle == null) 
				{
					TweenLite.to(mc, time, { x:xpos, y:ypos, alpha:alphavalue, ease:Sine.easeOut } );
				}
				else
				{
					TweenLite.to(mc, time, { x:xpos, y:ypos, alpha:alphavalue, ease:transitionstyle } );
				}
			}
		}
		
		////////////////////////// TO POSITION X WITH RESIZE
		
		public static function ToPositionXresizeWidth(mc:Object, xpos:Number, _width:Number, time:Number ):void
		{
			TweenLite.to(mc, time, { x:xpos, width:_width, alpha:1, ease:Elastic.easeOut} );
		}
		
		///////////// ARRAYS ///////////////////////
		
		////////////////////////// ARRAY TO POSITION X
		////////////////////////// ARRAY TO POSITION X
		////////////////////////// ARRAY TO POSITION X
		////////////////////////// ARRAY TO POSITION X
		
		public static function arrayToPositionX(array:Array, time:Number, position:Number, alphavalue:Number=NaN, exception:Object=null):void
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				if (exception == null) 
				{
					if (isNaN(alphavalue))
					{
						TweenLite.to(array[i], time, { x:position, ease:Linear.easeOut } );
					}
					else
					{
						TweenLite.to(array[i], time, { x:position, alpha:alphavalue, ease:Linear.easeOut } );
					}
				}
				else
				{
					if (array[i] != exception) 
					{
						if (isNaN(alphavalue))
						{
							TweenLite.to(array[i], time, { x:position, ease:Linear.easeOut } );
						}
						else
						{
							TweenLite.to(array[i], time, { x:position, alpha:alphavalue, ease:Linear.easeOut } );
						}
					}
				}
			}
		}
		
		////////////////////////// ARRAY TO POSITION Y
		////////////////////////// ARRAY TO POSITION Y
		////////////////////////// ARRAY TO POSITION Y
		////////////////////////// ARRAY TO POSITION Y
		
		public static function arrayToPositionY(array:Array, time:Number, position:Number, alphavalue:Number=NaN, exception:Object=null):void
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				if (exception == null) 
				{
					if (isNaN(alphavalue))
					{
						TweenLite.to(array[i], time, { y:position, ease:Linear.easeOut } );
					}
					else
					{
						TweenLite.to(array[i], time, { y:position, alpha:alphavalue, ease:Linear.easeOut } );
					}
				}
				else
				{
					if (array[i] != exception) 
					{
						if (isNaN(alphavalue))
						{
							TweenLite.to(array[i], time, { y:position, ease:Linear.easeOut } );
						}
						else
						{
							TweenLite.to(array[i], time, { y:position, alpha:alphavalue, ease:Linear.easeOut } );
						}
					}
				}
			}
		}
		
		////////////////////////// ARRAY TO PROPERTY POSITION X
		////////////////////////// ARRAY TO PROPERTY POSITION X
		////////////////////////// ARRAY TO PROPERTY POSITION X
		////////////////////////// ARRAY TO PROPERTY POSITION X
		
		public static function arrayToPropertyPositionX(array:Array, time:Number, property:String, alphavalue:Number=NaN, exception:Object=null):void
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				if (exception == null) 
				{
					if (isNaN(alphavalue))
					{
						TweenLite.to(array[i], time, { x:array[i][property], ease:Linear.easeOut } );
					}
					else
					{
						TweenLite.to(array[i], time, { x:array[i][property], alpha:alphavalue, ease:Linear.easeOut } );
					}
				}
				else
				{
					if (array[i] != exception) 
					{
						if (isNaN(alphavalue))
						{
							TweenLite.to(array[i], time, { x:array[i][property], ease:Linear.easeOut } );
						}
						else
						{
							TweenLite.to(array[i], time, { x:array[i][property], alpha:alphavalue, ease:Linear.easeOut } );
						}
					}
				}
			}
		}
		
		////////////////////////// ARRAY TO PROPERTY POSITION Y
		////////////////////////// ARRAY TO PROPERTY POSITION Y
		////////////////////////// ARRAY TO PROPERTY POSITION Y
		////////////////////////// ARRAY TO PROPERTY POSITION Y
		
		public static function arrayToPropertyPositionY(array:Array, time:Number, property:String, alphavalue:Number=NaN, exception:Object=null):void
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				if (exception == null) 
				{
					if (isNaN(alphavalue))
					{
						TweenLite.to(array[i], time, { y:array[i][property], ease:Linear.easeOut } );
					}
					else
					{
						TweenLite.to(array[i], time, { y:array[i][property], alpha:alphavalue, ease:Linear.easeOut } );
					}
				}
				else
				{
					if (array[i] != exception) 
					{
						if (isNaN(alphavalue))
						{
							TweenLite.to(array[i], time, { y:array[i][property], ease:Linear.easeOut } );
						}
						else
						{
							TweenLite.to(array[i], time, { y:array[i][property], alpha:alphavalue, ease:Linear.easeOut } );
						}
					}
				}
			}
		}
		
		////////////////////////// ARRAY SEQUENTIALLY TO POSITION X
		////////////////////////// ARRAY SEQUENTIALLY TO POSITION X
		////////////////////////// ARRAY SEQUENTIALLY TO POSITION X
		////////////////////////// ARRAY SEQUENTIALLY TO POSITION X
		
		public static function arraySequentiallyToPositionX(array:Array, position_x:Number, time:Number, alphavalue:Number=NaN, exception:Object=null, on_complete_function:Function=null):void
		{
			_ASMX_COUNTER = 0
			_ASMX_ARRAY = array
			_ASMX_TIME = time
			_ASMX_POSITION_X = position_x
			
			if (on_complete_function != null) 
			{
				_ASMX_OC_FUNCTION = on_complete_function
			}
			
			if (exception != null) 
			{
				_ASMX_EXCEPTION = exception
			}
			
			if (!isNaN(alphavalue))
			{
				_ASMX_ALPHA = alphavalue
			}
			
			performASMX()
		}
		
		static private function performASMX():void
		{
			if (_ASMX_ARRAY[_ASMX_COUNTER] != null )
			{
				if (_ASMX_EXCEPTION == null) 
				{
					if (isNaN(_ASMX_ALPHA))
					{
						TweenLite.to(_ASMX_ARRAY[_ASMX_COUNTER], _ASMX_TIME, { x:_ASMX_POSITION_X, ease:Linear.easeInOut, onComplete:performASMX} );
					}
					else
					{
						TweenLite.to(_ASMX_ARRAY[_ASMX_COUNTER], _ASMX_TIME, { x:_ASMX_POSITION_X, alpha:_ASMX_ALPHA, ease:Linear.easeInOut, onComplete:performASMX} );
					}
				}
				else
				{
					if (_ASMX_ARRAY[_ASMX_COUNTER] != _ASMX_EXCEPTION) 
					{
						if (isNaN(_ASMX_ALPHA))
						{
							TweenLite.to(_ASMX_ARRAY[_ASMX_COUNTER], _ASMX_TIME, { x:_ASMX_POSITION_X, ease:Linear.easeInOut, onComplete:performASMX} );
						}
						else
						{
							TweenLite.to(_ASMX_ARRAY[_ASMX_COUNTER], _ASMX_TIME, { x:_ASMX_POSITION_X, alpha:_ASMX_ALPHA, ease:Linear.easeInOut, onComplete:performASMX} );
						}
					}
				}
				
				_ASMX_COUNTER++
			}
			else
			{
				if (_ASMX_OC_FUNCTION != null) 
				{
					_ASMX_OC_FUNCTION()
				}
			}
		}
		
		////////////////////////// ARRAY SEQUENTIALLY TO POSITION Y
		////////////////////////// ARRAY SEQUENTIALLY TO POSITION Y
		////////////////////////// ARRAY SEQUENTIALLY TO POSITION Y
		////////////////////////// ARRAY SEQUENTIALLY TO POSITION Y
		
		public static function arraySequentiallyToPositionY(array:Array, position_y:Number, time:Number, alphavalue:Number=NaN, exception:Object=null, on_complete_function:Function=null):void
		{
			_ASMY_COUNTER = 0
			_ASMY_ARRAY = array
			_ASMY_TIME = time
			_ASMY_POSITION_Y = position_y
			
			if (on_complete_function != null) 
			{
				_ASMY_OC_FUNCTION = on_complete_function
			}
			
			if (exception != null) 
			{
				_ASMY_EXCEPTION = exception
			}
			
			if (!isNaN(alphavalue))
			{
				_ASMY_ALPHA = alphavalue
			}
			
			performASMY()
		}
		
		static private function performASMY():void
		{
			if (_ASMY_ARRAY[_ASMY_COUNTER] != null)
			{
				if (_ASMY_EXCEPTION == null) 
				{
					if (isNaN(_ASMY_ALPHA))
					{
						TweenLite.to(_ASMY_ARRAY[_ASMY_COUNTER], _ASMY_TIME, { y:_ASMY_POSITION_Y, ease:Linear.easeInOut, onComplete:performASMY} );
					}
					else
					{
						TweenLite.to(_ASMY_ARRAY[_ASMY_COUNTER], _ASMY_TIME, { y:_ASMY_POSITION_Y, alpha:_ASMY_ALPHA, ease:Linear.easeInOut, onComplete:performASMY} );
					}
				}
				else
				{
					if (_ASMY_ARRAY[_ASMY_COUNTER] != _ASMY_EXCEPTION) 
					{
						if (isNaN(_ASMY_ALPHA))
						{
							TweenLite.to(_ASMY_ARRAY[_ASMY_COUNTER], _ASMY_TIME, { y:_ASMY_POSITION_Y, ease:Linear.easeInOut, onComplete:performASMY} );
						}
						else
						{
							TweenLite.to(_ASMY_ARRAY[_ASMY_COUNTER], _ASMY_TIME, { y:_ASMY_POSITION_Y, alpha:_ASMY_ALPHA, ease:Linear.easeInOut, onComplete:performASMY} );
						}
					}
				}
				
				_ASMY_COUNTER++
			}
			else
			{
				if (_ASMY_OC_FUNCTION != null) 
				{
					_ASMY_OC_FUNCTION()
				}
			}
		}
		
		////////////////////////// ARRAY SEQUENTIALLY TO PROPERTY POSITION X
		////////////////////////// ARRAY SEQUENTIALLY TO PROPERTY POSITION X
		////////////////////////// ARRAY SEQUENTIALLY TO PROPERTY POSITION X
		////////////////////////// ARRAY SEQUENTIALLY TO PROPERTY POSITION X
		
		public static function arraySequentiallyToPropertyPositionX(array:Array, property_x:String, time:Number, alphavalue:Number=NaN, exception:Object=null):void
		{
			_ASMX_COUNTER = 0
			_ASMX_ARRAY = array
			_ASMX_TIME = time
			_ASMX_PROPERTY_X = property_x
			
			if (exception != null) 
			{
				_ASMX_EXCEPTION = exception
			}
			
			if (!isNaN(alphavalue))
			{
				_ASMX_ALPHA = alphavalue
			}
			
			performASMXProp()
		}
		
		static private function performASMXProp():void
		{
			if (_ASMX_ARRAY[_ASMX_COUNTER] != null ) 
			{
				if (_ASMX_EXCEPTION == null) 
				{
					if (isNaN(_ASMX_ALPHA))
					{
						TweenLite.to(_ASMX_ARRAY[_ASMX_COUNTER], _ASMX_TIME, { x:_ASMX_ARRAY[_ASMX_COUNTER][_ASMX_PROPERTY_X], ease:Linear.easeInOut, onComplete:performASMXProp} );
					}
					else
					{
						TweenLite.to(_ASMX_ARRAY[_ASMX_COUNTER], _ASMX_TIME, { x:_ASMX_ARRAY[_ASMX_COUNTER][_ASMX_PROPERTY_X], alpha:_ASMX_ALPHA, ease:Linear.easeInOut, onComplete:performASMXProp} );
					}
				}
				else
				{
					if (_ASMX_ARRAY[_ASMX_COUNTER] != _ASMX_EXCEPTION)
					{
						if (isNaN(_ASMX_ALPHA))
						{
							TweenLite.to(_ASMX_ARRAY[_ASMX_COUNTER], _ASMX_TIME, { x:_ASMX_ARRAY[_ASMX_COUNTER][_ASMX_PROPERTY_X], ease:Linear.easeInOut, onComplete:performASMXProp} );
						}
						else
						{
							TweenLite.to(_ASMX_ARRAY[_ASMX_COUNTER], _ASMX_TIME, { x:_ASMX_ARRAY[_ASMX_COUNTER][_ASMX_PROPERTY_X], alpha:_ASMX_ALPHA, ease:Linear.easeInOut, onComplete:performASMXProp} );
						}
					}
				}
				
				_ASMX_COUNTER++
			}
		}
		
		////////////////////////// ARRAY SEQUENTIALLY TO PROPERTY POSITION Y
		////////////////////////// ARRAY SEQUENTIALLY TO PROPERTY POSITION Y
		////////////////////////// ARRAY SEQUENTIALLY TO PROPERTY POSITION Y
		////////////////////////// ARRAY SEQUENTIALLY TO PROPERTY POSITION Y
		
		public static function arraySequentiallyToPropertyPositionY(array:Array, property_y:String, time:Number, alphavalue:Number=NaN, exception:Object=null):void
		{
			_ASMY_COUNTER = 0
			_ASMY_ARRAY = array
			_ASMY_TIME = time
			_ASMY_PROPERTY_Y = property_y
			
			if (exception != null) 
			{
				_ASMY_EXCEPTION = exception
			}
			
			if (!isNaN(alphavalue)) 
			{
				_ASMY_ALPHA = alphavalue
			}
			
			performASMYProp()
		}
		
		static private function performASMYProp():void
		{
			if (_ASMY_ARRAY[_ASMY_COUNTER] != null ) 
			{
				if (_ASMY_EXCEPTION == null) 
				{
					if (isNaN(_ASMY_ALPHA))
					{
						TweenLite.to(_ASMY_ARRAY[_ASMY_COUNTER], _ASMY_TIME, { y:_ASMY_ARRAY[_ASMY_COUNTER][_ASMY_PROPERTY_Y], ease:Linear.easeInOut, onComplete:performASMYProp } );
					}
					else
					{
						TweenLite.to(_ASMY_ARRAY[_ASMY_COUNTER], _ASMY_TIME, { y:_ASMY_ARRAY[_ASMY_COUNTER][_ASMY_PROPERTY_Y], alpha:_ASMY_ALPHA, ease:Linear.easeInOut, onComplete:performASMYProp } );
					}
				}
				else
				{
					if (_ASMY_ARRAY[_ASMY_COUNTER] != _ASMY_EXCEPTION) 
					{
						if (isNaN(_ASMY_ALPHA))
						{
							TweenLite.to(_ASMY_ARRAY[_ASMY_COUNTER], _ASMY_TIME, { y:_ASMY_ARRAY[_ASMY_COUNTER][_ASMY_PROPERTY_Y], ease:Linear.easeInOut, onComplete:performASMYProp } );
						}
						else
						{
							TweenLite.to(_ASMY_ARRAY[_ASMY_COUNTER], _ASMY_TIME, { y:_ASMY_ARRAY[_ASMY_COUNTER][_ASMY_PROPERTY_Y], alpha:_ASMY_ALPHA, ease:Linear.easeInOut, onComplete:performASMYProp } );
						}
					}
				}
				
				_ASMY_COUNTER++
			}
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		
		// TODO ::: FINISH THIS ONE  // TODO ::: FINISH THIS ONE  // TODO ::: FINISH THIS ONE  // TODO ::: FINISH THIS ONE  
		public static function arrayToRelativePositionYexceptClip(array:Array, time:Number, relativeposition:Number, exception:Object):void
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				if (array[i] != exception) 
				{
					TweenLite.to(array[i], time, { y:(array[i].y += relativeposition), ease:Linear.easeOut } );
				}
			}
		}
		// TODO ::: FINISH THIS ONE  // TODO ::: FINISH THIS ONE  // TODO ::: FINISH THIS ONE  // TODO ::: FINISH THIS ONE  
		public static function arrayToRelativePositionXexceptClip(array:Array, time:Number, relativeposition:Number, exception:Object):void
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				if (array[i] != exception) 
				{
					TweenLite.to(array[i], time, { x:(array[i].x += relativeposition), ease:Linear.easeOut } );
				}
			}
		}
		
		
	}                                                                              
}