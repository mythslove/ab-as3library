package com.senocular.gyro {

	import flash.filters.GlowFilter;
	
	public class InterpolateGlowFilter extends AbstractInterpolateFilter {
	
		public var target:GlowFilter;
		public var start:GlowFilter;
		public var end:GlowFilter;
			
		public function InterpolateGlowFilter(target:GlowFilter, start:GlowFilter = null, end:GlowFilter = null, owner:* = null, property:Object = null){
			this.target = target;
			this.start = (start) ? start : this.target;
			this.end = (end) ? end : this.start;
			
			super(owner, property);
		}
		
		public override function interpolate(t:Number):void {
			target.alpha = start.alpha + (end.alpha - start.alpha)*t;
			target.blurX = start.blurX + (end.blurX - start.blurX)*t;
			target.blurY = start.blurY + (end.blurY - start.blurY)*t;
			target.quality = int(start.quality + Math.round((end.quality - start.quality)*t));
			target.strength = start.strength + (end.strength - start.strength)*t;
			
			assign(target);
		}
	}
}