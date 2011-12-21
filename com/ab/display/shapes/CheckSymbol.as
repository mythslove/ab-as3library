package com.ab.display.shapes
{
	/**
	* @author ABº
	*/
	
	import flash.display.*;

	// Requires Flash Player 10+
	public class CheckSymbol extends Sprite {

		// Graphics objects
		public static var drawing1:Vector.<IGraphicsData> = Vector.<IGraphicsData>([
			new GraphicsSolidFill(0x87cc7b,1),
			new GraphicsStroke(1,false,"normal","none","round",3.0,new GraphicsSolidFill(0x5ca353,1)),
			new GraphicsPath(Vector.<int>([1,2,2,2,2,2,2,2,2,2,2,2,2]),Vector.<Number>([1,9,1.09,8.09,3.06,6.18,4,6,8,10,9.9,10.09,18,1,19.09,1.12,21.03,3.03,21,4,9.96,16.03,8,16,1,9]),GraphicsPathWinding.EVEN_ODD)
		]);

		// Constructor
		public function CheckSymbol() {
			with(graphics) {
				drawGraphicsData(drawing1);
				lineStyle(NaN);
				endFill();
			}
		}
	}
}