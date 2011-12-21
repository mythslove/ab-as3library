package com.ab.display.shapes
{
	import flash.display.*;

	// Requires Flash Player 10+
	public class CrossRounded extends Sprite {

		// Graphics objects
		public static var drawing1:Vector.<IGraphicsData> = Vector.<IGraphicsData>([
			new GraphicsSolidFill(0xffffff,1),
			new GraphicsPath(Vector.<int>([1,3,2,3,3,3,2,3,3,3,2,3,3,3,2,3,3]),Vector.<Number>([0.85,0.84,-1.2,2.88,0.83,4.92,5.89,10.03,5.89,10.03,0.85,15.07,-1.19,17.11,0.83,19.15,2.86,21.19,4.9,19.15,9.94,14.11,9.94,14.11,14.94,19.15,16.97,21.19,19.01,19.15,21.05,17.11,19.03,15.07,14.03,10.03,14.03,10.03,19.14,4.92,21.19,2.88,19.16,0.84,17.14,-1.2,15.09,0.84,9.98,5.95,9.98,5.95,4.92,0.84,2.89,-1.2,0.85,0.84]),GraphicsPathWinding.EVEN_ODD)
		]);

		// Constructor
		public function CrossRounded() {
			with(graphics) {
				drawGraphicsData(drawing1);
				lineStyle(NaN);
				endFill();
			}
		}
	}
}