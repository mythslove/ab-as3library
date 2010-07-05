package com.senocular.gyro {

	import flash.filters.BevelFilter;
	
	public class InterpolateBevelFilter extends AbstractInterpolateFilter {
	
		public var target:BevelFilter;
		public var start:BevelFilter;
		public var end:BevelFilter;
			
		public function InterpolateBevelFilter(target:BevelFilter, start:BevelFilter = null, end:BevelFilter = null, owner:* = null, property:Object = null){
			this.target = target;
			this.start = (start) ? start : this.target;
			this.end = (end) ? end : this.start;
			
			super(owner, property);
		}
		
		public override function interpolate(t:Number):void {
			
			// angles get special treatment to account
			// for wrapping of 360 back down to 0
			var angleDiff:Number = end.angle - start.angle;
			if (angleDiff < -180) angleDiff += 360;
			else if (angleDiff > 180) angleDiff -= 360;
			target.angle = start.angle + angleDiff*t;
			
			target.alpha = start.alpha + (end.alpha - start.alpha)*t;
			target.blurX = start.blurX + (end.blurX - start.blurX)*t;
			target.blurY = start.blurY + (end.blurY - start.blurY)*t;
			target.color = interpolateColor(start.color, end.color, t);
			target.distance = start.distance + (end.distance - start.distance)*t;
			target.highlightAlpha = start.highlightAlpha + (end.highlightAlpha - start.highlightAlpha)*t;
			target.highlightColor = interpolateColor(start.highlightColor, end.highlightColor, t);
			target.quality = int(start.quality + Math.round((end.quality - start.quality)*t));
			target.shadowAlpha = start.shadowAlpha + (end.shadowAlpha - start.shadowAlpha)*t;
			target.shadowColor = interpolateColor(start.shadowColor, end.shadowColor, t);
			target.strength = start.strength + (end.strength - start.strength)*t;
			
			assign(target);
		}
	}
}