package com.senocular.gyro {

	import flash.filters.DropShadowFilter;
	
	public class InterpolateDropShadowFilter extends AbstractInterpolateFilter {
	
		public var target:DropShadowFilter;
		public var start:DropShadowFilter;
		public var end:DropShadowFilter;
			
		public function InterpolateDropShadowFilter(target:DropShadowFilter, start:DropShadowFilter = null, end:DropShadowFilter = null, owner:* = null, property:Object = null){
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
			target.quality = int(start.quality + Math.round((end.quality - start.quality)*t));
			target.strength = start.strength + (end.strength - start.strength)*t;
			
			assign(target);
		}
	}
}