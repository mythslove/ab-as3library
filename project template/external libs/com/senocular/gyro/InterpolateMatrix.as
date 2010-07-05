package com.senocular.gyro {

	import flash.geom.Matrix;
	
	public class InterpolateMatrix extends Interpolate {
	
		public var target:Matrix;
		public var start:Matrix;
		public var end:Matrix;
			
		public function InterpolateMatrix(target:Matrix, start:Matrix = null, end:Matrix = null, owner:* = null, property:Object = null){
			this.target = target;
			this.start = (start) ? start : this.target;
			this.end = (end) ? end : this.start;
			
			super(owner, property);
		}
		
		public function interpolate(t:Number):void {
			target.a = start.a + (end.a - start.a)*t;
			target.b = start.b + (end.b - start.b)*t;
			target.c = start.c + (end.c - start.c)*t;
			target.d = start.d + (end.d - start.d)*t;
			target.tx = start.tx + (end.tx - start.tx)*t;
			target.ty = start.ty + (end.ty - start.ty)*t;
			
			if (_owner && _property != null) {
				_owner[_property] = target;
			}
		}
	}
}