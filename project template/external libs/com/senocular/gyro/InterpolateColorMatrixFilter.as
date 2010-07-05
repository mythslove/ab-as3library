package com.senocular.gyro {

	import flash.filters.ColorMatrixFilter;
	
	public class InterpolateColorMatrixFilter extends AbstractInterpolateFilter {
	
		public var target:ColorMatrixFilter;
		public var start:ColorMatrixFilter;
		public var end:ColorMatrixFilter;
			
		public function InterpolateColorMatrixFilter(target:ColorMatrixFilter, start:ColorMatrixFilter = null, end:ColorMatrixFilter = null, owner:* = null, property:Object = null){
			this.target = target;
			this.start = (start) ? start : this.target;
			this.end = (end) ? end : this.start;
			
			super(owner, property);
		}
		
		public override function interpolate(t:Number):void {
			var matrix:Array = new Array(count);
			for (var i:int = 0; i<20; i++){
				matrix[i] = start.matrix[i] + (end.matrix[i] - start.matrix[i])*t;
			}
			target.matrix = matrix;
			
			assign(target);
		}
	}
}