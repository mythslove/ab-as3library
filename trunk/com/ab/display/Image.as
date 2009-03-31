package com.ab.display
{
	/**
	* @author ABº
	*/
	
	
	import com.edigma.display.EdigmaSprite;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.net.URLRequest;
	import com.ab.utils.Make;
	import caurina.transitions.Tweener
	import flash.display.MovieClip;
	import org.casalib.util.RatioUtil
	
	public class Image extends EdigmaSprite
	{
        private var url:String;
        private var request:URLRequest;
		private var loader:Loader;
		private var _ITEM:Object;
		
		private var _ARRAY_LENGTH:Number;
		private var _ON_COMPLETE_FUNCTION:Function;
		private var _ON_PROGRESS_FUNCTION:Function;
		static private var _TARGET_MC:Object;
		
		public function Image(given_url:String, onImageLoadComplete:Function=null, onImageLoadProgress:Function=null):void
        {
			super()
			
			_ON_COMPLETE_FUNCTION = onImageLoadComplete;
			_ON_PROGRESS_FUNCTION = onImageLoadProgress;
			
            loader = new Loader();
            request = new URLRequest(given_url);
			
			configureListeners(loader.contentLoaderInfo);
        }
		
		public function load():void
		{
			loader.load(request);
			
            this.addChild(loader);
		}
		
		////////////////////////////////////////////////////// LISTENERS
		
        private function configureListeners(dispatcher:IEventDispatcher):void 
		{
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        }
		
		////////////////////////////////////////////////////// RESULTS
		
        private function completeHandler(event:Event):void
		{
            trace("completeHandler: " + event);
        }
		
        private function httpStatusHandler(event:HTTPStatusEvent):void
		{
            //trace("httpStatusHandler: " + event);
        }
		
        private function initHandler(event:Event):void
		{
			if (_ON_COMPLETE_FUNCTION != null) 
			{
				_ON_COMPLETE_FUNCTION(_TARGET_MC)
				//_ON_COMPLETE_FUNCTION(this)
			}
        }
		
        private function ioErrorHandler(event:IOErrorEvent):void 
		{
            //trace("ioErrorHandler: " + event);
        }
		
        private function progressHandler(event:ProgressEvent):void 
		{
            //trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
			
			if (_ON_PROGRESS_FUNCTION != null) 
			{
				_ON_PROGRESS_FUNCTION(event)
			}
        }
		
		public static function load(url:String, target:Object, onComplete:Function = null, onProgress:Function = null):Image
		{
			_TARGET_MC = target
			var img:* = new Image(url, onComplete, onProgress);
			target.addChild(img);
			img.load();
			return img;
		}
		
		////////////////////////////////////////////////////// END OF CLASS
	}
}