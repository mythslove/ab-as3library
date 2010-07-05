package com.senocular.gyro {
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * Creates a persistent process used for one or more objects to consistently
	 * act upon or "follow" a target object based on the behavior defined
	 * by an IModify instance
	 */
	public class Modifier
		extends DynamicDispatcher
		implements IStartable {
		
		protected var _modify:IModify;
		protected var interpolaterList:Array = [];
		protected var hasCustomModifyList:Dictionary = new Dictionary();
		
		protected static var defaultModify:Modify = new Modify();
		
		public function get modify():IModify {
			return (_modify != defaultModify) ? _modify : null;
		}
		public function set modify(value:IModify):void {
			_modify = (value) ? value : defaultModify;
		}
		
		public function Modifier(modify:IModify = null, eventDispatcher:IEventDispatcher = null, eventType:String = Event.ENTER_FRAME, eventPriority:int = 0){
			super(eventDispatcher, eventType, eventPriority);
			this.modify = (modify) ? modify : defaultModify;
			
			addEventListener(GyroEvent.START, startHandler, false, 0, true);
			addEventListener(GyroEvent.STOP, stopHandler, false, 0, true);
			
			start();
		}
		
		public function start():void {
			dispatchEvent(new GyroEvent(GyroEvent.START));
		}
		public function stop():void {
			dispatchEvent(new GyroEvent(GyroEvent.STOP));
		}
		
		public function addProperty(owner:*, property:String = "", modify:IModify = null):IInterpolate {
			return addInterpolate(new Interpolate(owner, property), modify);
		}
		public function addInterpolate(interpolater:Interpolate, modify:IModify = null):IInterpolate {
			if (modify) hasCustomModifyList[interpolater] = modify;
			interpolaterList.push(interpolater);
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
			if (interpolater in hasCustomModifyList) {
				delete hasCustomModifyList[interpolater];
			}
			return interpolater;
		}
		
		protected function startHandler(event:GyroEvent):void {
			eventEnabled = true;
		}
		
		protected function stopHandler(event:GyroEvent):void {
			eventEnabled = false;
		}
		
		protected override function eventHandler(event:Event):void {
			for each (var interpolater:IInterpolate in interpolaterList) {
				
				if (interpolater in hasCustomModifyList){
					IModify(hasCustomModifyList[interpolater]).call(interpolater);
				}else{
					_modify.call(interpolater);
				}
			}
		}
	}
}