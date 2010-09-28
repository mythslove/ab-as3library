package com.ab.utils
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.text.TextField;    

	public class DisplayUtil 
	{
		public static function adjustBrightness ( displayObject : DisplayObject , brightness : Number ) : void
		{
			var colorTransform : ColorTransform = new ColorTransform( ) ;
			colorTransform.redOffset = brightness * 255 ;
			colorTransform.greenOffset = brightness * 255 ;
			colorTransform.blueOffset = brightness * 255 ;
			displayObject.transform.colorTransform = colorTransform ;
		}
		
		public static function getNonTransparentBounds ( displayObject : DisplayObject ) : Rectangle
		{
			var bitmapData : BitmapData = new BitmapData( displayObject.width , displayObject.height , true , 0x00000000 ) ;
			bitmapData.draw( displayObject ) ;
			
			var maskColor : uint = 0xFF000000 ;
			var color : uint = 0x00000000 ;
			
			var rect : Rectangle = bitmapData.getColorBoundsRect( maskColor , color , false ).clone( ) ;
			bitmapData.dispose( ) ;
			
			return rect ;
		}
		
		public static function removeChildren ( container : DisplayObjectContainer , ignoreTypes : Array = null ) : Array
		{
			var removeList : Array = new Array( ) ;
			var child : DisplayObject ;
			var ignore : Boolean ;
			
			for ( var i : uint = 0 , n : uint = container.numChildren ; i < n ; i++ )
			{
				ignore = false ;
				child = container.getChildAt( i ) ;
				for each ( var type : Class in ignoreTypes ) if ( child is type ) ignore = true ;
				if ( ! ignore ) removeList.push( child ) ;
			}
			
			for each ( child in removeList ) container.removeChild( child ) ;
			return removeList ;
		}
		
		public static function snap ( object : DisplayObject ) : void
		{
			object.x = object.x >> 0 ;
			object.y = object.y >> 0 ;
			
			if ( ! object is TextField )
			{
				object.width = object.width >> 0 ;
				object.height = object.height >> 0 ;
			}
		}
		
		public static function snapChildrenToNearestPixel ( parent : DisplayObjectContainer , ignoreTypes : Array = null ) : void
		{
			var child : DisplayObject ;
			
			for ( var i : uint = 0 , n : uint = parent.numChildren ; i < n ; i ++ )
			{
				child = parent.getChildAt( i ) as DisplayObject ;
				if ( ! ObjectUtil.isObjectOfType( child , ignoreTypes ) ) DisplayUtil.snap( child ) ;
				if ( child is DisplayObjectContainer ) DisplayUtil.snapChildrenToNearestPixel( child as DisplayObjectContainer ) ;
			}
			
			DisplayUtil.snap( parent ) ;
		}
	}
}