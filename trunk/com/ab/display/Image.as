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
	* nothing
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
	
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.net.URLRequest;
	
	public class Image extends Sprite
	{
        private var url:String;
        private var request:URLRequest;
		private var loader:Loader;
		
		private var _ON_COMPLETE_FUNCTION:Function;
		private var _ON_PROGRESS_FUNCTION:Function;
		
		public function Image(given_url:String, onImageLoadComplete:Function=null, onImageLoadProgress:Function=null):void
        {
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
		
		/// ////////////////////////////////////////////////// LISTENERS
		
        private function configureListeners(dispatcher:IEventDispatcher):void 
		{
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        }
		
		/// ////////////////////////////////////////////////// RESULTS
		
        private function completeHandler(event:Event):void
		{
            //trace("completeHandler: " + event);
        }
		
        private function httpStatusHandler(event:HTTPStatusEvent):void
		{
            //trace("httpStatusHandler: " + event);
        }
		
        private function initHandler(event:Event):void
		{
			if (_ON_COMPLETE_FUNCTION != null) 
			{
				_ON_COMPLETE_FUNCTION(this)
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
		
		/// ////////////////////////////////////////////////// END OF CLASS
	}
}