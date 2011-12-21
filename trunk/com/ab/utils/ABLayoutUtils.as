package com.ab.utils 
{
	import flash.display.DisplayObject;
	/**
	 * ABLayoutUtils 
	 * @author ABº
	 * http://www.antoniobrandao.com/
	 */
	
	public class ABLayoutUtils 
	{
		/**
		 * Aligns an array of DisplayObjects vertically.
		 * @param $items - items to process.
		 * @example <listing version="1.0">
		 * 		someItemsArray = [displayobject1, displayobject2];
		 * 		distributeVertically(someItemsArray, 10);
		 * </listing>
		 * @return Object
		 */
		
		public static function distributeVertically(items:Array, spacing:Number=0):void 
		{
			var item_count:Number 	= 0;
			var height_count:Number = 0;
			
			for (var i:int = 0; i < items.length; i++) 
			{
				if (items[i] is DisplayObject) 
				{
					if (item_count == 0) 
					{
						height_count = height_count + DisplayObject(items[i]).height + spacing;
						
						item_count++;
					}
					else
					{
						DisplayObject(items[i]).y = height_count;
						
						height_count = height_count + DisplayObject(items[i]).height + spacing;
						
						item_count++;
					}
				}
				
			}
			
		}
		
		
	}
	
}