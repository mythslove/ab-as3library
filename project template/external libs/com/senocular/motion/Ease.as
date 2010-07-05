/**
 * Ease
 *
 * Modifier for EaseMethod instances that allow you to 
 * modify ease amount and direction (in or out or a combination of both)
 */
package com.senocular.motion {
	
	public class Ease extends EaseMethod {
		
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
		public static const OUT:int = FIRST_OUT;									// 0001
		public static const IN_TO_IN:int = COMPOUND;									// 0011
		public static const IN_TO_OUT:int = LAST_OUT | COMPOUND;						// 0110
		public static const OUT_TO_OUT:int = FIRST_OUT | LAST_OUT | COMPOUND;				// 0111
		public static const OUT_TO_IN:int = FIRST_OUT | COMPOUND;						// 0101
		public static const IN_TO_BACK_IN:int = COMPOUND | RETURNS;						// 1100
		public static const IN_TO_BACK_OUT:int = LAST_OUT | COMPOUND | RETURNS;			// 1110
		public static const OUT_TO_BACK_OUT:int = FIRST_OUT | LAST_OUT | COMPOUND | RETURNS;	// 1111
		public static const OUT_TO_BACK_IN:int = FIRST_OUT | COMPOUND | RETURNS;			// 1101
			
		private var _method:EaseMethod;	// ease method being affected
		private var _amount:Number;		// amount of the ease being applied
		private var _change:Number;		// % within the ease where an in or out changes to in or out in a compound
		private var _behavior:int = IN;	// ease behavior
		
		// public method
		public function get method():EaseMethod {
			return _method;
		}
		public function set method(e:EaseMethod):void {
			_method = e;
		}
		
		// public amount
		public function get amount():Number {
			return _amount;
		}
		public function set amount(n:Number):void {
			if (n < 0) {
				n = 0;
			}else if (n > 1) {
				n = 1;
			}
			_amount = n;
		}
		
		// public behavior
		public function get behavior():int {
			return _behavior;
		}
		public function set behavior(n:int):void {
			_behavior = n;
		}
		
		// public change
		public function get change():Number {
			return _change;
		}
		public function set change(n:Number):void {
			if (n < 0) {
				n = 0;
			}else if (n > 1) {
				n = 1;
			}
			_change = n;
		}
		
		/**
		 * Constructor 
		 */
		public function Ease(method:EaseMethod = null, amount:Number = 1, behavior:int = IN, change:Number = .5) {
			// default ease method is new EaseMethod (linear)
			_method = (method) ? method : new EaseMethod();
			this.amount = amount;
			_behavior = behavior;
			this.change = change;
		}
		
		/**
		 * call
		 * new call function handles method calling based
		 * on behavior assigned to Ease instance
		 */
		public override function call(t:Number):Number {
			// make sure t is between 0 and 1 inclusive
			if (t < 0 || t > 1) {
				t %= 1;
			}
			
			var eased:Number; // resulting eased t value
			
			// based on behavior definition (binary flags)
			// modify method call as needed
			if (_behavior & COMPOUND){
				
				// for all in or out to in or out with or without back
				if (_behavior & RETURNS) {
					
					// using back to
					if (t < _change) {
						eased = (_behavior & FIRST_OUT)
							? 1 - _method.call(1 - t/(1 - _change))
							: _method.call(t/_change);
					}else{
						eased = (_behavior & LAST_OUT)
							? 1 - _method.call(1 - t/_change)
							: _method.call((1 - t)/(1 - _change));
					}
				}else{
					
					// normal in or out to in or out
					if (t < _change) {
						eased = (_behavior & FIRST_OUT)
							? (1 - _method.call(1 - t/_change))*_change
							: _method.call(t/_change)*_change;
					}else{
						var c1:Number = 1 - _change; // change % inverted
						eased = (_behavior & LAST_OUT)
							? _change + (1 - _method.call(1 - (t - _change)/c1))*c1
							: _change + _method.call((t - _change)/c1)*c1;
					}
				}
			}else{
				eased = (_behavior & FIRST_OUT) ? 1 - _method.call(1 - t) : _method.call(t);
			}
			
			// apply amount if not 100%, otherwise just return eased as is
			return (amount == 1) ? eased : t + (eased - t)*amount;
		}
	}
}