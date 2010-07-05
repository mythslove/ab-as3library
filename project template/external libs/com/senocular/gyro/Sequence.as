package com.senocular.gyro {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * Creates a sequence of method items that are called in sequence based 
	 * upon completion events.
	 */
	public class Sequence
		extends EventDispatcher
		implements IStartable {
		
		protected var items:Array = new Array();	// list of SequenceItem objects
		protected var _position:int = 0;			// _position within items
		protected var _currentItem:SequenceItem;	// current event
		protected var nextItem:SequenceItem;		// next event to be called when current event completes
		
		public static const NEXT_EVENT:String = "nextEvent";
		
		/**
		 * The position within the sequence
		 */
		public function get position():int {
			return _position;
		}
		
		/**
		 * The SequenceItem at the current
		 * position within the sequence.
		 */
		public function get currentItem():SequenceItem {
			return _currentItem;
		}
		
		/**
		 * Constructor 
		 */
		public function Sequence(autoStart:Boolean = true){
			addEventListener(NEXT_EVENT, nextEvent);
			if (autoStart) start(); // TODO: Make start a dispatch event rather than commands (w/ start handler)
		}
		
		/**
		 * Initiates a sequence using current position (not necessarily 0)
		 */
		public function start():void {
			nextItem = items[_position];
			initiateNextItem();
		}
		
		/**
		 * Stops a sequence from continuing but does not
		 * stop the current item from playing.
		 */
		public function stop():void {
			
			// remove listener if _currentItem exists
			if (_currentItem && _currentItem.target) {
				_currentItem.target.removeEventListener(_currentItem.eventType, itemComplete);
			}
		}
		
		/**
		 * Reset a sequence stopping it and setting its
		 * position to 0. If a current item is an instance
		 * of IStartable, it is stopped using stop()
		 */
		public function reset():void {
			
			// remove listener if _currentItem exists
			if (_currentItem && _currentItem.target) {
				_currentItem.target.removeEventListener(_currentItem.eventType, itemComplete);
				if (_currentItem.target is IStartable){
					IStartable(_currentItem.target).stop();
				}
			}
			
			// clear events and set _position to 0
			_currentItem = null;
			nextItem = null;
			_position = 0;
		}
		
		/**
		 * Resets sequence and removes all items 
		 */
		public function clear():void {
			reset();
			items.length = 0;
		}
		
		/**
		 * Adds an item in to the sequence.  This item will be started for
		 * its turn in the sequence and will need to signal its completion
		 * so that other items in the sequence will know when to begin.
		 * @param	target the target object to be played in the sequence.
		 * 			This will need to be an IEventDispatcher so it can 
		 * 			indicate it's completion to start the next itam
		 * 			in the sequence.
		 * @param	eventType The event type that sigifies the completion
		 * 			of the target item. By default this is Event.COMPLETE.
		 * @param	initiator The function that starts the item for the
		 * 			the sequence.  If the target is of the Gyro type
		 * 			IStartable, this can be ommitted and start() will
		 * 			be used.
		 * @param	initiatorArguments An array of arguments to be used in
		 * 			the intiator call.
		 */
		public function addItem(target:IEventDispatcher = null, eventType:String = Event.COMPLETE, initiator:Function = null, initiatorArguments:Array = null):SequenceItem {
			
			// assign default initiators if applicable
			if (initiator == null && target is IStartable) {
				initiator = IStartable(target).start;
			}
			
			// create new SequenceItem object to hold call, its
			// arguments and event information
			var addedItem:SequenceItem = new SequenceItem(target, eventType, initiator, initiatorArguments);
			
			// add event to items
			items.push(addedItem);
			
			// if added in the middle of a sequence and at the
			// end of that sequence, make this event the next event
			if (_currentItem && !nextItem) {
				nextItem = addedItem;
			}
			
			return addedItem;
		}
		
		/**
		 * Removes a SequenceItem instance from the sequence.
		 * SequenceItem instances are objects returned from
		 * addItem.
		 * @param	item The SequenceItem to remove from
		 * 			the sequence
		 * @return	The SequenceItem instance removed.
		 */
		public function removeItem(item:SequenceItem):SequenceItem {
			
			if (item == null) return null;
			
			// find the item in the list and
			// splice out if present
			var index:int = items.indexOf(item);
			if (index != -1){
				items.splice(index, 1);
			}
			
			return item;
		}
		
		/**
		 * Returns the target item at the specified index.
		 * @param	index The position number of the item to
		 * 			retrieve from the sequence list.
		 * @return	The target IEventDispatcher at the specified
		 * 			position in the sequence.  If the index is
		 * 			invalid, null is returned.
		 */
		private function getItemAt(index:int):IEventDispatcher {
			if (index >= 0 && index < items.length){
				return SequenceItem(items[index]).target;
			}
			return null;
		}
		
		/**
		 * Event handler reacting to completion of current sequence item
		 */
		private function itemComplete(event:Event):void {
			dispatchEvent(new Event(NEXT_EVENT));		
		}
		
		/**
		 * Event handler reacting to nextEvent event
		 */
		private function nextEvent(event:Event):void {
			initiateNextItem();			
		}
		
		/**
		 * Continues to the next sequence item after the completion of the current
		 */
		private function initiateNextItem():void {
			
			// remove the current listener
			if (_currentItem && _currentItem.target) {
				_currentItem.target.removeEventListener(_currentItem.eventType, itemComplete);
			}
			
			// if last item and sequence is complete, dispatch the complete event
			if (!nextItem) {
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			
			// reassign current item to next item
			_currentItem = nextItem;
			_currentItem.target.addEventListener(_currentItem.eventType, itemComplete);
			
			// update _position, if additional items exist
			// reassign nextItem to the next item, otherwise null
			_position++;
			nextItem = (_position < items.length) ? items[_position] : null;
			
			// intiiate the next item
			_currentItem.initiator.apply(_currentItem.target, _currentItem.initiatorArguments);
		}
		
		/**
		 * Event handler reacting to completion of sequence
		 */
		private function sequenceComplete(event:Event):void {
			
			// reset if no additional events exist
			if (!nextItem) {
				reset();
				return;
			}
			
			// if a nextItem exists, continue with that item
			initiateNextItem();
		}
	}
}
