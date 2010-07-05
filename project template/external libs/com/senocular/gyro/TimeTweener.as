package com.senocular.gyro {

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.getTimer;
	
	/**
	 * Defines a repeating action used to change one or more values over
	 * a pre-determined amount of time.
	 */
	public class TimeTweener
		extends AbstractTweener
		implements IStartable {
		
		protected var _time:int;
		protected var _currentTime:int = 0;
			
		// help calculating position
		private var startTime:int = -1;
		private var pauseTime:int = 0;
			
		public function get time():int {
			return _time;
		}
		public function set time(value:int):void {
			// _time should never be less than 1
			if (value < 1){
				value = 1;
			}
			
			// exit if _time already has this value
			if (value == _time) return;
			
			_time = value;
			
			// make sure _currentTime is within _time
			if (_currentTime > _time){
				_currentTime = _time;
			}
			
			// if updated, calculate _progress and draw
			_progress = _currentTime/_time;
			draw();
		}
		
		public function get currentTime():int {
			return _currentTime;
		}
		public function set currentTime(value:int):void {
			// clamp _currentTime between 0 and _time
			if (value < 0){
				value = 0;
			}else if (value > _time){
				value = _time;
			}
			
			// exit if _currnetTime already has this value
			if (value == _currentTime) return;
			
			_currentTime = value;
			
			// if updated, calculate _progress and draw
			_progress = _currentTime/_time;
			draw();
		}
		
		/**
		 * Constructor 
		 */
		public function TimeTweener(time:int = 1000, ease:IEase = null, eventDispatcher:IEventDispatcher = null, eventType:String = Event.ENTER_FRAME, eventPriority:int = 0){
			super(ease, eventDispatcher, eventType, eventPriority);
			_time = time;
		}
		override protected function startHandler(event:GyroEvent):void {
			if (startTime == -1){
				
				// starting from scratch then play
				_currentTime = 0;
				_progress = 0;
				_currentRepeat = 0;
				_reversed = false;
				startTime = getTimer();
			}else{
				
				// resuming playback
				// offset startTime
				startTime += getTimer() - pauseTime;
				
				// reset pauseTime to 0
				pauseTime = 0;
			}
			
			eventEnabled = true;
			draw();
		}
		override protected function pauseHandler(event:GyroEvent):void {
			eventEnabled = false;
			pauseTime = getTimer();
		}
		override protected function reverseHandler(event:GyroEvent):void {
			_reversed = !_reversed;
			
			if (_reversed){
				
				if (_currentTime >= _time){
						
					// offset start time to represent the new cycle time
					startTime += _time;

					// update _currentTime and _progress
					// for other reverse event handlers
					_currentTime = _time - (_currentTime - _time);
					_progress = _currentTime/_time;
					
					draw();
				}else{
					
					startTime = getTimer() - (_time - _currentTime);
				}
			}else{
				
				startTime = getTimer() - _currentTime;
			}
		}
		override protected function repeatHandler(event:GyroEvent):void {
			// only increment _currentRepeat if needed
			if (_repeatCount > 0) {
				_currentRepeat++;
			}
			
			// time-based always repeatSeemless
			startTime += _time;
			
			// flag to determine whether or not the repeat
			// event is also forcing a reversal of playback
			// this will happen at the end of reverse
			// playback if _autoReverse is true
			var sendReverseEvent:Boolean = false;
			
			if (_reversed){
				if (_autoReverse){
					
					// _currentTime just past 0 into the negatives
					// invert to wrap
					_currentTime = -_currentTime;
					
					// signal that the reverse event should be
					// called.  It is not called here since
					// progress should be defined first
					sendReverseEvent = true;
					
				}else{
					
					// _currentTime just past 0 into the negatives
					// add _time to wrap it at the end
					_currentTime += _time;
				}
			}else{
				
				// _currentTime just past _time in the positives
				// subtract _time to wrap it at the end
				_currentTime -= _time;
			}			
			
			// update _progress before reverse event
			_progress = _currentTime/_time;
			
			// call reverse event if coming out of reverse playback
			// changing _reversed to false
			if (sendReverseEvent) {
				dispatchEvent(new GyroEvent(GyroEvent.REVERSE, this));
			}
			draw();
		}
		override protected function stopHandler(event:GyroEvent):void {
			
			// clear the tween event
			// and reset all values
			eventEnabled = false;
			_currentTime = 0;
			_progress = 0;
			_currentRepeat = 0;
			startTime = -1;
			_reversed = false;
			draw();
		}
		override protected function completeHandler(event:GyroEvent):void {
			
			// clear the tween evetn
			eventEnabled = false;
			
			if (_reversed || _autoReverse){
				
				// when reversed, completion exists
				// at the start of the tween
				_currentTime = 0;
				_progress = 0;
				
			}else{
				
				// normal playback completes at the end
				_currentTime = _time;
				_progress = 1;
			}
			
			// startTime is cleared for completion
			startTime = -1;
			draw();
		}

		override protected function tweenHandler(event:GyroEvent) :void {
			
			if (_reversed){
				
				// _currentTime is inverted for reverse playback
				_currentTime = _time - (getTimer() - startTime);
				
				// completion of reversed time is when _currentTime
				// is equal to or less than 0
				if (_currentTime <= 0){
					
					// if the tween is repeating
					if (_repeatCount < 0 || _currentRepeat < _repeatCount){
						
						// repeating indefinitely or upto a count
						dispatchEvent(new GyroEvent(GyroEvent.REPEAT, this));
						
					}else{
						
						// tween has ended
						dispatchEvent(new GyroEvent(GyroEvent.COMPLETE, this));
					}
					
					// done; exit
					return;
				}
				
			// not reversed; normal playback
			}else{
				
				// current time based off difference of getTimer time from startTime
				_currentTime = getTimer() - startTime;
				
				// completion of normal time is when _currentTime
				// is equal to or greater than _time
				if (_currentTime >= _time){
						
					// check to see if the tween needs to reverse
					if (_autoReverse){
						
						// do not complete or repeat, but start new cycle backwards
						dispatchEvent(new GyroEvent(GyroEvent.REVERSE, this));
						
					// if the tween is repeating
					}else if (_repeatCount < 0 || _currentRepeat < _repeatCount){
						
						// repeating indefinitely or upto a count
						dispatchEvent(new GyroEvent(GyroEvent.REPEAT, this));
						
					}else{
						
						// tween has ended
						dispatchEvent(new GyroEvent(GyroEvent.COMPLETE, this));
					}
					
					// done; exit
					return;
				}
			}
			
			// normal/reversed tweening or in the process of being reversed
			_progress = _currentTime/_time;
			draw();
		}
	}
}