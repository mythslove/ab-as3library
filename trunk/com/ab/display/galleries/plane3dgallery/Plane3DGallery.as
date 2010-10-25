package com.ab.display.galleries.plane3dgallery 
{
	/**
	* @author ABº
	* 
	* this class is not ready for general purpose usage, still needs to be adapted to work easily with any project
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.events.ItemEvent;
	import com.ab.events.CentralEventSystem;
	import com.ab.utils.Get;
	import com.ab.utils.Make;
	import com.edigma.ui.tapscroller.TapScroller;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import hype.extended.layout.GridLayout;
	import org.casalib.display.CasaSprite;
	import org.casalib.util.RatioUtil;
	import org.casalib.util.StageReference;
	import net.guttershark.managers.LayoutManager;
	
	public class Plane3DGallery extends CasaSprite
	{
		public var has_vid:Boolean
		
		private var _data:Array = new Array();
		// how many image covers
		private var _itemsTotal:Number;
		private var _items_init_width:Number;
		private var _items_init_height:Number;
		private var _columns:int=4;
		
		private var _xml_file:String;
		private var _texto:String;
		private var _title:String;
		public var holder_mc:MovieClip;
		private var holder_inside_holder_mc:MovieClip;
		private var _items:Array;
		
		//Guttershark layout manager
		protected var lm:LayoutManager;
		private var _items_per_page:int;
		private var _items_spacing:Number;
		private var _item_select_listener_active:Boolean=true;
		public var closing:Boolean=false;
		
		public function Plane3DGallery() 
		{
			_items 	= new Array();
			
			this.cacheAsBitmap = true;
			
			_item_select_listener_active = true;
			
			this.addEventListener(Event.ADDED_TO_STAGE, 	addedHandler, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler, false, 0, true);
			
			StageReference.getStage().addEventListener(Event.RESIZE, resizeHandler, false, 0, true);
			
			CentralEventSystem.singleton.addEventListener(ItemEvent.SELECT, selectItemEventListener, false, 0, true);
		}
		
		private function selectItemEventListener(e:ItemEvent):void 
		{
			if (e.data == "select_plane3d_item")
			{
				closing = true;
				
				if (this.hasEventListener(Event.ENTER_FRAME)) 
				{
					this.removeEventListener(Event.ENTER_FRAME, 	enterFrameHandler);
				}
				
				StageReference.getStage().removeEventListener(Event.RESIZE, resizeHandler);
				
				CentralEventSystem.singleton.removeEventListener(ItemEvent.SELECT, selectItemEventListener);
				
				if (_item_select_listener_active == true)
				{
					_item_select_listener_active = false;
				}
			}
		}
		
		private function resizeHandler(e:Event):void 
		{
			checkSizeAndPosition();
		}
		
		private function checkSizeAndPosition():void
		{
			if (closing != true) 
			{
				Tweener.addTween(holder_mc, { x:StageReference.getStage().stageWidth / 2, y: StageReference.getStage().stageHeight / 2, transition:"EaseOutQuad", time:1 } );
				
				var stage_height:Number = StageReference.getStage().stageHeight;
				var stage_width:Number  = StageReference.getStage().stageWidth;
				var padding:Number 		= stage_height / 4;
				
				var thisSize:Rectangle 	= new Rectangle(0, 0, holder_mc.width, holder_mc.height);
				var bounds:Rectangle   	= new Rectangle(0, 0, stage_width - padding, stage_height - padding);
				
				var result:Rectangle  	= RatioUtil.scaleToFit(thisSize, bounds);
				
				if (holder_mc.width != result.width || holder_mc.height != result.height) 
				{
					Tweener.addTween(holder_mc, { width:result.width, height:result.height, transition:"Linear", time:1 } );
				}
			}
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			loadThumbnails();
		}
		
		
		private function loadThumbnails():void
		{
			var num_items:int = _items.length;
			
			for each (var s in _items)  { num_items++; };
			
			holder_mc 				= new MovieClip();
			holder_inside_holder_mc = new MovieClip();
			
			this.addChild(holder_mc);
			holder_mc.addChild(holder_inside_holder_mc);
			
			var layout:GridLayout = new GridLayout(0, 0, _items_init_width + _items_spacing, _items_init_height + _items_spacing, _columns);
			
			for (var i:int = 0; i < _items.length; i++) 
			{
				if (i < _items_per_page) 
				{
					holder_inside_holder_mc.addChild(Plane3DItem(_items[i]));
					
					Plane3DItem(_items[i]).index = i;
					
					layout.applyLayout(Plane3DItem(_items[i]));
				}
				
				Plane3DItem(_items[i]).alpha = 0;
				Plane3DItem(_items[i]).init_y 	= Plane3DItem(_items[i]).y;
				Plane3DItem(_items[i]).y 		= Plane3DItem(_items[i]).init_y - 200 ;
				
				if (i != _items.length-1) 
				{
					Tweener.addTween(Plane3DItem(_items[i]), { y:Plane3DItem(_items[i]).init_y, alpha:1, time:0.8, delay:0.1 * i } );
				}
				else
				{
					Tweener.addTween(Plane3DItem(_items[i]), { y:Plane3DItem(_items[i]).init_y, alpha:1, time:0.8, delay:0.1 * i, onComplete:checkSizeAndPosition } );
				}
			}
			
			
			holder_mc.x = StageReference.getStage().stageWidth / 2;
			holder_mc.y = StageReference.getStage().stageHeight / 2;
			
			holder_inside_holder_mc.x 	= -holder_inside_holder_mc.width/2;
			holder_inside_holder_mc.y 	= -holder_inside_holder_mc.height/2;
			
			holder_mc.cacheAsBitmap = true;
			holder_inside_holder_mc.cacheAsBitmap = true;
			
			//checkSizeAndPosition()
			
			start3Dpositioning();
			
			///lm = new LayoutManager(holder_inside_holder_mc);
		}
		
		private function start3Dpositioning():void
		{
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
		}
		
		public function closeAllItems():void
		{
			for (var i:int = 0; i < _items.length; i++)  { _items[i].startClose(); }
		}
		
		public function closeAndRecallFunction(recall_func:Function):void
		{
			for (var i:int = 0; i < _items.length; i++)  { _items[i].startClose(); }
		}
		
		public function itemClickHandler(item:Plane3DItem):void 
		{
			lm.bringToFront(item);
		}
		
		private function rollOverHandler(e:MouseEvent):void 
		{
			holder_mc.removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			var valueX:Number = (StageReference.getStage().mouseY - (StageReference.getStage().stageHeight/2)) / 5;
			var valueY:Number = (StageReference.getStage().mouseX - (StageReference.getStage().stageWidth/2)) / 5;
			
			valueX = valueX * ( -1);
			
			if (valueX > 0)			{ valueX = 0;  };
			if (valueX < -20)		{ valueX = -20; };
			
			if (valueY > 20)		{ valueY = 20;  };
			if (valueY < -20)		{ valueY = -20; };
			
			if (holder_mc.rotationX != valueX || holder_mc.rotationY != valueY) 	
			{ 
				//Tweener.removeTweens(holder_mc)
				Tweener.addTween(holder_mc, { rotationX: valueX, time:1.5 } ); 
				Tweener.addTween(holder_mc, { rotationY: valueY, time:1.5 } );
			}
		}
		
		public function get texto():String 							{ return _texto;  };
		public function set texto(value:String):void  				{ _texto = value; };
		
		public function get title():String 							{ return _title;  };
		public function set title(value:String):void  				{ _title = value; };
		
		public function get items():Array 							{ return _items;  };
		public function set items(value:Array):void  				{ _items = value; };
		
		public function get items_init_width():Number 				{ return _items_init_width; }
		public function set items_init_width(value:Number):void 	{ _items_init_width = value; }
		
		public function get items_init_height():Number 				{ return _items_init_height; }
		public function set items_init_height(value:Number):void  	{ _items_init_height = value; }
		
		public function get items_per_page():int 					{ return _items_per_page; }
		public function set items_per_page(value:int):void  		{ _items_per_page = value; }
		
		public function get items_spacing():Number 					{ return _items_spacing; }
		public function set items_spacing(value:Number):void		{ _items_spacing = value; }
		
		public function get columns():int 							{ return _columns; }
		public function set columns(value:int):void  				{ _columns = value; }
		
		private function removedHandler(e:Event):void 
		{
			if (_item_select_listener_active == true)
			{
				CentralEventSystem.singleton.removeEventListener(ItemEvent.SELECT, selectItemEventListener);
				
				_item_select_listener_active = false;
			}
			
			StageReference.getStage().removeEventListener(Event.RESIZE, resizeHandler);
			
			if (this.hasEventListener(Event.ENTER_FRAME)) 
			{
				this.removeEventListener(Event.ENTER_FRAME, 	enterFrameHandler);
			}
			
			this.removeEventListener(Event.REMOVED_FROM_STAGE, 	removedHandler);
		}
		
	}
	
}


				/*
				var newitem 			= new Plane3DItem();
				newitem.target 			= this;
				newitem.index 			= i;
				newitem.fullimage 		= _data[i].fullimage;
				newitem.image 			= _data[i].image;
				newitem.title 			= _data[i].title;
				newitem.text 			= _data[i].text;
				*/