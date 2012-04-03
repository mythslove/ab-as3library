package com.ab.display.galleries.touchgallery 
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.utils.Make;
	import com.edigma.display.Image
	import flash.display.MovieClip;
	import flash.events.Event;
	import gs.dataTransfer.XMLManager;
	import org.casalib.display.CasaMovieClip;
	import org.casalib.display.CasaSprite;
	 
	import com.ab.display.galleries.touchgallery.TouchGalleryItem
	
	public class TouchGallery extends CasaMovieClip
	{
		private var _DATA:Array;
		private var _LOAD_COUNT:Number = 0;
		private var _ITEMS_ARRAY:Array;
		private var Ready:Number = 0;
		private var _locked:Boolean = false;
		private var _counter:Number = 0;
		public var click = false;
		public var holder_mc:MovieClip
		public var _HORIZONTAL_SIZE:Number=1024;
		public var _VERTICAL_SIZE:Number=1024;
		public var _LAST_DRAGGED:TouchGalleryItem=null;
		public var _OPENED_ITEM:TouchGalleryItem=null;
		
		public function TouchGallery()
		{
			/// call start()
			
			initVars()
		}
		
		private function initVars():void
		{
			_DATA 		 = new Array()
			_ITEMS_ARRAY = new Array()
		}
		
		public function start()
		{
			//trace ("TouchGallery ::: start()"); 
			
			createThumbs();
			resize();
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true)
		}
		
		public function closeAnyOpenItem()
		{
			for (var i:int = 0; i < _ITEMS_ARRAY.length; i++) 
			{
				if (_ITEMS_ARRAY[i]._OPENED == true) 
				{
					_ITEMS_ARRAY[i].closePhoto();
				}
			}
		}
		
		public function get DATA():Array 						{ return _DATA; 			}
		public function set DATA(value:Array):void  			{ _DATA = value; 			}
		
		public function get VERTICAL_SIZE():Number 				{ return _VERTICAL_SIZE;    }
		public function set VERTICAL_SIZE(value:Number):void  	{ _VERTICAL_SIZE = value;   }
		
		public function get HORIZONTAL_SIZE():Number 			{ return _HORIZONTAL_SIZE;  }
		public function set HORIZONTAL_SIZE(value:Number):void  { _HORIZONTAL_SIZE = value; }
		
		public function get locked():Boolean 					{ return _locked; 			}
		public function set locked(value:Boolean):void  		{ _locked = value; 			}
		
		public function get ITEMS_ARRAY():Array 				{ return _ITEMS_ARRAY; 		}
		public function set ITEMS_ARRAY(value:Array):void  		{ _ITEMS_ARRAY = value; 	}
		
		private function createThumbs() 
		{
			for (var i:int = 0; i < _DATA.length; i++) 
			{
				var newslide:TouchGalleryItem = new TouchGalleryItem(this);
				
				newslide.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true)
				
				newslide.imagepath = _DATA[i]; 
				
				//trace ("TouchGallery ::: _DATA[i] = " + _DATA[i] ); 
				
				newslide.x = (_HORIZONTAL_SIZE / 2) - newslide.height / 2
				newslide.y = (_HORIZONTAL_SIZE / 2) - newslide.width / 2
				
				this.addChild(newslide)
				
				newslide.alpha = 0;
				
				_ITEMS_ARRAY.push(newslide)
				
				/// TODO: mc.thumbholder_mc.scaleTo(41.5);
			}
			
			/// TODO: this["Thumb" + _LOAD_COUNT + "_mc"].thumbholder_mc.colorTo(0xffffff);
			/// TODO: this["Thumb" + _LOAD_COUNT + "_mc"].scaleTo(100);
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			var newimage = new Image(e.currentTarget.imagepath, imgLoadCompleteHandler);
			
			e.currentTarget.thumbholder_mc.addChild(newimage);
			
			newimage.load();
		}
		
		private function resize() 
		{
			//background_mc.width = _HORIZONTAL_SIZE; background_mc.height = _VERTICAL_SIZE;
			//mask_mc.width = _HORIZONTAL_SIZE; mask_mc.height = _VERTICAL_SIZE;
		}
		
		private function imgLoadCompleteHandler(my_mc:*):void
		{
			//trace ("TouchGallery ::: imgLoadCompleteHandler"); 
			
			var _width:Number = my_mc.width;
			var _height:Number = my_mc.height;
			
			if (_width > _height) 
			{
				my_mc.height = 149.4;
				my_mc.width = 199.2;
				
				TouchGalleryItem(my_mc.parent.parent).imageType = "horizontal";
			} 
			else 
			{
				TouchGalleryItem(my_mc.parent.parent).imageType = "vertical";
				
				my_mc.height 			= 199.2;
				my_mc.width 			= 149.4;
				//my_mc.rotation 			= +90;
				my_mc.x 				= my_mc.x - 149.4;
				my_mc.parent.rotation 	= -90;
			}
			
			Make.MCVisible(my_mc.parent.parent, 1, null, _counter * 0.1)
			
			_counter ++;
		}
		/*
		public function deactivateOtherItems(exception:TouchGalleryItem):void
		{
			for (var i:int = 0; i < _ITEMS_ARRAY.length; i++) 
			{
				if (_ITEMS_ARRAY[i] != exception) 
				{
					_ITEMS_ARRAY[i].removeEventListener(Event.ENTER_FRAME, _ITEMS_ARRAY[i].enterframeHandler);
				}
			}
		}
		
		public function reactivateOtherItems(exception:TouchGalleryItem):void
		{
			for (var i:int = 0; i < _ITEMS_ARRAY.length; i++) 
			{
				if (_ITEMS_ARRAY[i] != exception) 
				{
					_ITEMS_ARRAY[i].addEventListener(Event.ENTER_FRAME, _ITEMS_ARRAY[i].enterframeHandler, false, 0, true);
				}
			}
		}
		*/
		public function close() 
		{
			_DATA = null;
			
			//delete _DATA;
			
			for (var i:int = 0; i < _ITEMS_ARRAY.length; i++) 
			{
				_ITEMS_ARRAY[i].destroy();
				
				delete _ITEMS_ARRAY[i];
				
				_ITEMS_ARRAY[i] = null;
			}
			
			//delete _ITEMS_ARRAY;
			
			_ITEMS_ARRAY = null;
			
			destroy()
		}
		
		private function removedFromStageHandler(e:Event):void 
		{
			//delete _ITEMS_ARRAY;
			
			_ITEMS_ARRAY = null;
		}
	}
	
}