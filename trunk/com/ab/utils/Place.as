package com.ab.utils 
{
	/**
	* 
	* @author ABº
	* 
	*/
	
	import flash.display.MovieClip
	import caurina.transitions.Tweener
	//import com.ab.utils.DebugTF
	
	public class Place
	{
		
		public function Place() 
		{
			// e quê tá tudo ?
		}
		
		/// Places an item retrieved from the library in a grid with a defined amount of columns
		public static function ItemsInGrid(library_item:*, total_items:Number, columns:Number, holder_mc:Object, horizontal_distance:Number, vertical_distance:Number, array_to_feed:Array=null):void
		{
			var _counter:Number = 0
			var linecounter:Number = 0
			
			//DebugTF.getSingleton().echo2(total_items.toString())
			
			for (var i:int = 0; i < total_items; i++) 
			{
				var newitem = holder_mc.addChild(new library_item())
				
				newitem.x = horizontal_distance * _counter;
				newitem.y = vertical_distance * linecounter;
				
				if (array_to_feed != null) 
				{
					array_to_feed.push(newitem)
				}
				
				if (_counter == columns)
				{
					_counter = 0
					
					linecounter++
				}
				else
				{
					_counter++
				}
				
				
				//DebugTF.getSingleton().echo(i.toString())
			}
		}
	}
}