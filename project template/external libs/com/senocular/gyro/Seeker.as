package com.senocular.gyro {
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * Creates a persistent process used for one or more objects to consistently
	 * act upon or "follow" a target object based on the behavior defined
	 * by an ISeek instance
	 */
	public class Seeker
		extends DynamicDispatcher
		implements IStartable {
		
		protected var _seek:ISeek;
		protected var _target:*;
		protected var _property:String;
		protected var interpolaterList:Array = [];
		protected var hasCustomSeekList:Dictionary = new Dictionary();
		
		protected static var defaultSeek:Seek = new Seek();
	
		public function get target():* {
			return _target;
		}
		public function set target(o:*):void {
			_target = o;
			updateInterpolaters();
		}
		
		public function get property():String {
			return _property;
		}
		public function set property(s:String):void {
			_property = s;
			updateInterpolaters();
		}
		
		public function get seek():ISeek {
			return (_seek != defaultSeek) ? _seek : null;
		}
		public function set seek(s:ISeek):void {
			_seek = (s) ? s : defaultSeek;
		}
		
		public function Seeker(target:*, property:String = "", seek:ISeek = null, eventDispatcher:IEventDispatcher = null, eventType:String = Event.ENTER_FRAME, eventPriority:int = 0){
			super(eventDispatcher, eventType, eventPriority);
			this.target = target;
			this.property = property;
			this.seek = (seek) ? seek : defaultSeek;
			
			addEventListener(GyroEvent.START, startHandler, false, 0, true);
			addEventListener(GyroEvent.STOP, stopHandler, false, 0, true);
			
			start();
		}
		
		public function start():void {
			dispatchEvent(new GyroEvent(GyroEvent.START, this));
		}
		public function stop():void {
			dispatchEvent(new GyroEvent(GyroEvent.STOP, this));
		}
		
		public function setTarget(target:*, property:String = ""){
			this.target = target;
			this.property = property;
		}
		
		public function addProperty(owner:*, property:String = "", seek:ISeek = null):IInterpolate {
			return addInterpolate(new InterpolateProperty(0, 1, owner, property));
		}
		
		public function addInterpolate(interpolater:IInterpolate, seek:ISeek = null):IInterpolate {
			removeInterpolate(interpolater);
			interpolaterList.push(interpolater);
			if (seek) hasCustomSeekList[interpolater] = seek;
			return interpolater;
		}
		
		/**
		 * Removes an interpolated object currently seeking
		 * this target instance.
		 */
		public function removeInterpolate(interpolater:IInterpolate):IInterpolate {
			var index:int = interpolaterList.indexOf(interpolater);
			if (index != -1){
				interpolaterList.splice(index, 1);
			}
			if (interpolater in hasCustomSeekList) {
				delete hasCustomSeekList[interpolater];
			}
			return interpolater;
		}
		
		protected function startHandler(event:GyroEvent):void {
			eventEnabled = true;
		}
		
		protected function stopHandler(event:GyroEvent):void {
			eventEnabled = false;
		}
		
		protected function updateInterpolaters():void {
			for each (var interpolater:IInterpolate in interpolaterList) {
				
				// interpolates typically have an end property
				// Seeks will use this to match the the target
				// TODO: need an interface type to check?
				if ("end" in interpolater){
					Object(interpolater).end = (target && property) ? target[property] : target;
				}
			}
		}
		
		protected override function eventHandler(event:Event):void {
			for each (var interpolater:IInterpolate in interpolaterList) {
				
				// interpolates typically have an end property
				// Seeks will use this to match the the target
				// TODO: need an interface type to check? But end will not have the same type
				// 		using * for Interfacing only is not recommended
				// TODO: should we really be modifying the interpolator?  Suspect not...
				if ("end" in interpolater){
					// this is updated for every event in case the
					// target value has changed
					Object(interpolater).end = (target && property) ? target[property] : target;
				}
				if (interpolater in hasCustomSeekList){
					ISeek(hasCustomSeekList[interpolater]).call(interpolater);
				}else{
					_seek.call(interpolater);
				}
				
				// TODO: determine if at destination
				if (false){
					dispatchEvent(new GyroEvent(GyroEvent.AT_DESTINATION, this));
				}
			}
		}
	}
}