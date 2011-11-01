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
package com.bumpslide.ui {
	import flash.system.LoaderContext;	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;
	
	import com.bumpslide.net.LoaderQueue;
	import com.bumpslide.tween.FTween;
	import com.bumpslide.ui.Component;
	import com.bumpslide.util.ImageUtil;		

	/**
	 * Image Loader Component that handles resizing and cropping
	 * 
     * @author David Knape
     */
    public class Image extends Component {
        
        // Events...
        public static const EVENT_LOADED:String = "onImageLoaded";
        public static const EVENT_ERROR:String = "onImageError";
        public static const EVENT_PROGRESS:String = "onImageProgress";
		
		private static const COLOR_ERROR:Number = 0xDF665A;		// error
		private static const COLOR_ENQUEUED:Number = 0xF2A044;    // enqueued
		private static const COLOR_PROGRESS:Number = 0xF9D575;     // in progress
		private static const COLOR_LOADED:Number = 0x82B4C4;      // loaded
		private static const COLOR_UNLOADED:Number = 0x253C4B;      // loaded
		
		// Scale Modes...
		
		// Crop to fill height and width
		public static const SCALE_CROP:String = "crop";		
		// resize to height and width, but preserve aspect ratio
		public static const SCALE_RESIZE:String = "resize";		
		// no resize, height and width will always be that of loaded image
		public static const SCALE_NONE:String = "none";
		
		// Shared Loading Queue
		private static var _loadingQueue:LoaderQueue = new LoaderQueue(); 
		
		// private
		protected var _status:Box;
		protected var _bitmap:Bitmap; 
        protected var _loader:Loader;
        protected var _url:String=null;
        protected var _imageLoaded:Boolean = false;
        protected var _scaleMode:String = SCALE_NONE;
		protected var _fadeOnLoad:Boolean = false;
		protected var _fadeEasingFactor:Number = .2;
		private var _constructorArgs:Array;
		
		// loader context used to load url's
		public var loaderContext:LoaderContext=null;
		static public function get queue() : LoaderQueue {
			return _loadingQueue;
		}
		
		static public function clearQueue() : void {
			queue.clear();
		}
		
		
		public function Image(image_url:String=null, scale_mode:String=SCALE_NONE, w:Number=-1, h:Number=-1, loadCompleteHandler:Function=null) {
			_constructorArgs = arguments;
			super();
		}
		
		override protected function addChildren() : void {
            // create image _loader, setup on_imageLoaded listener, add to stage
            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(Event.INIT, onImageLoaded, false, 0, true );
            _loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onImageProgress, false, 0, true);
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onImageError, false, 0, true);
            addChild(_loader);
                           
            _status = new Box(COLOR_UNLOADED, 8, 8, 2, 2, 3 );
            addChild( _status );
            
        	url = _constructorArgs[0];
        	scaleMode = _constructorArgs[1];
        	width = _constructorArgs[2];
        	height = _constructorArgs[3];
        	
        	var loadCompleteHandler:Function = _constructorArgs[4];
        	if(loadCompleteHandler!=null) {
        		addEventListener(EVENT_LOADED, loadCompleteHandler, false, 0, true );
        	}
        	updateDelay = 0;
        	
        	super.addChildren();
        }
        
		override public function destroy():void {
			if(_constructorArgs[4]) { removeEventListener(EVENT_LOADED, _constructorArgs[4]); }
			if(_loader) {
				_loader.contentLoaderInfo.removeEventListener(Event.INIT, onImageLoaded );
            	_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onImageProgress);
            	_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onImageError);
			}
			unload();
			destroyChild( _loader );
			_loader = null;			
			super.destroy();
		}
		
		override protected function draw() : void {
			
        	_status.visible = (debugEnabled);
        	
        	if(loaded) {
        		if(!image.visible) {
        			image.alpha = 0;
        			image.visible = true;
        			if(fadeOnLoad) FTween.ease(image, 'alpha', 1, _fadeEasingFactor);
        			else image.alpha = 1;
        		}
        		if(_url!='bytes' && imageBitmap!=null) {
        			imageBitmap.smoothing = true;
        		} 
        		switch( scaleMode ) {
        			case SCALE_CROP: 	ImageUtil.crop( image, _width, _height); break;
        			case SCALE_RESIZE:	ImageUtil.resize( image, _width, _height, true ); break;        				
        		}   	
            } else {
            	if(image!=null) FTween.stopTweening(image, 'alpha');
            }
            super.draw();
		}
		
		public function get image () : DisplayObject {
			if(_bitmap!=null) return _bitmap;
			else return _loader;
		}

		public function get imageBitmap() : Bitmap {
        	if(loaded) {
        		if(_url!=null) return _loader.content as Bitmap;
        		else return _bitmap; 
        	} else {
        		return null;
        	}
        }
		
        /**
         * Load the image
         */        
        public function load( image_url:String, priority:int=1):Boolean {        
            if(image_url==_url) return false;
            unload();
           	_url = image_url;           	        
            if(_url!=null) { 
            	debug('loading image ' + _url);
            	_status.color = COLOR_ENQUEUED;
				_loadingQueue.load( _url, _loader, priority, loaderContext );
                //_loader.load( new URLRequest( _url ), new LoaderContext( true ));
                return true;
            }               
            return false; 
        }
        
        /**
         * Load the image
         */        
        public function loadBytes( data:ByteArray ):Boolean {
           	unload();
           	_url = 'bytes';
           	_loader.loadBytes( data );
           	//onImageLoaded();
           	return true;
        }
        
        
        /**
         * Attach image from bitmap
         */        
        public function attach( bmp:Bitmap ):void {        
            unload();
            _bitmap = bmp;
            if(_bitmap!=null) {
            	addChild(_bitmap);
            	onImageLoaded();
            } else {
            	sendEvent( EVENT_ERROR, "Invalid Bitmap" ); 
            }           	  
        }
                        
        /**
         * Once image is loaded, display it
         */
        private function onImageLoaded(e:Event=null):void {   
        	debug('image loaded');
        	_status.color = COLOR_LOADED;
        	loaded = true;         	
            updateNow();
            sendEvent( EVENT_LOADED, _url);           
        }
        
        /**
         * Progress Handler
         */
        private function onImageProgress(e:ProgressEvent=null):void {    
        	_status.color = COLOR_PROGRESS;
            sendEvent( EVENT_PROGRESS, e.bytesLoaded/e.bytesTotal );           
        }
        
        /**
         * Error handler
         */
        private function onImageError(e:IOErrorEvent=null):void {    
        	debug('onImageError ' + e.text );
            sendEvent( EVENT_ERROR, e.text );  
            _status.color = COLOR_ERROR;         
        }
        
        /**
         * Unload image
         **/
        public function unload () : void {            
            // hide
             //visible = false;
            loaded = false;
            _url = null;
            if(image!=null) {
            	FTween.stopTweening(image);
            	image.alpha = 0;
            	image.visible = false;
            }
            _loadingQueue.cancel(_loader);
            // unload
            //try { _loader.close(); } catch ( e:Error ) {}
            //try { _loader.unload(); } catch ( e2:Error ) {}
            
            if(_bitmap!=null && contains(_bitmap)) removeChild(_bitmap);   
            
            _status.color = COLOR_UNLOADED;         
		}
		
		//-------------------------------
		// GETTERS and SETTERS
		//-------------------------------
		

		public function get scaleMode():String {
			return _scaleMode;
		}
		
		public function set scaleMode(mode:String):void {
			_scaleMode = mode;
			invalidate();
		}

		override public function get width():Number {
			return (loaded && scaleMode!=SCALE_CROP ) ? image.width : _width;
		}		

		override public function get height():Number {
			return (loaded && scaleMode!=SCALE_CROP ) ? image.height : _height;
		}
		
		public function get loaded () :Boolean {
			return _imageLoaded;
		}
		
		public function set loaded ( val:Boolean ) :void {
			if(val==_imageLoaded) return;
			_imageLoaded = val;
			sendChangeEvent( 'loaded', val );
		}
		
		public function get fadeOnLoad() : Boolean {
			return _fadeOnLoad;
		}

		public function set fadeOnLoad(fadeIn : Boolean) : void {
			_fadeOnLoad=fadeIn;
		}
		
		public function get fadeEasingFactor():Number {
			return _fadeEasingFactor;
		}
		
		public function set fadeEasingFactor(fadeEasingFactor:Number):void {
			_fadeEasingFactor = fadeEasingFactor;
		}
		
		public function get url() : String {
			return _url;
		}
		
		public function set url( image_url:String ):void {
			load(image_url);
		}
		
		public function get loader():Loader {
			return _loader;
		}
		
		public function get aspectRatio():Number {
			return width/height;
		}
	}
}
