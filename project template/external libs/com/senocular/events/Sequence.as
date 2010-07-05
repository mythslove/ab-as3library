/**
 * Sequence
 * creates a sequence of method calls that are called in sequence based 
 * upon completion events.
 */
package com.senocular.events {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Sequence extends EventDispatcher {
		
		private var calls:Array = new Array();	// list of SequenceEvent objects
		private var position:int = 0;			// position within calls
		private var currSeqEvt:SequenceEvent;	// current event
		private var nextSeqEvt:SequenceEvent;	// next event to be called when current event completes
		
		/**
		 * Constructor 
		 */
		public function Sequence() {}
		
		/**
		 * play
		 * initiates a sequence using current position (not necessarily 0)
		 */
		public function play():void {
			nextSeqEvt = calls[position];
			nextCall();
		}
		
		/**
		 * stop
		 * stops a sequence from continuing
		 */
		public function stop():void {
			
			// remove listener if currSeqEvt exists
			if (currSeqEvt) {
				currSeqEvt.target.removeEventListener(currSeqEvt.eventID, nextCall);
			}
		}
		
		/**
		 * reset
		 * reset a sequence stopping it and setting its position to 0
		 */
		public function reset():void {
			
			// remove listener if currSeqEvt exists
			if (currSeqEvt) {
				currSeqEvt.target.removeEventListener(currSeqEvt.eventID, nextCall);
			}
			
			// clear events and set position to 0
			currSeqEvt = null;
			nextSeqEvt = null;
			position = 0;
		}
		
		/**
		 * clear
		 * resets sequence and removes all calls 
		 */
		public function clear():void {
			reset();
			calls.length = 0;
		}
		
		/**
		 * addEvent
		 * adds a call to the sequence
		 */
		public function addEvent(callback:Function, args:Array = null, target:EventDispatcher = null, eventID:String = null):void {
			
			// create new SequenceEvent object to hold call, its arguments and event information
			var addedSeqEvt:SequenceEvent = new SequenceEvent(callback, args, target, eventID);
			
			// add event to calls
			calls.push(addedSeqEvt);
			
			// if added in the middle of a sequence and at the
			// end of that sequence, make this event the next event
			if (currSeqEvt && !nextSeqEvt) {
				nextSeqEvt = addedSeqEvt;
			}
		}
		
		
		/**
		 * nextCall - event handler
		 * method that calls the next call in the sequence
		 */
		private function nextCall(evt:Event = null):void {
			
			// if a call exists for the next event
			if (nextSeqEvt) {
				
				// save the next call to call it later
				var firing:SequenceEvent = nextSeqEvt;
				
				// remove listener if currSeqEvt exists
				if (currSeqEvt) {
					currSeqEvt.target.removeEventListener(currSeqEvt.eventID, nextCall);
				}
				
				// reassign current call to next call
				currSeqEvt = nextSeqEvt;
				
				// update position, if additional calls exist
				// reassign nextSeqEvt to the next call
				position++;
				if (position < calls.length) {
					nextSeqEvt = calls[position];
					currSeqEvt.target.addEventListener(currSeqEvt.eventID, nextCall);
				}else{
					
					// set next to null if no more calls exist
					nextSeqEvt = null;
				}
				
				// call the firing call
				firing.callback.apply(firing.target, firing.args);
				
				// if the firing target is itself, dispatch the default event
				// which will fire the next call in the sequence
				if (firing.target == firing) {
					firing.dispatchEvent(new Event(SequenceEvent.EVENT));
				}
			}else{
				
				// when complete, reset
				reset();
			}
		}
	}
}

import flash.events.Event;
import flash.events.EventDispatcher;

/**
 * SequenceEvent
 * object representing the callback/event information for an item the sequence
 */
class SequenceEvent extends EventDispatcher {
	
	public var target:EventDispatcher;		// object handling events for event id
	public var callback:Function;			// callback function in sequence
	public var args:Array = new Array();	// optional arguments for callback
	public var eventID:String;			// event id to indicate callback completion and start of next event
			
	public static const EVENT:String = "sequence";	// default event - fires directly after previous callback call
		
	/**
	 * Constructor 
	 */
	public function SequenceEvent(callback:Function, args:Array = null, target:EventDispatcher = null, eventID:String = null):void {
		
		// assign variables
		this.callback = callback;
		this.args = (args) ? args : new Array();
		
		// if target is passed, use it and COMPLETE for default event if not given
		if (target) {
			this.target = target;
			this.eventID = (eventID) ? eventID : Event.COMPLETE;
		}else{
			
			// default to this as event dispatcher using default sequence event 
			this.target = this;
			this.eventID = EVENT;
		}
	}
}