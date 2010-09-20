package com.ab.utils 
{
	/**
	* @author ABº
	* 
	* http://blog.antoniobrandao.com/
	*/
	
	public class ABArrayUtils 
	{	
		public static function removeduplicates(arr:Array):Boolean
		{
			var arr:Array = ["a","b","b","c","b","d","c"];
			
			var z:Array = arr.filter(function (a:*,b:int,c:Array):Boolean { return ((z ? z : z = new Array()).indexOf(a) >= 0 ? false : (z.push(a) >= 0)); }, this);
			
			arr = z;
		}
		
		public static function isInArray(item:*, arr:Array):Boolean
		{
			for (var i:int = 0; i < arr.length; i++) 
			{
				if (item == arr[i])  { return true; }
			}
			
			return false;
		}
		
		public static function shuffleArray(arr:Array):Array 
		{
			var len:int = arr.length;
			var temp:*;
			var i:int = len;
			
			while (i--) 
			{
				var rand:int 	= Math.floor(Math.random() * len);
				temp 			= arr[i];
				arr[i] 			= arr[rand];
				arr[rand] 		= temp;
			}
			
			return arr;
		}
		
		public static function deleteItem(arr:Array, item:*):void
		{
			var itemindex:int;
			
			for (var i:int = 0; i < arr.length; i++) 
			{
				if (arr[i] == item)  { itemindex = i; }
			}
			
			arr.splice(itemindex, 1);
		}
		
		public static function deleteItemByIndex(arr:Array, index:int):void
		{
			arr.splice(index, 1);
		}
		
	}
	
}