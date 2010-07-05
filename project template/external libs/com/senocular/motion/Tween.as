package com.senocular.motion {

	import flash.events.Event;
	import flash.display.Shape;
	import flash.events.IEventDispatcher;
	
	public class Tween extends Shape {
		
		protected var _target:*;
		protected var _property:String;
		protected var _start:Number;
		protected var _end:Number;
		protected var _range:Number;
		protected var _currentFrame:int;
		protected var _totalFrames:int;
		protected var _value:Number;
		protected var direction:int = 1;
		protected var _enabled:Boolean = true;
		protected var isValid:Boolean = false;
		protected var _easeMethod:Function;
		private var autoRemove:Boolean = true;
		private var eventTarget:IEventDispatcher;
		private var eventID:String;
			
		public function get target():* {
			return _target;
		}
		public function set target(o:*):void {
			_target = o;
		}
		public function get property():String {
			return _property;
		}
		public function set property(s:String):void {
			_property = s;
		}
		public function get start():Number {
			return _start;
		}
		public function set start(n:Number):void {
			_start = n;
			_range = _end - _start;
			isValid = false;
		}
		public function get end():Number {
			return _end;
		}
		public function set end(n:Number):void {
			_end = n;
			_range = _end - _start;
			isValid = false;
		}
		public function get currentFrame():int {
			return _currentFrame;
		}
		public function set currentFrame(n:int):void {
			if (n < 0) {
				n = 0;
			}else if (n > _totalFrames) {
				n = _totalFrames;
			}
			_currentFrame = n;
			isValid = false;
		}
		public function get totalFrames():int {
			return _totalFrames;
		}
		public function set totalFrames(n:int):void {
			_totalFrames = n;
			if (_currentFrame > _totalFrames) {
				_currentFrame = _totalFrames;
			}
			isValid = false;
		}
		public function get value():Number {
			if (!isValid) {
				var t:Number = _currentFrame/_totalFrames;
				if (Boolean(_easeMethod)) {
					t = _easeMethod(t);
				}
				_value = _start + _range*t;
				isValid = true;
			}
			return _value;
		}
		public function get playBackwards():Boolean {
			return (direction < 0);
		}
		public function set playBackwards(b:Boolean):void {
			direction = b ? -1 : 1;
		}
		
		public function get easeMethod():Function {
			return _easeMethod;
		}
		public function set easeMethod(f:Function):void {
			_easeMethod = f;
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		public function set enabled(b:Boolean):void {
			_enabled = b;
		}
		
		/**
		 * Constructor 
		 */
		public function Tween(target:* = null, property:String = null, start:Number = 0, end:Number = 100, totalFrames:int = 100, easeMethod:Function = null) {
			_target = target;
			_property = property;
			_start = start;
			_end = end;
			_range = _end - _start;
			_totalFrames = totalFrames;
			_currentFrame = 0;
			_easeMethod = easeMethod;
			_value = value;
			
		}
		public function nextFrame(evt:Event = null):Number {
			if (!_enabled) {
				return _value;
			}
			var lastValue:Number = _value;
			currentFrame += direction;
			var v:Number = value;
			if (v == lastValue) {
				return _value;
			}
			draw();
			dispatchEvent(new Event(Event.CHANGE));
			if (_currentFrame == 0 || _currentFrame == _totalFrames) {
				if (eventTarget && autoRemove) {
					removeNextFrameEvent();
					eventTarget = null;
				}
				dispatchEvent(new Event(Event.COMPLETE));
			}
			return v;
		}
		public function nextFrameEvent(eventTarget:IEventDispatcher, eventID:String = Event.ENTER_FRAME, autoRemove:Boolean = true):void {
			removeNextFrameEvent();
			this.eventTarget = eventTarget;
			this.eventID = eventID;
			eventTarget.addEventListener(eventID, nextFrame);
			this.autoRemove = autoRemove;
		}
		public function removeNextFrameEvent():void {
			if (this.eventTarget) {
				eventTarget.removeEventListener(eventID, nextFrame);
				this.eventTarget = null;
			}
		}
		public function draw(evt:Event = null):void {
			if (_target && _property) {
				_target[_property] = value;
			}
		}
		public function complete(evt:Event = null):void {
			removeNextFrameEvent();
			_currentFrame = _totalFrames;
			isValid = false;
			draw();
		}
		public function reset(evt:Event = null):void {
			removeNextFrameEvent();
			_currentFrame = 0;
			isValid = false;
		}
		public function reverse(evt:Event = null):void {
			playBackwards = !playBackwards;
		}
	}
}