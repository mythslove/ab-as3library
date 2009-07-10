package com.ab.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	* @author ABº
	* http://blog.antoniobrandao.com/
	*/
	
	public class Get 
	{
		static private var _bitmapdata:BitmapData
		static private var _bitmaploader:Loader
		static private var _bitmaploaderReturnFunction:Function
		
		public function Get() 
		{
			// e quê tá tudo ?
			
			//_bitmaploader = new Loader();
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
		
		public static function BitmapDataFromExternalImage(path_to_image:String, returnFunc:Function):void
		{
			_bitmaploaderReturnFunction = returnFunc;
			
			var bitmaploader = new Loader();
			_bitmaploader = bitmaploader;
			
			bitmaploader.load(new URLRequest(path_to_image));
			bitmaploader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBitmapLoadComplete);
		}
		
		static private function onBitmapLoadComplete(e:Event):void 
		{
			var lalala = _bitmaploader.contentLoaderInfo.content;
			
			_bitmaploaderReturnFunction( Bitmap(lalala).bitmapData );
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
			for (var i:uint = 0; i < target_mc.numChildren; i++)
			{
				childrenArray.push(target_mc.getChildAt(i));
			}
			
			return childrenArray;
		}		
		
		
		
		
	}
}