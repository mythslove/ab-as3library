package com.senocular.gyro {

	import flash.filters.ConvolutionFilter;
	
	public class InterpolateConvolutionFilter extends AbstractInterpolateFilter {
	
		public var target:ConvolutionFilter;
		public var start:ConvolutionFilter;
		public var end:ConvolutionFilter;
		
		public function InterpolateConvolutionFilter(target:ConvolutionFilter, start:ConvolutionFilter = null, end:ConvolutionFilter = null, owner:* = null, property:Object = null){
			this.target = target;
			this.start = (start) ? start : this.target;
			this.end = (end) ? end : this.start;
			
			super(owner, property);
			
		}
		
		public override function interpolate(t:Number):void {
			// assumes target, start, and end are same size
			var count:int = target.matrixX * target.matrixY;
			
			target.alpha = start.alpha + (end.alpha - start.alpha)*t;
			target.bias = start.bias + (end.bias - start.bias)*t;
			target.color = interpolateColor(start.color, end.color, t);
			target.divisor = start.divisor + (end.divisor - start.divisor)*t;
			
			var matrix:Array = new Array(count);
			for (var i:int = 0; i<count; i++){
				matrix[i] = start.matrix[i] + (end.matrix[i] - start.matrix[i])*t;
			}
			target.matrix = matrix;
			
			assign(target);
		}
	}
}