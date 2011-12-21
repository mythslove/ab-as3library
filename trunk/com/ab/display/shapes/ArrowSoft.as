package com.ab.display.shapes
{
	/**
	* @author ABº
	*/
	
	import flash.display.*;

	// Requires Flash Player 10+
	public class ArrowSoft extends Sprite {

		// Graphics objects
		public static var drawing1:Vector.<IGraphicsData> = Vector.<IGraphicsData>([
			new GraphicsSolidFill(0x0066ff,1),
			new GraphicsPath(Vector.<int>([1,2,3,3,3,2,2,3,3,3,2,2,3,3,3,2,2]),Vector.<Number>([25.72,40.56,7.23,59.25,7.23,59.25,7.05,59.44,0.9,66,7.17,72.34,13.41,78.64,19.85,72.43,20.03,72.24,44.4,47.23,44.4,47.23,44.57,47.04,47.64,43.74,46.86,39.2,46.6,36.17,44.51,33.93,44.33,33.75,19.58,8.74,19.58,8.74,19.39,8.55,12.89,2.34,6.63,8.67,0.39,14.98,6.53,21.48,6.72,21.66,25.72,40.56]),GraphicsPathWinding.EVEN_ODD)
		]);

		// Constructor
		public function ArrowSoft() {
			with(graphics) {
				drawGraphicsData(drawing1);
				lineStyle(NaN);
				endFill();
			}
		}
	}
}