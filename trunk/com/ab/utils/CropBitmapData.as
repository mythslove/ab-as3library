package com.ab.utils 
{
	/**
	* @author Jason Bejot & ABº
	* 
	* Adapted from http://jasonbejot.com/?p=58
	* 
	* http://jasonbejot.com/?p=58
	* http://www.antoniobrandao.com/
	* http://blog.antoniobrandao.com/
	*/
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class CropBitmapData 
	{
		
		public function CropBitmapData() 
		{
			
		}
		
		public static function process(original:BitmapData):BitmapData
		{
			/// create something that has BitmapData for me to resize
			bmp = new Bitmap(original);
			
			/// create a new BitmapData instance at the size i want bmp to be
			var temp:BitmapData = new BitmapData(200, 200);
			
			/// copy the pixels from bmp to the new BitmapData instance
			temp.copyPixels(bmp.bitmapData, temp.rect, bmp.bitmapData.rect.topLeft);
			
			/// clear out bmp's old BitmapData
			bmp.bitmapData.dispose();
			
			// assign the resized BitmapData to bmp's (now empty) BitmapData
			//bmp.bitmapData = temp;
			
			return temp;
		}
		
	}
	
}