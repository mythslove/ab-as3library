package com.senocular.gyro {
	
	public class InterpolateAngleProperty extends InterpolateProperty {
			
		/**
		 * Constructor. Creates a new InterpolateAngleProperty instance.
		 * InterpolateAngleProperty instances are different from 
		 * InterpolateProperty instances in that they treat the property
		 * value as an angle within a "wrapping" 360 degree circle.  When
		 * going from one value to another, it determines the shortest
		 * distance to the new value within those degrees of rotation
		 * and follows that direction rather than interpolating the 
		 * numeric values directly.
		 * @param	start The start value for interpolation.
		 * @param	end The end value for interpolation.
		 * @param	owner The owner of the property to interpolate.
		 * @param	property The name of the property to interpolate.
		 */
		public function InterpolateAngleProperty(start:Number = NaN, end:Number = NaN, owner:* = null, property:Object = null){
			super(start, end, owner, property);
		}
		
		/**
		 * 
		 * Determines a value between start and end based on t where
		 * 0 is start and 1 is end.
		 * @param	t The amount to interpolate the property.
		 */
		public override function interpolate(t:Number):void {
			if (_owner && _property != null) {
				
				// angles get special treatment to account
				// for wrapping of 360 back down to 0
				var angleDiff:Number = _end - _start;
				
				// make sure the difference is a valid number
				if (isNaN(angleDiff) == false){
					
					if (angleDiff < -180) angleDiff += 360;
					else if (angleDiff > 180) angleDiff -= 360;
					
					_owner[_property] = _start + angleDiff*t;
				}
			}
		}
	}
}