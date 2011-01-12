package com.ab.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.ColorTransform;
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
		
		public function Get() { };
		
		/**
		 * Converts the amount of milliseconds into a string based time code.
		 * @param	milliseconds
		 * @param	delimiter
		 * @param 	withHours
		 * @return	The time code as a string.
		 */
		public static function getTimeCodeFromMilliseconds( milliseconds:Number, delimeter:String = ":", withHours:Boolean = false ):String
		{
			var posHours:Number = Math.floor( milliseconds / 1000 / 60 / 60 );
			var posMins:Number = Math.floor( milliseconds / 1000 / 60 );
			var posSecs:Number = Math.round( milliseconds / 1000 % 60 );
			
			if( posSecs >= 60 )
			{
				posSecs = 0;
				posMins++;
			}
			
			if( posMins >= 60 )
			{
				posMins = 0;
				posHours++;
			}
			
			var timeHours:String = ( posHours < 10 ) ? "0" + posHours.toString() : posHours.toString();
			var timeMins:String = ( posMins < 10 ) ? "0" + posMins.toString() : posMins.toString();
			var timeSecs:String = ( posSecs < 10 ) ? "0" + posSecs.toString() : posSecs.toString();
			var result:String = timeMins + delimeter + timeSecs;
			
			if( withHours )
			{
				result = timeHours + delimeter + result;
			}
			
			return result;
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
			var return_array:Array = new Array();
			
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
			
			var bitmaploader:Loader = new Loader();
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
		* Get the visible bounds of an object returned in a Rectangle
		* 
		* Maximum measureable dimensions of the supplied object: 2000x2000.
		*/
		public static function getVisibleBounds(source:DisplayObject):Rectangle 
		{ 
			var wrongBounds:Rectangle 	= source.getBounds(source); 
			var matrix:Matrix 			= new Matrix(); 
			matrix.translate(-wrongBounds.x, -wrongBounds.y); 
			var bitmapData:BitmapData 	= new BitmapData(source.width, source.height, true, 0x00000000); 
			bitmapData.draw(source, matrix); 
			var bounds:Rectangle 		= bitmapData.getColorBoundsRect(0xFF000000, 0, false); 
			bitmapData.dispose(); 
			return bounds; 
		}
		
		/**
		* Maximum measureable dimensions of the supplied object: 2000x2000.
		*/
		public static function visibleHeight(o:DisplayObject):Number 
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
		public static function visibleWidth(o:DisplayObject):Number 
		{
		  var bitmapDataSize:int = 2000;
		  var bounds:Rectangle;
		  var bitmapData:BitmapData = new BitmapData(bitmapDataSize, bitmapDataSize, true, 0);
		  bitmapData.draw(o);
		  bounds = bitmapData.getColorBoundsRect( 0xFF000000, 0x00000000, false );
		  bitmapData.dispose(); 
		  return bounds.x + bounds.width;
		}
		
		
		/** Get the collision rectangle between two display objects. **/
		/** By Troy Gilbert - http://troygilbert.com/2009/08/pixel-perfect-collision-detection-revisited/ **/
		public static function getCollisionRect(target1:DisplayObject, target2:DisplayObject, commonParent:DisplayObjectContainer, pixelPrecise:Boolean = false, tolerance:int = 255):Rectangle
		{
			// get bounding boxes in common parent's coordinate space
			var rect1:Rectangle = target1.getBounds(commonParent);
			var rect2:Rectangle = target2.getBounds(commonParent);
		   
			// find the intersection of the two bounding boxes
			var intersectionRect:Rectangle = rect1.intersection(rect2);
		   
			// if not pixel-precise, we're done
			if (!pixelPrecise) return intersectionRect;
		   
			// size of rect needs to be integer size for bitmap data
			intersectionRect.x = Math.floor(intersectionRect.x);
			intersectionRect.y = Math.floor(intersectionRect.y);
			intersectionRect.width = Math.ceil(intersectionRect.width);
			intersectionRect.height = Math.ceil(intersectionRect.height);
		   
			// if the rect is empty, we're done
			if (intersectionRect.isEmpty()) return intersectionRect;
		   
			// calculate the transform for the display object relative to the common parent
			var parentXformInvert:Matrix = commonParent.transform.concatenatedMatrix.clone();
			parentXformInvert.invert();
			var target1Xform:Matrix = target1.transform.concatenatedMatrix.clone();
			target1Xform.concat(parentXformInvert);
			var target2Xform:Matrix = target2.transform.concatenatedMatrix.clone();
			target2Xform.concat(parentXformInvert);
		   
			// translate the target into the rect's space
			target1Xform.translate(-intersectionRect.x, -intersectionRect.y);
			target2Xform.translate(-intersectionRect.x, -intersectionRect.y);
		   
			// combine the display objects
			var bd:BitmapData = new BitmapData(intersectionRect.width, intersectionRect.height, false);
			bd.draw(target1, target1Xform, new ColorTransform(1, 1, 1, 1, 255, -255, -255, tolerance), BlendMode.NORMAL);
			bd.draw(target2, target2Xform, new ColorTransform(1, 1, 1, 1, 255, 255, 255, tolerance), BlendMode.DIFFERENCE);
		   
			// find overlap
			var overlapRect:Rectangle = bd.getColorBoundsRect(0xffffffff, 0xff00ffff);
			overlapRect.offset(intersectionRect.x, intersectionRect.y);
		   
			return overlapRect;
		}
	}
}