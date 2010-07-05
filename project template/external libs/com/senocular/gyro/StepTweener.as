package com.senocular.gyro {

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.*;
	
	/**
	 * Defines a repeating action used to change one or more values over
	 * a pre-determined number of steps.
	 */
	public class StepTweener
		extends AbstractTweener
		implements IStartable {
		
		protected var _steps:int = 0;
		protected var _currentStep:int = 0;
		protected var _repeatSeemless:Boolean = false;
			
		/**
		 * The total number of steps to be used
		 * when animating this tween.
		 */
		public function get steps():int {
			return _steps;
		}
		public function set steps(value:int):void {
			if (value == _steps) return;
			
			// _steps should never be less than 1
			_steps = Math.max(value, 1);
			
			// make sure _currentStep is within _steps
			if (_currentStep > _steps){
				_currentStep = _steps;
				
				// if updated, draw
				draw();
			}
		}
		
		/**
		 * The current step within the animation.
		 */
		public function get currentStep():int {
			return _currentStep;
		}
		public function set currentStep(value:int):void {
			if (value < 0) {
				value = 0;
			}else if (value > _steps){
				value = _steps;
			}
			if (value != _currentStep){
				_currentStep = value;
				draw();
			}
		}
		
		/**
		 * Determines if, when repeating, animation is
		 * done seemlessly.  Seemless animations skip
		 * the end step.  This way, tweens starting and
		 * ending in the same position don't repeat
		 * the same step in repeated animations.
		 */
		public function get repeatSeemless():Boolean {
			return _repeatSeemless;
		}
		public function set repeatSeemless(value:Boolean):void {
			_repeatSeemless = value;
		}
		
		/**
		 * Constructor 
		 */
		public function StepTweener(steps:int = 100, ease:IEase = null, eventDispatcher:IEventDispatcher = null, eventType:String = Event.ENTER_FRAME, eventPriority:int = 0) {
			super(ease, eventDispatcher, eventType, eventPriority);
			_steps = steps;
		}
				
		override protected function startHandler(event:GyroEvent):void {
			if ((!_reversed && _currentStep == _steps) || (_reversed && _currentStep == 0)){
				
				// starting from scratch then play
				_currentStep = 0;
				_progress = 0;
				_currentRepeat = 0;
				_reversed = false;
			}
			
			eventEnabled = true;
			draw();
		}
		
		override protected function reverseHandler(event:GyroEvent):void {
			_reversed = !_reversed;
			
			// if reversing and at the bounds of the tween
			// update _currentStep and _progress then draw
			// this is likely only to happen from autoReverse
			if (_reversed && _currentStep > _steps){
				_currentStep = (_repeatSeemless) ? _steps - 1 : _steps;
				_progress = _currentStep/_steps;
				draw();
			}
		}
		
		override protected function repeatHandler(event:GyroEvent):void {
			// only increment _currentRepeat if needed
			if (_repeatCount > 0) {
				_currentRepeat++;
			}
			
			// flag to determine whether or not the repeat
			// event is also forcing a reversal of playback
			// this will happen at the end of reverse
			// playback if _autoReverse is true
			var sendReverseEvent:Boolean = false;
				
			// when _autoReverse is true, playback will yo-yo
			// otherwise it will jump back to the other end
			
			if (_reversed){
				if (_autoReverse){
					
					// _currentTime just past 0 into the negatives
					// wrap to start of 0 or 1 if seemless
					_currentStep = (_repeatSeemless) ? 1 : 0;
					
					// signal that the reverse event should be
					// called.  It is not called here since
					// progress should be defined first
					sendReverseEvent = true;
					
				}else{
					
					// _currentStep just past 0 into the negatives
					// wrap to end of _steps or _steps - 1 if seemless
					_currentStep = (_repeatSeemless) ? _steps - 1 : _steps;
				}
			}else{
				
				// _currentStep just past _steps in the positives
				// wrap to start of 0 or 1 if seemless
				_currentStep = (_repeatSeemless) ? 1 : 0;
			}
			
			// update _progress before reverse event
			_progress = _currentStep/steps;
			
			if (sendReverseEvent){
				dispatchEvent(new GyroEvent(GyroEvent.REVERSE, this));
			}
			draw();
			
		}
		
		override protected function stopHandler(event:GyroEvent):void {
			eventEnabled = false;
			_currentStep = 0;
			_progress = 0;
			_currentRepeat = 0;
			_reversed = false;
			draw();
		}
		
		override protected function completeHandler(event:GyroEvent):void {
			eventEnabled = false;
			if (_reversed || _autoReverse){
				
				// when reversed, completion exists
				// at the start of the tween
				_currentStep = 0;
				_progress = 0;
			}else{
				
				// normal playback completes at the end
				_currentStep = _steps;
				_progress = 1;
			}
			draw();
		}
		
		override protected function tweenHandler(event:GyroEvent):void {
			
			if (_reversed){
				_currentStep--;
				
				// check bounds of _currentStep
				if (_currentStep < 0){
					
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
			}else{
				_currentStep++;
				
				if (_currentStep > _steps){
					
					// check for completion, reverse or repetition
					// these events will update _progress and draw the tween
					
					// check to see if the tween needs to reverse
					if (_autoReverse){
						
						// do not complete or repeat, but start new cycle backwards
						// call reverse event to reverse and set reverseTime
						dispatchEvent(new GyroEvent(GyroEvent.REVERSE, this));
						
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
			_progress = _currentStep/_steps;
			draw();
		}
	}
}