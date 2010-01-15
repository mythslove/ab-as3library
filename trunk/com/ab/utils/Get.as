﻿package com.ab.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	/**
	* @author ABº
	* 
	* http://www.antoniobrandao.com/
	* http://blog.antoniobrandao.com/
	*/
	
	public class Get 
	{
		static private var _bitmapdata:BitmapData
		static private var _bitmaploader:Loader
		static private var _bitmaploaderReturnFunction:Function
		static private var _custom_resize_width:Number=0;
		static private var _custom_resize_height:Number=0;
		
		public function Get()
		{
			
		}   
		
		
		/// returns a random number between two values
		public static function RandomNumberBetween(number1:Number, number2:Number):Number
		{
			var high:Number
			var low:Number
			
			if (number1 > number2) 
			{
				high = number1;
				low = number2;
			}
			else
			{
				high = number2;
				low  = number1;
			}
			
			return Math.floor(Math.random() * (high - low)) + low;
		}
		
		/// returns an array of all values from an object
		public static function ValuesFromObject(_object:Object):Array
		{
			var return_array = new Array();
			
			for each (var value:* in _object)
			{
				return_array.push(value)
			}
			
			//trace("Get ::: values found: " + return_array);
			
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
		
		public static function BitmapDataFromExternalImage(path_to_image:String, returnFunc:Function, custom_width:Number=NaN, custom_height:Number=NaN):void
		{
			_bitmaploaderReturnFunction = returnFunc;
			
			_custom_resize_width  = isNaN(custom_width)  ? 0 : custom_width;
			_custom_resize_height = isNaN(custom_height) ? 0 : custom_height;
			
			var bitmaploader = new Loader();
			_bitmaploader = bitmaploader;
			
			bitmaploader.load(new URLRequest(path_to_image));
			bitmaploader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBitmapLoadComplete);
		}
		
		static private function onBitmapLoadComplete(e:Event):void 
		{
			//_bitmaploader.contentLoaderInfo.content;
			
			var loader_content:Bitmap = Bitmap(_bitmaploader.contentLoaderInfo.content)//, "auto", true);
			
			var bitmapdata1:BitmapData = Bitmap(_bitmaploader.contentLoaderInfo.content).bitmapData;
			
			loader_content.smoothing = true;
			
			
			if (_custom_resize_width  != 0 && _custom_resize_height != 0) 
			{   
				var resizedBitmapData:BitmapData = new BitmapData(_custom_resize_width, _custom_resize_height, true);
				
				var mat:Matrix = new Matrix();
				mat.scale(_custom_resize_width / loader_content.width, _custom_resize_height / loader_content.height);
				
				var bmpData:BitmapData = new BitmapData(_custom_resize_width, _custom_resize_height, true, 0xFFFFFF);
				//bmpData.
				bmpData.draw(loader_content, mat);
				
				_bitmaploaderReturnFunction(bmpData);
			}
			else
			{
				_bitmaploaderReturnFunction(bitmapdata1);
			}
		}
		
		/*
		/// returns an array of values of a specific type from an object
		public static function ValuesOfSpecificTypeFromObject(_object:Object, _type:String=*):Array
		{
			var return_array = new Array();
			
			for each (var value:_type in _object)
			{
				return_array.push(value)
			}
			
			trace("Get ::: specific values found: " + return_array);
			
			return return_array;
		}*/
		
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
		
		/** 
		 * Returns a bounding rectangle for the visible contents of a DisplayObject. Note that you will be limited 
		 * by the max dimensions of a BitmapData instance (2880px for FP9). 
		 */ 
		public static function getVisibleBounds(source:DisplayObject):Rectangle 
		{ 
			const bitmapData : BitmapData = new BitmapData(source.width, source.height, true, 0); 
			bitmapData.draw(source); 
			const bounds : Rectangle = bitmapData.getColorBoundsRect(0xFF000000, 0, false); 
			bitmapData.dispose(); 
			return bounds; 
		} 
		
		/**
		* Maximum measureable dimensions of the supplied object: 2000x2000.
		*/
		function visibleHeight(o:DisplayObject):Number 
		{
		  var bitmapDataSize:int = 2000;
		  var bounds:Rectangle;
		  var bitmapData:BitmapData = new BitmapData(bitmapDataSize, bitmapDataSize, true, 0);
		  bitmapData.draw(o);
		  bounds = bitmapData.getColorBoundsRect( 0xFF000000, 0x00000000, false );
		  bitmapData.dispose(); 
		  return bounds.y + bounds.height;
		}
		
		/**
		* Maximum measureable dimensions of the supplied object: 2000x2000.
		*/
		function visibleWidth(o:DisplayObject):Number 
		{
		  var bitmapDataSize:int = 2000;
		  var bounds:Rectangle;
		  var bitmapData:BitmapData = new BitmapData(bitmapDataSize, bitmapDataSize, true, 0);
		  bitmapData.draw(o);
		  bounds = bitmapData.getColorBoundsRect( 0xFF000000, 0x00000000, false );
		  bitmapData.dispose(); 
		  return bounds.x + bounds.width;
		}
	}
}