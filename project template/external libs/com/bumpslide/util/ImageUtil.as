/**
 * This code is part of the Bumpslide Library by David Knape
 * http://bumpslide.com/
 * 
 * Copyright (c) 2006, 2007, 2008 by Bumpslide, Inc.
 * 
 * Released under the open-source MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 * see LICENSE.txt for full license terms
 */ 
package com.bumpslide.util {

	/**
	* Some Bitmap and image-related utility functions
	* 
	* In as2, we had image smoothing stuff here.  For as3, just set bmp.smoothing=true
	* where bmp = (loader.content as Bitmap)
	* 
	* @author David Knape  
	*/
	
	import flash.geom.Rectangle;
    import flash.display.*;
    
    public class ImageUtil
	{
		/**
		* Resizes an image or rectangle to fit within a bounding box
		* while preserving aspect ratio.  The third parameter is optional.
		* AllowStretching allows the image bounds to be stetched beyond the 
		* original size. By default this is off. We use this most often for sizing 
		* dynamically loaded JPG's, and we don't want them to be stetched larger 
		*  
		* @param	original - image size as a rectangle, max dimensions if allowStetching is left to false
		* @param	bounds - the target size and/or available space for displaying the image
		* @param	allowStetching - default is false
		*/
		static public function resizeRect( original:Rectangle, bounds:Rectangle, allowStretching:Boolean=false ) : Rectangle {
			
			var size:Rectangle = original.clone();						
			var aspectRatio:Number = original.width/original.height;
			
			// first we size based on width
			// check for max width, resize if necessary
			if(allowStretching || size.width>bounds.width) {
			  size.width = bounds.width;
			  size.height = size.width / aspectRatio;
			}           
			
			// after size by width, check height
			// make it even smaller if necessary
			if(size.height>bounds.height) {			
				size.height = bounds.height;
				size.width = size.height * aspectRatio;;
			}     
			
			return size;
		}
		
        static public function resize(mc:DisplayObject, maxWidth:Number, maxHeight:Number, allowStretching:Boolean):void
        {   
        	var img:DisplayObject = (mc is Loader) ?  (mc as Loader).content : mc;
        	img.scaleX = img.scaleY = 1;
        	var mcRect:Rectangle = new Rectangle(0,0, img.width, img.height);
        	//trace("resize() Image Rect = "+mcRect);
			var newSize:Rectangle = ImageUtil.resizeRect( mcRect, new Rectangle(0,0,maxWidth,maxHeight), allowStretching );
			//trace("resize() New Size = "+newSize);
			img.width = newSize.width;
			img.scaleY = img.scaleX;
        }
        
        /**
         * Crops display object using a scrollrect - stretches to fill rect defined by width and height
         */
        static public function crop( mc:DisplayObject, w:Number, h:Number, center:Boolean=true ) : void {        	
        	
        	var rect:Rectangle = new Rectangle(0,0,w,h);			
			var img:DisplayObject = (mc is Loader) ?  (mc as Loader).content : mc;	
			
			// make image as wide as width and scale Y to match
			img.width = w; 
			img.scaleY = img.scaleX;
			
			// if height is less than h
			if(img.height<h) {
				img.height = h;
				img.scaleX = img.scaleY;
			}
			
			// center scrollRect in image (crop to fit)
			if(center) {
				rect.x = Math.round((img.width-w)/2);
				rect.y = Math.round((img.height-h)/2);
			}
			mc.scrollRect = rect;
        }
    }

}