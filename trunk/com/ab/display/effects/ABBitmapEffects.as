package com.ab.display.effects 
{
	/**
	* @author ABº
	*/
	
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import fl.motion.AdjustColor
	
	public class ABBitmapEffects 
	{
		public static var grayscale_matrix:Array = [0.3086,0.6094,0.082,0,5,0.3086,0.6094,0.082,0,5,0.3086,0.6094,0.082,0,5,0,0,0,1,0];
		public static var sepia_matrix:Array = [0.3930000066757202, 0.7689999938011169, 0.1889999955892563, 0, 0, 0.3490000069141388, 0.6859999895095825, 0.1679999977350235, 0, 0, 0.2720000147819519, 0.5339999794960022, 0.1309999972581863, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
		public static var enhance_colours_matrix:Array = [1.7386848, -0.2632608, -0.035424, 0, -6.34, -0.1333152, 1.6087392, -0.035424, 0, -6.34, -0.1333152, -0.2632608, 1.836576, 0, -6.34, 0, 0, 0, 1, 0];
		public static var brighten_matrix:Array = [1.20742, -0.18282, -0.0246, 0, 50, -0.09258, 1.11718, -0.0246, 0, 50, -0.09258, -0.18282, 1.2754, 0, 50, 0, 0, 0, 1, 0];
		
		public static function adjustColour(displayobject:DisplayObject, brightness:Number, contrast:Number, hue:Number, saturation:Number):Array
		{
			var color:AdjustColor;
			var colorMatrix:ColorMatrixFilter;
			var matrix:Array;
			var filter:Array;
			
			color 					= new AdjustColor();
			color.brightness 		= brightness;
			color.contrast 			= contrast;
			color.hue 				= hue;
			color.saturation 		= saturation;
			
			matrix 					= color.CalculateFinalFlatArray();
			colorMatrix 			= new ColorMatrixFilter(matrix);
			filter 					= [colorMatrix];
			
			displayobject.filters 	= filter;
		}
		
		/// returns a sepia filter
		public static function sepia():Array
		{
			/// usage: your_displayobject.filters	= ABBitmapEffects.sepia();
			
			var cmFilter	= new ColorMatrixFilter(sepia_matrix);
			var filter		= new Array();
			
			filter.splice(0, 1, cmFilter);
			
			return filter;
		}
		
		/// returns a grayscale filter
		public static function grayscale():Array
		{
			/// usage: your_displayobject.filters	= ABBitmapEffects.grayscale();
			
			var cmFilter	= new ColorMatrixFilter(grayscale_matrix);
			var filter		= new Array();
			
			filter.splice(0, 1, cmFilter);
			
			return filter;
		}
		
		/// returns a brighten filter
		public static function brighten():Array
		{
			/** @usage: your_displayobject.filters	= ABBitmapEffects.brighten(); */
			
			var cmFilter	= new ColorMatrixFilter(brighten_matrix);
			var filter		= new Array();
			
			filter.splice(0, 1, cmFilter);
			
			return filter;
		}
		
		public static function applySepia(o:DisplayObject):Array
		{
			/* usage: ABBitmapEffects.applySepia(your_displayobject); */
			
			var cmFilter	= new ColorMatrixFilter(sepia_matrix);
			var filter		= new Array();
			
			filter.splice(0, 1, cmFilter);
			
			o.filters = filter;
		}
		
		public static function applyGrayscale(o:DisplayObject):Array
		{
			/// usage: ABBitmapEffects.applyGrayscale(your_displayobject);
			
			var cmFilter	= new ColorMatrixFilter(grayscale_matrix);
			var filter		= new Array();
			
			filter.splice(0, 1, cmFilter);
			
			o.filters = filter;
		}
		
		public static function applyBrighten(o:DisplayObject):Array
		{
			/// usage: ABBitmapEffects.applyBrighten(your_displayobject);
			
			var cmFilter	= new ColorMatrixFilter(brighten_matrix);
			var filter		= new Array();
			
			filter.splice(0, 1, cmFilter);
			
			o.filters = filter;
		}
	}
	
}