package com.ab.utils 
{
	
	/**
	* @author ABº
	*/
	
	public class Get 
	{
		
		public function Get() 
		{
			// e quê tá tudo ?
		}
		
		
		/// returns an array of all values from an object
		public static function ValuesFromObject(_object:Object):Array
		{
			var return_array = new Array();
			
			for each (var value:* in _object)
			{
				return_array.push(value)
			}
			
			trace("Get ::: values found: " + return_array);
			
			return return_array;
		}
		
		public static function ItemIndexFromData(data_obj:Object, id:Number):Number
		{
			var resultnum:Number = 0
			
			for (var i:int = 0; i < data_obj._total; i++)
			{
				if (id == data_obj.id_item[i])
				{
					resultnum = i;
				}
			}
			
			return resultnum;
		}
		
		/*
		/// returns an array of values of a specific type from an object
		public static function ValuesOfSpecificTypeFromObject(_object:Object, _type:*=String):Array
		{
			var return_array = new Array();
			
			for each (var value:_type in _object)
			{
				return_array.push(value)
			}
			
			trace("Get ::: specific values found: " + return_array);
			
			return return_array;
		}
		*/
		/// returns array of children contained in a given object
		public static function AllChildren(target_mc:Object):Array 
		{
			var childrenArray:Array = new Array;
			
			//for (var i:uint = 0; i & lt; target_mc.numChildren; i++)
			for (var i:uint = 0; target_mc.numChildren; i++)
			{
				trace ('\t|\t ' +i + '.\t name:' + target_mc.getChildAt(i).name + '\t type:' + typeof (target_mc.getChildAt(i)) + '\t' + target_mc.getChildAt(i));
				childrenArray.push(target_mc.getChildAt(i));
			}
			
			return childrenArray;
		}
		
	}
}