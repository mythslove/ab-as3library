package com.senocular.gyro {

	import flash.filters.BlurFilter;
	
	public class InterpolateBlurFilter extends AbstractInterpolateFilter {
	
		protected var target:BlurFilter;
		protected var start:BlurFilter;
		protected var end:BlurFilter;
			
		public function InterpolateBlurFilter(target:BlurFilter, start:BlurFilter = null, end:BlurFilter = null, owner:* = null, property:Object = null){
			this.target = target;
			this.start = (start) ? start : this.target;
			this.end = (end) ? end : this.start;
			
			super(owner, property);
		}
		
		public override function interpolate(t:Number):void {
			target.blurX = start.blurX + (end.blurX - start.blurX)*t;
			target.blurY = start.blurY + (end.blurY - start.blurY)*t;
			target.quality = int(start.quality + Math.round((end.quality - start.quality)*t));
			
			assign(target);
		}
	}
}