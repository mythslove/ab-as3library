package com.ab.utils 
{
	/**
	* @author ABº
	* http://www.antoniobrandao.com/
	*/
	
	import flash.utils.ByteArray;
	
	public class ObjectUtil 
	{
		private static function areObjectsEqual(obj1:Object, obj2:Object):Boolean
		{
			var buffer1:ByteArray = new ByteArray();
			buffer1.writeObject(obj1);
			
			var buffer2:ByteArray = new ByteArray();
			buffer2.writeObject(obj2);
		 
			// compare the lengths
			var size:uint = buffer1.length;
			
			if (buffer1.length == buffer2.length) 
			{
				buffer1.position = 0;
				buffer2.position = 0;
				
				// then the bits
				while (buffer1.position < size)
				{
					var v1:int = buffer1.readByte();
					
					if (v1 != buffer2.readByte()) 
					{
						return false;
					}
				}
				
				return true;
			}
			
			return false;
		}
	}	
}