package com.senocular.events {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * StageDetection 
	 * Lets a DisplayObject know when its been added to
	 * a display list attached to the stage.
	 *
	 * Usage:
	 * // used in the constructor where addedToStage and removedFromStage
	 * // are event handler methods
	 * var stageDetect:StageDetection = new StageDetection(this);
	 * stageDetect.addEventListener(StageDetection.ADDED_TO_STAGE, addedToStage);
	 * stageDetect.addEventListener(StageDetection.REMOVED_FROM_STAGE, removedFromStage);
	 */
	public class StageDetection extends EventDispatcher {
		
		protected var target:DisplayObject;
		protected var parents:Dictionary;
		protected var detect:String;
		
		public static const ADDED_TO_STAGE:String = "addedToStage";
		public static const REMOVED_FROM_STAGE:String = "removedFromStage";
		
		/**
		 * Constructor
		 */
		public function StageDetection(targetObject:DisplayObject) {
			target = targetObject;
			
			// determine whether need to detect for added or removed
			detect = (target.stage == null) ? Event.ADDED : Event.REMOVED; 
			
			// update parent listeners for detect events
			updateListeners();
		}
		
		/**
		 * updates listeners from which ADDED and REMOVED events are to be received
		 */
		protected function updateListeners(newDetect:String = null):void {
			
			// cleanup old listeners in parents
			if (parents) {
				for (var key:Object in parents) {
					key.removeEventListener(detect, stageCheck, false);
				}
			}
			
			// new event to detect if given
			if (newDetect) detect = newDetect;
				
			// set up detect event with current parents
			parents = new Dictionary(true);
			var parent:DisplayObject = target;
			while (parent) {
				parent.addEventListener(detect, stageCheck, false, 0, true);
				parents[parent] = true;
				parent = parent.parent;
			}
		}
		
		
		/**
		 * event handler for ADDED and REMOVED events checking for stage access
		 */
		protected function stageCheck(evt:Event):void {
			
			// only check for originating object
			if (evt.target != evt.currentTarget) return;
				
			// evt.type either ADDED or REMOVED
			switch(evt.type) {
				
				// parent added to another display object
				case Event.ADDED:
					
					// stage available, added to stage
					if (target.stage != null) {
						
						// added to stage, dispatch event, update
						dispatchEvent(new Event(ADDED_TO_STAGE));
						updateListeners(Event.REMOVED);
						
					// stage inaccessible, added to some other display object not on stage
					} else {
						
						// display list has changed, update parent listeners
						updateListeners();
					}
					break;
					
				// parent removed from stage
				case Event.REMOVED:
					
					// removed from stage, dispatch event, update
					dispatchEvent(new Event(REMOVED_FROM_STAGE));
					updateListeners(Event.ADDED);
					break;
			}
		}
	}
}