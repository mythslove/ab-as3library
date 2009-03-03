package com.ab.display
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.ABMovieClip;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.net.URLRequest;
	//import com.ab.utils.DebugTF
	import com.ab.utils.Make
	import com.ab.utils.Make2
	import caurina.transitions.Tweener
	import flash.display.MovieClip;
	
	public class Image extends ABMovieClip
	{
        private var url:String;
        private var request:URLRequest;
		private var loader:Loader;
		private var _ITEM:Object;
		private var resultFunction:Function;
		
		private var RESULTFUNC:Function;
		private var _ARRAY_LENGTH:Number;
		
		public function Image(given_url:String, onImageLoadComplete:Function=null):void
        {
			super()
			
			RESULTFUNC = onImageLoadComplete
			
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
			RESULTFUNC(this)
        }
		
        private function ioErrorHandler(event:IOErrorEvent):void 
		{
            //trace("ioErrorHandler: " + event);
        }
		
        private function progressHandler(event:ProgressEvent):void 
		{
            //trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }
		
		////////////////////////////////////////////////////// END OF CLASS
	}	
}