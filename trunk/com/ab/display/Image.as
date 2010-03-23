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
	
	import com.ab.utils.CropBitmapData;
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
		
		public var debug:Boolean=false;
		//private var image:Bitmap;
		private var _dispatcher:IEventDispatcher
		private var _ON_COMPLETE_FUNCTION:Function;
		private var _ON_PROGRESS_FUNCTION:Function;
		
		/// public
		public var resize:Boolean = false;
		public var _width:Number  = 0;
		public var _height:Number = 0;
		
		private var _constructorArgs:Array;
		
		public function Image(given_url:String, onImageLoadComplete:Function=null, onImageLoadProgress:Function=null):void
        {
			_constructorArgs = arguments;
			
			_ON_COMPLETE_FUNCTION = onImageLoadComplete;
			_ON_PROGRESS_FUNCTION = onImageLoadProgress;
			
            loader  = new Loader();
            request = new URLRequest(given_url);
			
			configureListeners(loader.contentLoaderInfo);
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
        }
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			load();
		}
		
		public function setResizeOnLoad(w:Number, h:Number):void
		{
			if (w)
			{
				if (h)
				{
					resize = true;	_width  = w; _height = h;
				}
				else { trace ("ERROR: Image ::: setResizeOnLoad() -> Height for resize not provided or NaN."); }
			}
			else { trace ("ERROR: Image ::: setResizeOnLoad() -> Width for resize not provided or NaN."); }
			
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
			
			var image = loader.content as Bitmap;
			image.smoothing = true;
			
			if (resize == true)  
			{
				if (debug == true) 
				{
					//trace ("Image ::: -------------- RESIZE to " + _width + " x " + _height + " --------"); 
					
					//trace ("1 Image ::: width before  = "  + image.width);
					//trace ("1 Image ::: height before = "  + image.height);
				}
				
				//var newsize:Rectangle = RatioUtil.scaleToWidth(new Rectangle(0, 0, image.width, image.height), new Rectangle(0, 0, _width, _height));
				//var newsize:Rectangle = RatioUtil.scaleWidth(new Rectangle(0, 0, image.width, image.height), _height);
				//var newsize:Rectangle = RatioUtil.scaleHeight(new Rectangle(0, 0, image.width, image.height), _width);
				//image.width  = newsize.width;
				//image.height = newsize.height;
				
				var nu_w:Number 
				var nu_h:Number 
				
				if (image.width > image.height)
				{
					nu_w = _width; nu_h = (image.height * nu_w) / image.width; trace ("Image ::: Case 1"); 
				}
				else
				{
					if (image.width < image.height)
					{
						nu_h = _height; nu_w = (image.width * nu_h) / image.height; trace ("Image ::: Case 2"); 
					}
				}
				
				image.width  = nu_w;
				image.height = nu_h;
				
				if (debug == true) 
				{
					//trace ("2 Image ::: width after  = "  + image.width );
					//trace ("2 Image ::: height after = " + image.height );
					//trace (" ---- ");
					
					if (nu_h < _height) 
					{
						//trace ("Image ::: nu_h < _height");
					}
					else
					{
						if (nu_w < _width) 
						{
							//trace ("Image ::: nu_w < _width");
						}
					}
				}
				
				
				//image = CropBitmapData.process(image.bitmapData, _width, _height);
				
				//trace ("2 Image ::: newsize.width  = " + newsize.width ); 
				//trace ("2 Image ::: newsize.height = " + newsize.height );
			}
			
			addChild(image);
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