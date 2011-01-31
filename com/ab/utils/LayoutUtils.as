package com.ab.utils 
{
	/**
	* @author AB
	*/
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class LayoutUtils 
	{
		// constants
		public static const VERTICAL:String 	= "vertical";
		public static const HORIZONTAL:String 	= "horizontal";
		
		public static function arrange(displayObjectContainer:DisplayObjectContainer, layout_type:int = VERTICAL, gap:Number = 5, padding:Number = 0):void 
		{
			var child:DisplayObject;
			var numChildren:int 	= displayObject.numChildren;
			var currentPos:Number 	= padding;
			
			for (var i:int = 0; i < numChildren; i++) 
			{
				child = displayObject.getChildAt(i);
				
				if (child.visible)
				{
					child[layout_type == VERTICAL ? "y" : "x"] = currentPos;
					
					currentPos += child[layout_type == VERTICAL ? "height" : "width"] + gap;
				}
			}
		}
		
	}

}