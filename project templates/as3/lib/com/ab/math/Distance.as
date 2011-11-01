package com.ab.math
{
	import flash.geom.Point;
	/**
	* @author ABº
	* 
	* Calculate a distance between points
	* 
	* Each of the two provided arguments must contain the x and y properties
	*/
	
	public class Distance 
	{
		
		public function Distance() 
		{
			
		}
		
		public static function betweenTwoPoints(p1:Point, p2:Point):Number
		{
			/// d(p1, p2) = Math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
			
			var result:Number = Math.sqrt((p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y));
			
			return result;
		}
		
	}
	
}