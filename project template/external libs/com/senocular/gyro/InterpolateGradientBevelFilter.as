package com.senocular.gyro {

	import flash.filters.GradientBevelFilter;
	
	public class InterpolateGradientBevelFilter extends AbstractInterpolateFilter {
	
		public var target:GradientBevelFilter;
		public var start:GradientBevelFilter;
		public var end:GradientBevelFilter;
		public var count:int;
			
		public function InterpolateGradientBevelFilter(target:GradientBevelFilter, start:GradientBevelFilter = null, end:GradientBevelFilter = null, owner:* = null, property:Object = null){
			this.target = target;
			this.start = (start) ? start : this.target;
			this.end = (end) ? end : this.start;
			
			super(owner, property);
		}
		
		public override function interpolate(t:Number):void {
			// assumes target, begin, and end are same size
			var count:int = target.colors.length;
			
			// angles get special treatment to account
			// for wrapping of 360 back down to 0
			var angleDiff:Number = end.angle - start.angle;
			if (angleDiff < -180) angleDiff += 360;
			else if (angleDiff > 180) angleDiff -= 360;
			target.angle = start.angle + angleDiff*t;
			
			target.blurX = start.blurX + (end.blurX - start.blurX)*t;
			target.blurY = start.blurY + (end.blurY - start.blurY)*t;
			target.distance = start.distance + (end.distance - start.distance)*t;
			target.quality = int(start.quality + Math.round((end.quality - start.quality)*t));
			target.strength = start.strength + (end.strength - start.strength)*t;
			
			var alphas:Array = new Array(count);
			var colors:Array = new Array(count);
			var ratios:Array = new Array(count);
			for (var i:int = 0; i<count; i++){
				alphas[i] = start.alphas[i] + (end.alphas[i] - start.alphas[i])*t;
				colors[i] = interpolateColor(start.colors[i], end.colors[i], t);
				ratios[i] = start.ratios[i] + (end.ratios[i] - start.ratios[i])*t;
			}
			target.alphas = alphas;
			target.colors = colors;
			target.ratios = ratios;
			
			assign(target);
		}
	}
}