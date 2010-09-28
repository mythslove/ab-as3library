package com.edigma.display
{
	/**
	* @author ABº
	*/
	
	//import com.edigma.display.EdigmaMovieClip
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.*;
	import flash.geom.Rectangle;
    import flash.net.URLRequest;
	//import flash.display.MovieClip;
	
	public class Image extends Sprite
	{
        private var url:String;
        private var request:URLRequest;
		private var loader:Loader;
		//private var _ITEM:Object;
		private var resultFunction:Function;
		
		private var RESULTFUNC:Function;
		private var PROGRESSFUNC:Function;
		
		public function Image(given_url:String, onImageLoadComplete:Function=null, onImageLoadProgress:Function=null):void
        {
			super()
			
			if (onImageLoadComplete != null) { RESULTFUNC = onImageLoadComplete }
			if (onImageLoadProgress != null) { PROGRESSFUNC = onImageLoadProgress }
			
            loader = new Loader();
            request = new URLRequest(given_url);
			request.contentType = "image/x-png"
			
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
            dispatcher.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
            dispatcher.addEventListener(Event.INIT, initHandler, false, 0, true);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler, false, 0, true);
			dispatcher.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true);
        }
		
		private function removedFromStageHandler(e:Event):void 
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
            loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            loader.contentLoaderInfo.removeEventListener(Event.INIT, initHandler);
            loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.contentLoaderInfo.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			//delete dispatcher;
			//dispatcher = null;
			
			//delete loader;
			loader = null;
		}
		
		////////////////////////////////////////////////////// RESULTS
		
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
			if (RESULTFUNC != null) 
			{
				RESULTFUNC(this)
			}
        }
		
        private function ioErrorHandler(event:IOErrorEvent):void 
		{
            trace("ioErrorHandler: " + event);
        }
		
        private function progressHandler(event:ProgressEvent):void 
		{
			if (PROGRESSFUNC != null) 
			{
				PROGRESSFUNC(event)
			}
			
            //trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }
		
		////////////////////////////////////////////////////// END OF CLASS
	}	
}