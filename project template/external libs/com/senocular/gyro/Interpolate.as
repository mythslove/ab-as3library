package com.senocular.gyro {
	
	public class Interpolate implements IInterpolate {
		
		protected var _owner:* = null;
		protected var _property:Object = null;
		
		/**
		 * The object owning the property within this
		 * interpolation instance.  When interpolation
		 * occurs, this object's property is set with the
		 * new value.
		 */
		public function get owner():* {
			return _owner;
		}
		public function set owner(value:*):void {
			_owner = value;
		}
		
		/**
		 * The name of the property to be set within
		 * the owner object during interpolation.
		 */
		public function get property():Object {
			return _property;
		}
		public function set property(value:Object):void {
			_property = value;
		}
			
		/**
		 * Constructor. Creates a new Interpolate instance.
		 */
		public function Interpolate(owner:* = null, property:Object = null){
			this.owner = owner;
			this.property = property;
		}
		
		/**
		 * Runs this instance's interpolation method by a
		 * value of t. Interpolation is the transitioning
		 * from one value to another. The t value represents
		 * how much interpolation is being performed (0-1).
		 * @param t	The amount to interpolate the instance.
		 */
		public function interpolate(t:Number):void {}
			
		/**
		 * Determines a color value between two color values.
		 * @param	color1 The first color used in the interpolation.
		 * @param	color2 The first color used in the interpolation.
		 * @param	t The amount between the two colors to generate
		 * 			the new color where 0 is 0% and equal to color1
		 * 			and 1 is 100% and equal to color2.
		 * @return	The color between color1 and color2 based on t.
		 */
		public static function interpolateColor(color1:uint, color2:uint, t:Number):uint {
			var a1:int = (color1 >> 32) & 0xFF;
			var r1:int = (color1 >> 16) & 0xFF;
			var g1:int = (color1 >> 8) & 0xFF;
			var b1:int = color1 & 0xFF;
			var a2:int = (color2 >> 32) & 0xFF;
			var r2:int = (color2 >> 16) & 0xFF;
			var g2:int = (color2 >> 8) & 0xFF;
			var b2:int = color2 & 0xFF;
			return uint(a1+(a2-a1)*t) << 32 | int(r1+(r2-r1)*t) << 16 | int(g1+(g2-g1)*t) << 8 | int(b1+(b2-b1)*t);
		}
	}
}