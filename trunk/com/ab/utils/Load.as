package com.ab.utils
{
	/**
	* 
	* @author ABº
	* http://blog.antoniobrandao.com/
	* 
	* THIS CLASS IS NOT READY FOR USE
	* 
	*/
	
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.net.URLRequest;
	//import com.ab.utils.DebugTF
	import caurina.transitions.Tweener
	import flash.display.MovieClip;
	
	public class Load
	{
        static private var url:String;
        static private var request:URLRequest;
		static private var loader:Loader;
		static private var _ITEM:Object;
		static private var resultFunction:Function;
		
		static private var _TARGET_ROOT:MovieClip
		static private var _IMAGES_ARRAY_COUNTER:Number;
		static private var _IMAGES_ARRAY:Array;
		static private var _HOLDER_NAME:String;
		static private var _SINGLE_LOAD_MC:Object;
		static private var _IMAGE_PROPERTY_LABEL:String;
		static private var _ON_COMPLETE_FUNC:Function;
		static private var _CURRENT_ITEM:Object;
		static private var _ON_TOTAL_COMPLETE_FUNC:Function;
		static private var _SINGLELOAD_RESULTFUNC:Function;
		static private var _SINGLELOAD_MC:Object;
		static private var _ARRAY_COUNTER:Number;
		static private var _ARRAY_LENGTH:Number;
		
		public static function Image(mc:Object, given_url:String, onItemCompleteFunc:Function=null):void
        {
			_SINGLELOAD_MC = mc
			_SINGLELOAD_RESULTFUNC = onItemCompleteFunc
			
			url = given_url
			
            loader = new Loader();
            request = new URLRequest(url);
			
			configureListeners(loader.contentLoaderInfo);
			
            loader.load(request);
			
            _SINGLELOAD_MC.addChild(loader);
			
			_SINGLE_LOAD_MC = mc
        }
		
		public static function ImagesArray(items:Array, img_prop_name:String, holder_name:String=null, onItemCompleteFunc:Function=null, onTotalCompleteFunc=null):void
        {
			//DebugTF.getSingleton().echo("ImagesArray INVOKED")
			
			if (img_prop_name != null) 
			{
				if (holder_name != null) 
				{
					_IMAGES_ARRAY = items
					_HOLDER_NAME = holder_name
					_IMAGE_PROPERTY_LABEL = img_prop_name
					_ARRAY_LENGTH = _IMAGES_ARRAY.length-1
					_ARRAY_COUNTER = 0
					
					_ON_COMPLETE_FUNC = onItemCompleteFunc
					_ON_TOTAL_COMPLETE_FUNC = onTotalCompleteFunc
					
					var firstElement = _IMAGES_ARRAY[_ARRAY_COUNTER]
					
					_CURRENT_ITEM = firstElement
					
					var loader = new Loader();
					
					request = new URLRequest(firstElement[_IMAGE_PROPERTY_LABEL]);
					
					configureMultipleListeners(loader.contentLoaderInfo);
					
					loader.load(request);
					
					firstElement[_HOLDER_NAME].addChild(loader);
				}
				else
				{
					throw new Error("Load ::: ImagesArray ::: A HOLDER NAME (movielip) MUST BE PROVIDED")
				}
			}
			else
			{
				throw new Error("Load ::: ImagesArray ::: AN IMAGE PROPERTY NAME MUST BE PROVIDED")
			}	
        }
		
		public static function loopImageArrayLoader():void
		{
			_ARRAY_COUNTER++
			
			if (_ARRAY_COUNTER <= _ARRAY_LENGTH)
			{
				var newElement = _IMAGES_ARRAY[_ARRAY_COUNTER]
				
				if (newElement != null) 
				{
					_CURRENT_ITEM = newElement
					
					var loader = new Loader();
					
					request = new URLRequest(newElement[_IMAGE_PROPERTY_LABEL]);
					
					configureMultipleListeners(loader.contentLoaderInfo);
					
					loader.load(request);
					
					newElement[_HOLDER_NAME].addChild(loader);
				}
			}
			else
			{
				if (_ON_TOTAL_COMPLETE_FUNC != null) 
				{
					_ON_TOTAL_COMPLETE_FUNC()
				}
			}
		}
		
		////////////////////////////////////////////////////// LISTENERS - SINGLE
		
        public static function configureListeners(dispatcher:IEventDispatcher):void 
		{
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        }
		
		////////////////////////////////////////////////////// LISTENERS - MULTIPLE
		
        public static function configureMultipleListeners(dispatcher:IEventDispatcher):void 
		{
            dispatcher.addEventListener(Event.COMPLETE, completeMultipleHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusMultipleHandler);
            dispatcher.addEventListener(Event.INIT, initMultipleHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorMultipleHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressMultipleHandler);
        }
		
		////////////////////////////////////////////////////// RESULTS - SINGLE
		
        public static function completeHandler(event:Event):void
		{
            trace("completeHandler: " + event);
        }
		
        public static function httpStatusHandler(event:HTTPStatusEvent):void
		{
            //trace("httpStatusHandler: " + event);
        }
		
        public static function initHandler(event:Event):void
		{
			_SINGLELOAD_RESULTFUNC(_SINGLELOAD_MC)
        }
		
        public static function ioErrorHandler(event:IOErrorEvent):void 
		{
            //trace("ioErrorHandler: " + event);
        }
		
        public static function progressHandler(event:ProgressEvent):void 
		{
            //trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }
		
		////////////////////////////////////////////////////// RESULTS - MULTIPLE
		
        public static function completeMultipleHandler(event:Event):void
		{
            //trace("completeHandler: " + event);
        }
		
        public static function httpStatusMultipleHandler(event:HTTPStatusEvent):void
		{
            //trace("httpStatusHandler: " + event);
        }
		
        public static function initMultipleHandler(event:Event):void
		{
			_ON_COMPLETE_FUNC(_CURRENT_ITEM)
			
			loopImageArrayLoader()
        }
		
        public static function ioErrorMultipleHandler(event:IOErrorEvent):void 
		{
            //trace("ioErrorHandler: " + event);
        }
		
        public static function progressMultipleHandler(event:ProgressEvent):void 
		{
            //trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }
		
		////////////////////////////////////////////////////// END OF CLASS
	}	
}