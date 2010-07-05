/**
 * Ease
 *
 * Manages easing between a percentage of 0-100 (values of 0-1)
 */
package com.senocular.gyro {
	
	import flash.events.EventDispatcher;

	public class Ease
		extends EventDispatcher
		implements IEase {
			
		// The following definitions are binary flags which are
		// used to define the different types of behaviors for easing
		// when dealing with easing in and easing out.
		private static const FIRST_OUT:int = 1;	// 0001 - when easing out or easing out to something else
		private static const LAST_OUT:int = 2;	// 0010 - when easing from in or out to out
		private static const COMPOUND:int = 4;	// 0100 - when easing in or out to in or out (instead of just in or out alone)
		private static const RETURNS:int = 8;	// 1000 - when easing back in or out
		
		// public constants which are derived from the above binary flags
		// they define an easing behavior as a binary string 
		public static const IN:int = 0;											// 0000
		public static const OUT:int = FIRST_OUT;								// 0001
		public static const IN_TO_IN:int = COMPOUND;							// 0011
		public static const OUT_TO_IN:int = FIRST_OUT | COMPOUND;				// 0101
		public static const IN_TO_OUT:int = LAST_OUT | COMPOUND;				// 0110
		public static const OUT_TO_OUT:int = FIRST_OUT | LAST_OUT | COMPOUND;	// 0111
		public static const IN_TO_BACK_IN:int = COMPOUND | RETURNS;				// 1100
		public static const OUT_TO_BACK_IN:int = FIRST_OUT | COMPOUND | RETURNS;	// 1101
		public static const IN_TO_BACK_OUT:int = LAST_OUT | COMPOUND | RETURNS;		// 1110
		public static const OUT_TO_BACK_OUT:int = FIRST_OUT | LAST_OUT | COMPOUND | RETURNS;	// 1111
			
		private var _method:Function;	// method causing ease in a value 0 - 1
		private var _amount:Number;		// amount of the ease being applied
		private var _change:Number;		// % within the ease where an in or out changes to in or out in a compound
		private var _behavior:int = IN;	// ease behavior
		
		/**
		 * The ease method for the Ease instance.
		 */
		public function get method():Function {
			return _method;
		}
		public function set method(value:Function):void {
			_method = value;
		}
		
		/**
		 * The ease behavior.  This can be any of the
		 * Ease class constants such as IN, OUT, etc.
		 */
		public function get behavior():int {
			return _behavior;
		}
		public function set behavior(value:int):void {
			if (value < 0) {
				value = 0;
			}else if (value > OUT_TO_BACK_OUT) {
				value = OUT_TO_BACK_OUT;
			}
			_behavior = value;
		}
		
		/**
		 * The amount of ease to be applied to
		 * a transition. Default: 1 (100%)
		 */
		public function get amount():Number {
			return _amount;
		}
		public function set amount(value:Number):void {
			if (value < 0) {
				value = 0;
			}else if (value > 1) {
				value = 1;
			}
			_amount = value;
		}
		
		/**
		 * The location for change within a "_TO_"
		 * ease that returns to its start.
		 * Default: .5 (half way)
		 */
		public function get change():Number {
			return _change;
		}
		public function set change(value:Number):void {
			if (value < 0) {
				value = 0;
			}else if (value > 1) {
				value = 1;
			}
			_change = value;
		}
		
		/**
		 * Constructor. Creates a new Ease instance. Custom eases can
		 * subclass the Ease class or be written as functions and
		 * passed into a new Ease instance as its method.
		 * @param	behavior The behavior of the Ease instance.
		 * @param	amount The amount of easing to be applied.
		 * @param	change The point at which a change occurs.
		 * @param	method The method for easing.
		 */
		public function Ease(behavior:int = IN, amount:Number = 1, change:Number = .5, method:Function = null) {
			this.amount = amount;
			this.behavior = behavior;
			this.change = change;
			this.method = method;
		}
		
		/**
		 * Applies easing on the passed
		 */
		public function apply(t:Number):Number {
			
			// no easing, just return t
			if (_amount == 0) return t;
			
			var eased:Number; // resulting eased t value
			
			// based on behavior definition (binary flags)
			// modify method call as needed
			if (_behavior & COMPOUND){
				
				// for all in or out to in or out with or without back
				if (_behavior & RETURNS) {
					
					// using back to
					if (t < _change) {
						eased = (_behavior & FIRST_OUT)
							? 1 - easeMethod(1 - t/(1 - _change))
							: easeMethod(t/_change);
					}else{
						eased = (_behavior & LAST_OUT)
							? 1 - easeMethod(1 - t/_change)
							: easeMethod((1 - t)/(1 - _change));
					}
				}else{
					
					// normal in or out to in or out
					if (t < _change) {
						eased = (_behavior & FIRST_OUT)
							? (1 - easeMethod(1 - t/_change))*_change
							: easeMethod(t/_change)*_change;
					}else{
						var c1:Number = 1 - _change; // change inverted
						eased = (_behavior & LAST_OUT)
							? _change + (1 - easeMethod(1 - (t - _change)/c1))*c1
							: _change + easeMethod((t - _change)/c1)*c1;
					}
				}
			}else{
				
				// no compounded easing
				eased = (_behavior & FIRST_OUT) ? 1 - easeMethod(1 - t) : easeMethod(t);
			}
			
			// apply amount if not 100%, otherwise just return eased as is
			return (_amount == 1) ? eased : t + (eased - t)*_amount;
		}
		
		/**
		 * call custom method or just return t for linear ease
		 */
		public function easeMethod(t:Number):Number {
			return _method == null ? t : _method(t);
		}
	}
}