package com.senocular.gyro {

	import flash.geom.ColorTransform;
	
	public class InterpolateColorTransform extends Interpolate {
		
		public var target:ColorTransform;
		public var start:ColorTransform;
		public var end:ColorTransform;
			
		public function InterpolateColorTransform(target:ColorTransform, start:ColorTransform = null, end:ColorTransform = null, owner:* = null, property:Object = null){
			this.target = target;
			this.start = (start) ? start : this.target;
			this.end = (end) ? end : this.start;
			
			super(owner, property);
		}
		
		public function interpolate(t:Number):void {
			target.redMultiplier = start.redMultiplier + (end.redMultiplier - start.redMultiplier)*t;
			target.greenMultiplier = start.greenMultiplier + (end.greenMultiplier - start.greenMultiplier)*t;
			target.blueMultiplier = start.blueMultiplier + (end.blueMultiplier - start.blueMultiplier)*t;
			target.alphaMultiplier = start.alphaMultiplier + (end.alphaMultiplier - start.alphaMultiplier)*t;
			target.redOffset = start.redOffset + (end.redOffset - start.redOffset)*t;
			target.greenOffset = start.greenOffset + (end.greenOffset - start.greenOffset)*t;
			target.blueOffset = start.blueOffset + (end.blueOffset - start.blueOffset)*t;
			target.alphaOffset = start.alphaOffset + (end.alphaOffset - start.alphaOffset)*t;
			
			if (_owner && _property != null) {
				_owner[_property] = target;
			}
		}
	}
}