package com.ab.utils 
{
	/**
	* @author ABº
	*/
	
	import flash.display.MovieClip
	import caurina.transitions.Tweener
	
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
	}
}