package com.ab.utils
{
	import flash.geom.Point;        
	
	/**
	 * Utility class for geometric calculations.
	 */
	public class GeometryUtil 
	{
		/**
		 * This method gets the centroid of any shape with three or more sides.
		 * 
		 * @param       vertices        An array of vertices.
		 * @param       pNameX          An optional parameter which allows to set the name identifying the X-axis value of the vertices.
		 * @param       pNameY          An optional parameter which allows to set the name identifying the Y-axis value of the vertices.
		 * @return      A Point object representing the centroid.
		 */
		public static function getCentroid ( vertices : Array , pNameX : String = "x" , pNameY : String = "y" ) : Point
		{
			var centroid : Point = new Point( ) ;
			
			for each ( var vertex : Object in vertices )
			{
				centroid.x += vertex[ pNameX ] ;
				centroid.y += vertex[ pNameY ] ;
			}
			
			centroid.x /= vertices.length ;
			centroid.y /= vertices.length ;
			
			return centroid ;
		}
		
		/**
		 * This method calculates the hypoteneuse of a triangle.
		 * 
		 * @param       a       The length of the adjacent side.
		 * @param       b       The length of the opposite side.
		 * 
		 * @return      The length of the hypoteneuse.
		 */
		public static function getHypoteneuse ( a : Number , b : Number ) : Number
		{
			return Math.sqrt( Math.pow( a , 2 ) + Math.pow( b , 2 ) ) ;
		}
		
		/**
		 * This method gets the maximum distance within a rectangle from its centre.
		 * 
		 * @param       width   The width of the rectangle.
		 * @param       height  The height of the rectangle.
		 * 
		 * @return      The rectangular radius.
		 */
		public static function rectangularRadius ( width : Number , height : Number ) : Number
		{
			return Math.sqrt( Math.pow( width , 2 ) + Math.pow( height , 2 ) ) / 2 ;
		}
		
		/**
		 * This method returns a random point within a rectangle.
		 * 
		 * @param       rect   The Rectangle to get a random Point from.
		 * 
		 * @return      A random Point within the provided Rectangle.
		 */
		public static function randomPoint ( rect : Rectangle ) : Point
		{
			return new Point( rect.left + Math.random( ) * ( rect.width ) , rect.top + Math.random( ) * ( rect.height ) ) ;
		}
		
		/**
		 * This method returns the shortest angle between two angle values.
		 * 
		 * @param       origin   Angle value to start from.
		 * @param       target   Angle value to reach.
		 * 
		 * @return      The shortest angle between the two angle values provided.
		 */
		public static function shortestAngle ( origin : Number , target : Number ) : Number
		{
			var o : Number = Math.abs( origin ) ;
			var t : Number = origin < 0 ? - target : target ;
			
			if ( o % 360 )
			{
				o = o - ( o % 360 ) + t ;
				if ( Math.abs( o + 360 - origin ) < Math.abs( o - origin ) )
				{
					o += 360 ;
				}
			}
			else o = o + t ;
			
			if ( origin < 0 ) o *= - 1 ;
			
			return o ;
		}
		
		/**
		 * This method converts radians to degrees.
		 * 
		 * @param       radians  the value in Radians.
		 * 
		 * @return      The same value, in Degrees.
		 */
		public static function toDegrees ( radians : Number ) : Number
		{
			return radians * 180 / Math.PI ;
		}
		
		/**
		 * This method converts degrees to radians.
		 * 
		 * @param       degrees  the value in Degrees.
		 * 
		 * @return      The same value, in Radians.
		 */
		public static function toRadians ( degrees : Number ) : Number
		{
			return degrees * Math.PI / 180 ;
		}
	}
}