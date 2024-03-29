package com.ab.tween
{
	/**
	* @TinyTween 
	* @author Antonio Brandao
	* 
	* Usage: 
	* 	var tween:TinyTween = new TinyTween(some_display_object, { alpha:0, y:20 }, 0.2, "easeOutSine );
	* 	var tween:TinyTween = new TinyTween(some_display_object, { alpha:0, y:20 } );
	* 
	* Time and transition equation are optional parameters.
	* 
	* If provided, the name of the transition type - e.g. "easeOutSine" must be provided correctly. Please check available equations below.
	* 
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class TinyTween extends Sprite 
	{
		public var displayObject		: DisplayObject;
		public var props				: Object;
		public var nome					: String;
		
		private var _totalTweenFrames	: int;
		private var _initPropValues		: Object;
		private var _time				: Number;
		private var _curve				: String;
		private var _delay				: Number;
		private var _framesLeftToFinish	: int;
		private var _tweenStartFrame	: Number;
		private var _delayTweenFrames	: Number;
		private var _completeCallback	: Function;
		
		public function TinyTween(displayObject:DisplayObject, _props:Object, _time:Number = 0.5, _curve:String = "easeOutSine", _delay:Number=0, _completeCallback:Function=null)
		{
			this.displayObject		= displayObject;
			this.props 				= _props;
			this._delay 			= _delay;
			this._curve 			= _curve;
			this._time 				= _time;
			this._completeCallback 	= _completeCallback;
			this._initPropValues	= new Object();
			
			_totalTweenFrames 		= Math.round(TinyTweener.fps * _time);
			_delayTweenFrames		= Math.round(TinyTweener.fps * _delay);
			_framesLeftToFinish		= _totalTweenFrames;
			
			for (var prop:* in props) 
			{
				/// store initial values for later usage
				
				_initPropValues[prop] = displayObject[prop];
				
				CONFIG::debug { trace( "tinytween: " + prop + " from " + displayObject[prop] + " to " + props[prop]); };
			}
			
			/// start animation
			
			this.addEventListener(Event.ENTER_FRAME, performMotion);
		}
		
		private function performMotion(e:Event):void 
		{
			if (_framesLeftToFinish != 0)
			{
				if (_delay != 0) 
				{
					_delayTweenFrames--;
					
					if (_delayTweenFrames >= 0)
					{
						return;
					}
				}
				
				_framesLeftToFinish--;
				
				/// go through each property provided to tween
				
				for (var prop:* in props) 
				{
					//trace("TinyTween ::: PERFORM");
					var diff:Number = props[prop] - _initPropValues[prop];
					
					displayObject[prop.toString()] = this[_curve](_totalTweenFrames - _framesLeftToFinish, _initPropValues[prop], diff, _totalTweenFrames);
				}
			}
			else
			{
				/// when tween ends
				
				if (_completeCallback != null) 
				{
					_completeCallback();
				}
				
				destroy();
			}
		}
        
        public function destroy():void
        {
			//trace("TinyTween ::: destroy()");
			// clean up
			this.removeEventListener(Event.ENTER_FRAME, performMotion);
			
			this.displayObject 		= null;
			this.props 				= null;
			this._curve 			= undefined;
			this._time 				= NaN;
			this._initPropValues	= null;
			
			TinyTweener.cleanTween(this);
        }
		
		/// Equations (by Robert Penner)
		/// 
		/// @t is the current time (or position) of the tween. This can be seconds or frames, steps, seconds, ms, whatever - as long as the unit is the same as is used for the total time.
		/// @b is the beginning value of the property.
		/// @c is the change between the beginning and destination value of the property.
		/// @d is the total time of the tween.
		
		/// linear
		private function linear 	(t:Number, b:Number, c:Number, d:Number):Number  	{ return c*t/d + b; }
		private function easeIn 	(t:Number, b:Number, c:Number, d:Number):Number  	{ return c*t/d + b; }
		private function easeOut 	(t:Number, b:Number, c:Number, d:Number):Number  	{ return c*t/d + b; }
		private function easeInOut 	(t:Number, b:Number, c:Number, d:Number):Number  	{ return c*t/d + b; }
		
		/// sine
		private function easeInSine 	(t:Number, b:Number, c:Number, d:Number):Number  { return -c * Math.cos(t/d * (Math.PI/2)) + c + b; }
		private function easeOutSine 	(t:Number, b:Number, c:Number, d:Number):Number  { return c * Math.sin(t/d * (Math.PI/2)) + b; }
		private function easeInOutSine 	(t:Number, b:Number, c:Number, d:Number):Number  { return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b; }
		
		/// Expo
		private function easeInExpo 	(t:Number, b:Number, c:Number, d:Number):Number  { return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b; }
		private function easeOutExpo 	(t:Number, b:Number, c:Number, d:Number):Number  { return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b; }
		private function easeInOutExpo 	(t:Number, b:Number, c:Number, d:Number):Number 
		{
			if (t==0) return b;
			if (t==d) return b+c;
			if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
			return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
		}
		
		
	}

}