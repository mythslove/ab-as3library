package com.ab.display.shapes
{
	/**
	* @author ABº
	*/
	
	import flash.display.*;

	public class Cross extends Sprite 
	{
		public static var drawing1:Vector.<IGraphicsData> = Vector.<IGraphicsData>([
			new GraphicsSolidFill(0xffffff,1),
			new GraphicsPath(Vector.<int>([1,2,2,2,2,2,2,2,2,2,2,2,2]),Vector.<Number>([507,265.91,432.01,191,345,277.93,257.98,191,183,265.91,270.01,352.85,183.7,439.08,258.69,514,345,427.77,431.3,514,506.29,439.08,419.98,352.85,507,265.91]),GraphicsPathWinding.EVEN_ODD)
		]);
		
		public function Cross() 
		{
			with (graphics)
			{
				drawGraphicsData(drawing1);
				lineStyle(NaN);
				endFill();
			}
		}
	}
}