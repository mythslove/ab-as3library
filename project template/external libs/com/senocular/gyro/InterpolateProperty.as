package com.senocular.gyro {
	
	public class InterpolateProperty extends Interpolate {
	
		protected var _start:Number;
		protected var _end:Number;
			
		/**
		 * The start value for interpolation.
		 */
		public function get start():Number {
			return _start;
		}
		public function set start(n:Number):void {
			_start = n;
		}
		
		/**
		 * The end value for interpolation.
		 */
		public function get end():Number {
			return _end;
		}
		public function set end(n:Number):void {
			_end = n;
		}
			
		/**
		 * Constructor. Creates a new InterpolateProperty instance.
		 * @param	start The start value for interpolation.
		 * @param	end The end value for interpolation.
		 * @param	owner The owner of the property to interpolate.
		 * @param	property The name of the property to interpolate.
		 */
		public function InterpolateProperty(start:Number = NaN, end:Number = NaN, owner:* = null, property:Object = null){
			this.start = start;
			this.end = end;
			super(owner, property);
		}
		
		/**
		 * Determines a value between start and end based on t where
		 * 0 is start and 1 is end.
		 * @param	t The amount to interpolate the property.
		 */
		public override function interpolate(t:Number):void {
			if (_owner && _property != null) {
				var result:Number = _start + (_end - _start)*t;
				
				// make sure the result is a valid number
				if (isNaN(result) == false){
					_owner[_property] = _start + (_end - _start)*t;
				}
			}
		}
	}
}