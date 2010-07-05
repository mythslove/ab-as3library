package com.senocular.gyro {

	import flash.geom.Point;
	
	public class InterpolatePoint extends Interpolate {
	
		public var target:Point;
		public var start:Point;
		public var end:Point;
			
		public function InterpolatePoint(target:Point, start:Point = null, end:Point = null, owner:* = null, property:Object = null){
			this.target = target;
			this.start = (start) ? start : this.target;
			this.end = (end) ? end : this.start;
			
			super(owner, property);
		}
		
		public function interpolate(t:Number):void {
			target.x = start.x + (end.x - start.x)*t;
			target.y = start.y + (end.y - start.y)*t;
			
			if (_owner && _property != null) {
				_owner[_property] = target;
			}
		}
	}
}