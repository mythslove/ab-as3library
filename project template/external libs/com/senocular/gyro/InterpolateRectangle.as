package com.senocular.gyro {

	import flash.geom.Rectangle;
	
	public class InterpolateRectangle extends Interpolate {
			
		public var target:Rectangle;
		public var start:Rectangle;
		public var end:Rectangle;
			
		public function InterpolateRectangle(target:Rectangle, start:Rectangle = null, end:Rectangle = null, owner:* = null, property:Object = null){
			this.target = target;
			this.start = (start) ? start : this.target;
			this.end = (end) ? end : this.start;
			
			super(owner, property);
		}
		
		public override function interpolate(t:Number):void {
			
			// base variable improves performance
			// reducing redundant getter lookups
			var base:Number = start.top;
			target.top = base + (end.top - base)*t;
			base = start.bottom;
			target.bottom = base + (end.bottom - base)*t;
			base = start.left;
			target.left = base + (end.left - base)*t;
			base = start.right;
			target.right = base + (end.right - base)*t;
			
			if (_owner && _property != null) {
				_owner[_property] = target;
			}
		}
	}
}