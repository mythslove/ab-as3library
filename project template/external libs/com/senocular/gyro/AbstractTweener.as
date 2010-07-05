package com.senocular.gyro {

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * Defines a repeating action used to change one or more values over
	 * a pre-determined amount of time.
	 */
	public class AbstractTweener
		extends DynamicDispatcher
		implements IStartable {
		
		public static const REPEAT_FOREVER:int = -1;
		
		protected var interpolaterList:Array = [];
		protected var hasCustomEaseList:Dictionary = new Dictionary();
		
		// variables reflected as public properties
		protected var _ease:IEase;
		protected var _progress:Number = 0;
		protected var _value:Number = 0;
		protected var _repeatCount:int = 0;
		protected var _currentRepeat:int = 0;
		protected var _autoReverse:Boolean = false;
		protected var _reversed:Boolean = false;
		
		public function get ease():IEase {
			return _ease;
		}
		public function set ease(value:IEase):void {
			_ease = value;
		}
		
		public function get progress():Number {
			return _progress;
		}
		public function set progress(value:Number):void {
			if (_progress == value) return;
			_progress = value;
			draw();
		}
		public function get value():Number {
			return _value;
		}
		
		public function get repeatCount():int {
			return _repeatCount;
		}
		public function set repeatCount(value:int):void {
			if (_repeatCount == value) return;
			_repeatCount = value;
			if (_repeatCount < 0){
				_currentRepeat = 0;
			}else if (_currentRepeat > _repeatCount){
				_currentRepeat = _repeatCount;
			}
		}
		public function get currentRepeat():int {
			return _currentRepeat;
		}
		
		public function get autoReverse():Boolean {
			return _autoReverse;
		}
		public function set autoReverse(value:Boolean):void {
			_autoReverse = value;
		}
		public function get reversed():Boolean {
			return _reversed;
		}
		public function get paused():Boolean {
			return Boolean(_eventEnabled == false);
		}
		public function get stopped():Boolean {
			return Boolean(_eventEnabled == false && _progress == false);
		}
		
		/**
		 * Constructor.  AbstractTweener instances should not
		 * be created directly. Instead you should create subclasses
		 * of AbstractTweener and create instances of those.
		 * @param	ease An Ease object to defining easing for the Tweener
		 * @param	eventDispatcher An optional custom dispatcher to
		 * 			be used in dispatching update or tween events
		 * 			for this Tweener isntance.
		 * @param	eventType The event type for the event dispatcher.
		 * @param	eventPriority The priority for the event dispatcher.
		 */
		public function AbstractTweener(ease:IEase = null, eventDispatcher:IEventDispatcher = null, eventType:String = Event.ENTER_FRAME, eventPriority:int = 0) {
			super(eventDispatcher, eventType, eventPriority);
			_ease = ease;
			
			addEventListener(GyroEvent.START, startHandler, false, 0, true);
			addEventListener(GyroEvent.PAUSE, pauseHandler, false, 0, true);
			addEventListener(GyroEvent.TWEEN, tweenHandler, false, 0, true);
			addEventListener(GyroEvent.REVERSE, reverseHandler, false, 0, true);
			addEventListener(GyroEvent.REPEAT, repeatHandler, false, 0, true);
			addEventListener(GyroEvent.STOP, stopHandler, false, 0, true);
			addEventListener(GyroEvent.COMPLETE, completeHandler, false, 0, true);
		}
		
		/**
		 * Destructor.  Clears all events and nulls all object
		 * references for this Tweener instance.  After an
		 * instance's destructor has been called, it is unusable.
		 */
		public function destructor():void {
			removeEventListener(GyroEvent.START, startHandler, false);
			removeEventListener(GyroEvent.PAUSE, pauseHandler, false);
			removeEventListener(GyroEvent.TWEEN, tweenHandler, false);
			removeEventListener(GyroEvent.REVERSE, reverseHandler, false);
			removeEventListener(GyroEvent.REPEAT, repeatHandler, false);
			removeEventListener(GyroEvent.STOP, stopHandler, false);
			removeEventListener(GyroEvent.COMPLETE, completeHandler, false);
			eventEnabled = false;
			interpolaterList = null;
			hasCustomEaseList = null;
			_ease = null;
		}
		
		/**
		 * Starts the event handler for dispatching tween updates
		 * for the Tweener isntance.  If a Tweener has previously
		 * completed a tween, it will be reset to it's start
		 * position prior to restarting. Otherwise, the tween will
		 * continue from its current position.
		 */
		public function start():void {
			dispatchEvent(new GyroEvent(GyroEvent.START));
		}
				
		/**
		 * Pauses the playback of the tween by stopping
		 * the event handler dispatching tween updates.
		 */
		public function pause():void {
			dispatchEvent(new GyroEvent(GyroEvent.PAUSE));
		}
		
		/**
		 * Reverses the direction of a tween. When a Tweener
		 * instance is reversed, it's completion point 
		 * changes from the end to the start (though these
		 * values are not changed).  Reversing a previously
		 * reversed Tweener instance will restore normal 
		 * playback.
		 */
		public function reverse():void {
			dispatchEvent(new GyroEvent(GyroEvent.REVERSE));
		}
		
		/**
		 * Stops the tween and resets the Tweener instance
		 * to its start position.
		 */
		public function stop():void {
			dispatchEvent(new GyroEvent(GyroEvent.STOP));
		}
		
		/**
		 * Immediately completes a tween setting the position
		 * to the end position for normal playback or the
		 * start position for reversed playback or for when
		 * autoReverse is set to true.
		 */
		public function complete():void {
			dispatchEvent(new GyroEvent(GyroEvent.COMPLETE));
		}
		
		/**
		 * Adds a generic property interpolator to the tween's interpolation
		 * list. This allows you to change the numeric value of a named
		 * property in a target object between a start and end value.
		 * If a similar, existing interpolation exists, a copy is added
		 * and the original is not removed.
		 * @param	target The object owning the property to be used in the
		 * 			interpolation.
		 * @param	property The name of the property to be used in the
		 * 			interpolation.
		 * @param	start The start value for the property.
		 * @param	end The end value for the property.
		 * @param	ease An optional Ease instance specific to this property
		 * 			during a tween. If not provided, the Tweener's ease is used.
		 * @return	An InterpolateProperty instance representing the property
		 * 			interpolation.
		 */
		public function addProperty(target:*, property:String = "", start:Number = 0, end:Number = 1, ease:IEase = null):IInterpolate {
			return addInterpolate(new InterpolateProperty(start, end, target, property), ease);
		}
		
		/**
		 * Adds an angle property interpolator to the tween's interpolation
		 * list. This allows you to change the angle value of a named
		 * property in a target object between a start and end value.
		 * If a similar, existing interpolation exists, a copy is added
		 * and the original is not removed.
		 * @param	target The object owning the property to be used in the
		 * 			interpolation.
		 * @param	property The name of the property to be used in the
		 * 			interpolation.
		 * @param	start The start value for the property.
		 * @param	end The end value for the property.
		 * @param	ease An optional Ease instance specific to this property
		 * 			during a tween. If not provided, the Tweener's ease is used.
		 * @return	An InterpolateAngleProperty instance representing the property
		 * 			interpolation.
		 */
		public function addAngleProperty(target:*, property:String = "", start:Number = 0, end:Number = 1, ease:IEase = null):IInterpolate {
			return addInterpolate(new InterpolateAngleProperty(start, end, target, property), ease);
		}
		
		/**
		 * Adds a an IInterpolate instance to the tween's interpolation
		 * list. If the same IInterpolate exists within the Tweener, the
		 * original is removed and readded at the end of the Tweener's list.
		 * @param	interpolater The IInterpolate to be added to the
		 * 			Tweener's interpolation list.
		 * @param	ease An optional Ease instance specific to this property
		 * 			during a tween. If not provided, the Tweener's ease is used.
		 * @return	The IInterpolate instance added.
		 */
		public function addInterpolate(interpolater:IInterpolate, ease:IEase = null):IInterpolate {
			if (interpolater == null) return null;
			removeInterpolate(interpolater);
			interpolaterList.push(interpolater);
			if (ease) hasCustomEaseList[interpolater] = ease;
			return interpolater;
		}
		
		/**
		 * Removes an IInterpolate from a Tweener's interpolation list.
		 * @param	interpolater IInterpolate to be removed.
		 * @return	The IInterpolate instance removed.
		 */
		public function removeInterpolate(interpolater:IInterpolate):IInterpolate {
			if (interpolater == null) return null;
			
			// find the interpolater in the list and
			// splice out if present
			var index:int = interpolaterList.indexOf(interpolater);
			if (index != -1){
				interpolaterList.splice(index, 1);
			}
			
			// remove the interpolater from the 
			// custom ease list if present
			if (interpolater in hasCustomEaseList) {
				delete hasCustomEaseList[interpolater];
			}
			return interpolater;
		}
		
		// handlers to be implemented in subclasses
		protected function startHandler(event:GyroEvent):void {}
		protected function pauseHandler(event:GyroEvent):void {}
		protected function stopHandler(event:GyroEvent):void {}
		protected function reverseHandler(event:GyroEvent):void {}
		protected function repeatHandler(event:GyroEvent):void {}
		protected function completeHandler(event:GyroEvent):void {}
		protected function tweenHandler(event:GyroEvent):void {}
		
		protected override function eventHandler(event:Event):void {
			dispatchEvent(new GyroEvent(GyroEvent.TWEEN, this));
		}
		
		/**
		 * Updates the Tweener and all interpolates with the 
		 * latest values.
		 */
		public function draw():void {
			_value = (_ease) ? _ease.apply(_progress) : _progress;
			for each(var interpolater:IInterpolate in interpolaterList){
				if (interpolater in hasCustomEaseList) {
					interpolater.interpolate(IEase(hasCustomEaseList[interpolater]).apply(_progress));
				}else{
					interpolater.interpolate(_value);
				}
			}
		}
	}
}