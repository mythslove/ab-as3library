/**
* 
* @author ABº
* http://blog.antoniobrandao.com/
* 
* Handy class to move objects on stage with the minimum of hassle
* extra optional parameters can be passed such as ALPHA, TRANSITION STYLE etc
* 
* USAGE : 
* 
* 	  import com.ab.utils.Place
* 
* 	  Place.ItemsInGrid(items_array, 3, 3, 10, 10)
* 
* DEPENDENCIES :
* 
* 	  none
*/

package com.ab.utils 
{
	import flash.display.MovieClip
	
	public class Place
	{
		
		public function Place() 
		{
			/// e quê tá tudo ?
		}
		
		public static function ItemsInGrid(_ITEMS_ARRAY:Array, columns:Number, horizontal_distance:Number, vertical_distance:Number):void
		{
			var _counter:Number = 0
			var linecounter:Number = 0
			
			for (var i:int = 0; i < _ITEMS_ARRAY.length; i++) 
			{
				_ITEMS_ARRAY[i].x = horizontal_distance * _counter;
				_ITEMS_ARRAY[i].y = vertical_distance * linecounter;
				
				if (_counter == columns)
				{
					_counter = 0
					
					linecounter++
				}
				else
				{
					_counter++
				}
			}
		}
		
		public static function ItemsInVerticalGrid(_ITEMS_ARRAY:Array, columns:Number, horizontal_distance:Number, vertical_distance:Number):void
		{
			var _counter:Number = 0
			var linecounter:Number = 0
			
			for (var i:int = 0; i < _ITEMS_ARRAY.length; i++) 
			{
				_ITEMS_ARRAY[i].x = horizontal_distance * _counter;
				_ITEMS_ARRAY[i].y = vertical_distance * linecounter;
				
				if (_counter == columns)
				{
					_counter = 0
					
					linecounter++
				}
				else
				{
					_counter++
				}
			}
		}
		
		public static function ItemsInHorizontalGrid(_ITEMS_ARRAY:Array, rows:Number, horizontal_distance:Number, vertical_distance:Number):void
		{
			var _counter:Number = 0
			var columncounter:Number = 0
			
			for (var i:int = 0; i < _ITEMS_ARRAY.length; i++) 
			{
				_ITEMS_ARRAY[i].x = horizontal_distance * columncounter;
				_ITEMS_ARRAY[i].y = vertical_distance * _counter;
				
				if (_counter == rows-1)
				{
					_counter = 0
					
					columncounter++
				}
				else
				{
					_counter++
				}
			}
		}
	}
}