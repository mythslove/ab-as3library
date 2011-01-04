package metaballs
{
	import flash.geom.Point;
	
	public class Ball
	{
		public var size:Number;
		public var pos:Point;
		public var pos0:Point;
		public var edgePos:Point;
		public var tracking:Boolean;
		
		public function Ball(s:Number, px:Number, py:Number):void
		{
			size 		= s;
			pos 		= new Point(px,py);
			tracking 	= false;
		}
	}
}