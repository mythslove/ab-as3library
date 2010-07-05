package com.senocular.gyro {

	import flash.filters.DisplacementMapFilter;
	import flash.geom.Point;
	
	public class InterpolateDisplacementMapFilter extends AbstractInterpolateFilter {
	
		public var target:DisplacementMapFilter;
		public var start:DisplacementMapFilter;
		public var end:DisplacementMapFilter;
			
		public function InterpolateDisplacementMapFilter(target:DisplacementMapFilter, start:DisplacementMapFilter = null, end:DisplacementMapFilter = null, owner:* = null, property:Object = null){
			this.target = target;
			this.start = (start) ? start : this.target;
			this.end = (end) ? end : this.start;
			
			super(owner, property);
		}
		
		public override function interpolate(t:Number):void {
			target.alpha = start.alpha + (end.alpha - start.alpha)*t;
			target.color = interpolateColor(start.color, end.color, t);
			target.componentX = start.componentX + (end.componentX - start.componentX)*t;
			target.componentY = start.componentY + (end.componentY - start.componentY)*t;
			target.mapPoint = new Point(
				start.mapPoint.x + (end.mapPoint.x - start.mapPoint.x)*t,
				start.mapPoint.y + (end.mapPoint.y - start.mapPoint.y)*t
			);
			target.scaleX = start.scaleX + (end.scaleX - start.scaleX)*t;
			target.scaleY = start.scaleY + (end.scaleY - start.scaleY)*t;
			
			assign(target);
		}
	}
}