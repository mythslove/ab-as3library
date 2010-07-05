package com.senocular.gyro {
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Timer;
	
	/** 
	 * Manages event dispatching and event priority
	 * within motion classes used within the gyro package
	 */
	public class DynamicDispatcher extends EventDispatcher {
		// though an internal dispatcher is used for the dynamic
		// properties of the DynamicDispatcher, it still extends
		// EventDispatcher to provide subclasses with basic
		// EventDispatcher capabilities.
		
		// dispatching object for default enterFrame event
		private static const defaultDispatcher:Shape = new Shape();
		
		// dispatcher
		protected var _eventDispatcher:IEventDispatcher;
		// dispatcher properties
		protected var _eventType:String;
		protected var _eventPriority:int;
		protected var _eventUseWeakReference:Boolean;
		protected var _eventUseCapture:Boolean = false;
		protected var _eventEnabled:Boolean = false;

		/**
		 * The IEventDispatcher used to dispatch the event
		 */
		public function get eventDispatcher():IEventDispatcher {
			return _eventDispatcher;
		}
		public function set eventDispatcher(value:IEventDispatcher):void {
			if (value && value != _eventDispatcher)
				updateDispatcher(value, _eventType, _eventPriority, _eventUseWeakReference);
		}
		
		/**
		 * The type property of the event
		 */
		public function get eventType():String {
			return _eventType;
		}
		public function set eventType(value:String):void {
			if (value && value != eventType)
				updateDispatcher(_eventDispatcher, value, _eventPriority, _eventUseWeakReference);
		}
		
		/**
		 * The priority property of the event
		 */
		public function get eventPriority():int {
			return _eventPriority;
		}
		public function set eventPriority(value:int):void {
			if (value != _eventPriority)
				updateDispatcher(_eventDispatcher, _eventType, value, _eventUseWeakReference);
		}
		
		/**
		 * The useWeakReference property of the event
		 */
		public function get eventUseWeakReference():Boolean {
			return _eventUseWeakReference;
		}
		public function set eventUseWeakReference(value:Boolean):void {
			if (value != _eventUseWeakReference)
				updateDispatcher(_eventDispatcher, _eventType, _eventPriority, value);
		}
		
		/**
		 * The useCapture property of the event
		 */
		public function get eventUseCapture():Boolean {
			return _eventUseCapture;
		}
		
		/**
		 * Determines whether or not the event is firing for the object
		 */
		public function get eventEnabled():Boolean {
			return _eventEnabled;
		}
		public function set eventEnabled(value:Boolean):void {
			// existing value; do nothing
			if (value == _eventEnabled) return;
			
			_eventEnabled = value;
			
			// add or remove the event depending on whether
			// the events are being enabled or not
			if (_eventEnabled) {
				_eventDispatcher.addEventListener(_eventType, eventHandler, _eventUseCapture, _eventPriority, _eventUseWeakReference);
			}else{
				_eventDispatcher.removeEventListener(_eventType, eventHandler, _eventUseCapture);
			}
		}
		
		/**
		 * Constructor
		 */
		public function DynamicDispatcher(eventDispatcher:IEventDispatcher = null, type:String = Event.ENTER_FRAME, priority:int = 0, useWeakReference:Boolean = false){
			updateDispatcher(eventDispatcher, type, priority, useWeakReference);
			
			// assuming Timer dispatchers will want to start automatically
			// when provided; this makes it easy to pass new Timer()
			// instances directly within the constructor
			if (eventDispatcher is Timer) Timer(eventDispatcher).start();
		}
			
		/**
		 * Updates the dispatcher with new settings for the handler passed
		 */
		protected function updateDispatcher(eventDispatcher:IEventDispatcher = null, type:String = Event.ENTER_FRAME, priority:int = 0, useWeakReference:Boolean = false):void {
			// remove current listener only if enabled (otherwise there is none)
			if (_eventEnabled) _eventDispatcher.removeEventListener(_eventType, eventHandler, _eventUseCapture);
			
			// update property values
			_eventDispatcher = eventDispatcher ? eventDispatcher : defaultDispatcher;
			_eventType = type;
			_eventPriority = priority;
			_eventUseWeakReference = useWeakReference;
			
			// update current listener only if enabled (otherwise there is none)
			if (_eventEnabled) _eventDispatcher.addEventListener(_eventType, eventHandler, _eventUseCapture, _eventPriority, _eventUseWeakReference);
		}
		
		/**
		 * Default event handler for the dispatcher, typically 
		 * overridden in subclasses 
		 */
		protected function eventHandler(event:Event):void {}
			
	}
}