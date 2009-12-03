package com.ab.display
{
	/**
	* 
	* @author ABº
	* use it screw it and sell it, no problem
	* 
	* @about
	* Use this class to create an image somewhere in your code - fast
	* it extends Sprite so you can mess with the usual parameters
	* 
	* @requirements
	* half brain
	* 
	* @example
	* import com.ab.display.Image;
	* 
	* var nicevarname:Image = new Image(image_url, oncomplete_function, onprogress_function);
	* addChild(nicevarname);
	* 
	* // the on_complete and on_progress functions are optional
	* 
	*/
	
	import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.*;
	import flash.geom.Rectangle;
    import flash.net.URLRequest;
	import org.casalib.util.RatioUtil;
	
	public class Image extends Sprite
	{
		/// private
        private var url:String;
        private var request:URLRequest;
		public var loader:Loader;
		private var image:Bitmap;
		private var _dispatcher:IEventDispatcher
		private var _ON_COMPLETE_FUNCTION:Function;
		private var _ON_PROGRESS_FUNCTION:Function;
		
		/// public
		public var resize:Boolean = false;
		public var _width:Number  = 0;
		public var _height:Number = 0;
		
		public function Image(given_url:String, onImageLoadComplete:Function=null, onImageLoadProgress:Function=null):void
        {
			_ON_COMPLETE_FUNCTION = onImageLoadComplete;
			_ON_PROGRESS_FUNCTION = onImageLoadProgress;
			
            loader  = new Loader();
            request = new URLRequest(given_url);
			
			configureListeners(loader.contentLoaderInfo);
        }
		
		public function load():void
		{
			loader.load(request);
		}
		
		/// ////////////////////////////////////////////////// LISTENERS
		
        private function configureListeners(dispatcher:IEventDispatcher):void 
		{
            dispatcher.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
            dispatcher.addEventListener(Event.INIT, initHandler, false, 0, true);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler, false, 0, true);
        }
		
		/// ////////////////////////////////////////////////// RESULTS
		
        private function completeHandler(event:Event):void
		{
            //trace("completeHandler: " + event);
			
			image = loader.content as Bitmap;
			image.smoothing = true;
			
			addChild(image);
			
			if (resize == true)  
			{
				var newsize:Rectangle = RatioUtil.scaleToFill(new Rectangle(0, 0, image.width, image.height), new Rectangle(0, 0, _width, _height));
				image.width  = newsize.width;
				image.height = newsize.height;
			}
        }
		
        private function httpStatusHandler(event:HTTPStatusEvent):void
		{
            //trace("httpStatusHandler: " + event);
        }
		
        private function initHandler(event:Event):void
		{
			if (_ON_COMPLETE_FUNCTION != null)  { _ON_COMPLETE_FUNCTION(this)   };
        }
		
        private function ioErrorHandler(event:IOErrorEvent):void 
		{
            //trace("ioErrorHandler: " + event);
        }
		
        private function progressHandler(event:ProgressEvent):void 
		{
            //trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
			
			if (_ON_PROGRESS_FUNCTION != null)  { _ON_PROGRESS_FUNCTION(event) };
        }
		
		/// ////////////////////////////////////////////////// END OF CLASS
	}
}