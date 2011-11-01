package com.ab.display.galleries.plane3dgallery 
{
	/**
	* @author ABº
	* 
	* this class is not ready for general purpose usage, still needs to be adapted to work easily with any project
	* 
	* 
	* to instantiate a Plane3DGallery:
	* 
	* /// create items
	* for (var i:int = 0; i < _data._total; i++) 
	* {
	* 			var newitem:Plane3DItem = new Plane3DItem();
	* 			newitem.w 				= 190;
	* 			newitem.h 				= 135;
	* 			newitem.id_item 		= _data.id_item[i];
	* 			newitem.text 			= _data["c" + idc + "_titulo"][i];
	* 			newitem.image   		= path_to_image;
	* 			newitem.page 			= Math.floor(item_counter / items_per_page) 
	* 			
	* 			newitem.click_function 	= itemClickHandler;
	* 			newitem.on_roll_over	= itemRollOverHandler;
	* 			newitem.on_roll_out		= itemRollOutHandler;
	* 			
	* 			items.push(newitem);
	* 	}
	* 
	* 
	* /// create plane3dgallery
	* gallery = new Plane3DGallery();
	* 
	* /// feed images to plane3dgallery
	* gallery.items 			  	= items;
	* gallery.items_per_page    	= items_per_page;
	* gallery.items_spacing  	  	= 10;
	* gallery.items_init_width  	= 190;
	* gallery.items_init_height 	= 135;
	* //init_height
	* /// add plane3dgallery to stage
	* this.addChild(gallery);
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.events.CentralEventSystem;
	import com.ab.paging.CirclesPaging;
	import elements.DirectorioButton;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import hype.extended.layout.GridLayout;
	import net.guttershark.managers.LayoutManager;
	import org.casalib.display.CasaSprite;
	import org.casalib.util.StageReference;
	
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
		public var holder_mc:Sprite;
		private var holder_inside_holder_mc:MovieClip;
		private var holder_inside_holder2_mc:MovieClip;
		
		//Guttershark layout manager
		protected var lm:LayoutManager;
		private var _items_per_page:int=16;
		private var _items_spacing:Number;
		private var _item_select_listener_active:Boolean=true;
		public var closing:Boolean=false;
		private var voltar_btn:DirectorioButton;
		private var using_paging:Boolean = false;
		
		private var current_page:int=0;
		private var _pages:Array;
		//private var pages_array:Array 	= new Array();
		private var _items:Array;
		private var number_of_pages:Number;
		private var system_busy:Boolean=false;
		private var currently_visible_items:Array;
		public var aux:Number=0;
		
		public function Plane3DGallery() 
		{
			this.cacheAsBitmap = true;
			
			_pages 					= new Array();
			_items 					= new Array();
			currently_visible_items = new Array();
			
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
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			/// back button
			voltar_btn						= new DirectorioButton();
			voltar_btn.setAsBackButton();
			//btn.alpha						= 0;
			voltar_btn.x 					= 20;
			voltar_btn.y 					= stage.stageHeight - 70 - voltar_btn.height;
			
			this.addChild(voltar_btn);
			
			holder_mc 			= new Sprite();
			holder_mc.visible 	= true;
			holder_mc.alpha 	= 1;
			holder_mc.x 		= stage.stageWidth  / 2;
			holder_mc.y 		= (stage.stageHeight / 2) - 50;
			
			this.addChild(holder_mc);
			
			holder_inside_holder_mc  = new MovieClip();
			holder_inside_holder2_mc = new MovieClip();
			holder_mc.addChild(holder_inside_holder_mc);
			holder_mc.addChild(holder_inside_holder2_mc);
			
			createPaging();
			
			loadPage(1);
			
			start3Dpositioning();
		}
		
		private function createPaging():void 
		{
			number_of_pages = Math.ceil(_items.length / _items_per_page);
			
			if (number_of_pages > 1) 
			{
				using_paging = true;
				
				var paging:CirclesPaging 	= new CirclesPaging();
				paging.num_pages 			= Math.ceil(_items.length / _items_per_page);
				paging.select_function 		= pagingSelectHandler;
				
				this.addChild(paging);
			}
		}
		
		private function loadPage(page_number:int=1):void
		{
			// if new page > current_page, items fly left;
			// if new page < current_page, items fly right;
			
			var new_items_come_from:String;
			
			if (page_number > current_page) 
			{
				new_items_come_from = "right";
			}
			else if (page_number < current_page)
			{
				new_items_come_from = "left";
			}
			
			var layout:GridLayout = new GridLayout(0, 0, _items_init_width +  _items_spacing, _items_init_height +  _items_spacing, _columns);
			
			var newitemsarray:Array = new Array();
			var items_counter:int = 0;
			var items_amount:Number = 0;
			
			for (var z:int = 0; z < _items.length; z++)
			{
				if (Plane3DItem(_items[z]).page == page_number)
				{
					items_amount++;
				}
			}
			
			
			for (var i:int = 0; i < _items.length; i++)
			{
				if (Plane3DItem(_items[i]).page == page_number)
				{
					// clone desired item
					var newplane3ditem:Plane3DItem 	= new Plane3DItem();
					newplane3ditem.visible 			= false;
					newplane3ditem.index 			= items_counter;
					newplane3ditem.items_in_page	= items_amount;
					newplane3ditem.w 	 			= Plane3DItem(_items[i]).w;
					newplane3ditem.h 	 			= Plane3DItem(_items[i]).h;
					newplane3ditem.id_item 			= Plane3DItem(_items[i]).id_item;
					newplane3ditem.text 			= Plane3DItem(_items[i]).text;
					newplane3ditem.image 			= Plane3DItem(_items[i]).image;
					newplane3ditem.page				= Plane3DItem(_items[i]).page;
					
					newplane3ditem.click_function 	= Plane3DItem(_items[i]).click_function;
					newplane3ditem.on_roll_over		= Plane3DItem(_items[i]).on_roll_over;
					newplane3ditem.on_roll_out		= Plane3DItem(_items[i]).on_roll_out;
					
					items_counter++;
					
					holder_inside_holder_mc.addChild(newplane3ditem);
					
					layout.applyLayout(newplane3ditem);
					
					newplane3ditem.init_x = newplane3ditem.x;
					newplane3ditem.init_y = newplane3ditem.y;
					
					newitemsarray.push(newplane3ditem);
				}
				
				current_page = page_number;
			}
			
			holder_inside_holder_mc.scaleX 	= 0.8;
			holder_inside_holder_mc.scaleY 	= 0.8;
			
			holder_inside_holder_mc.x 		= -(holder_inside_holder_mc.width  / 2);
			holder_inside_holder_mc.y 		= -(holder_inside_holder_mc.height / 2);
			
			for (var w:int = 0; w < newitemsarray.length; w++) 
			{
				var delay_amount:Number;
				
				if (new_items_come_from == "left") 
				{
					newitemsarray[w].x 	= -stage.stageWidth;
					delay_amount 		= 0.1 * (newplane3ditem.items_in_page - w);
				}
				else if (new_items_come_from == "right") 
				{
					newitemsarray[w].x 	= stage.stageWidth * 2;
					delay_amount 		= 0.1 * w;
				}
				
				newitemsarray[w].visible = true;
				Tweener.addTween(Plane3DItem(newitemsarray[w]), { x:Plane3DItem(newitemsarray[w]).init_x, alpha:1, time:0.8, delay:delay_amount } );
			}
			
			currently_visible_items = null;
			currently_visible_items = newitemsarray;
		}
		
		private function pagingSelectHandler(page:int):void 
		{
			if (page != current_page && system_busy != true)
			{
				// proibir momentaneamente a interacção
				system_busy = true;
				
				holder_inside_holder2_mc.x 			= holder_inside_holder_mc.x;
				holder_inside_holder2_mc.y 			= holder_inside_holder_mc.y;
				holder_inside_holder2_mc.z 			= holder_inside_holder_mc.z;
				holder_inside_holder2_mc.scaleX		= holder_inside_holder_mc.scaleX;
				holder_inside_holder2_mc.scaleY		= holder_inside_holder_mc.scaleY;
				holder_inside_holder2_mc.rotationX 	= holder_inside_holder_mc.rotationX;
				holder_inside_holder2_mc.rotationY 	= holder_inside_holder_mc.rotationY;
				
				// mandar os items activos co caralho
				for (var i:int = 0; i < currently_visible_items.length; i++) 
				{
					holder_inside_holder2_mc.addChild(currently_visible_items[i]);
					
					Plane3DItem(currently_visible_items[i]).close(page);
				}
				
				// fazer tempo e chamar nova pagina
				aux = 0;
				Tweener.addTween(this, { aux:1, time:1, transition:"Linear", onComplete:recallLoadPage, onCompleteParams:[page] } );
			}
		}
		
		private function recallLoadPage(page_array:*):void 
		{
			system_busy = false;
			
			loadPage(page_array);
		}
		
		private function getAllItemsFromPage(page_number:int):Array
		{
			var return_array:Array = new Array ();
			
			for (var j:int = 0; j < _items.length; j++) 
			{
				if (Plane3DItem(_items[j]).page == page_number) { return_array.push(_items[j]) };
			}
			
			return return_array;
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
		public function set items(value:Array):void  				
		{ 
			_items = value;
		}
		
		private function resizeHandler(e:Event):void 
		{
			checkSizeAndPosition();
		}
		
		private function checkSizeAndPosition():void
		{
			if (closing != true) 
			{
				Tweener.addTween(holder_mc, { 
												x:stage.stageWidth  / 2, 
												y: (stage.stageHeight / 2) - 50, 
												transition:"EaseOutQuad", time:1 } );
				
				Tweener.addTween(holder_mc, { rotationX: 0, time:0.5, transition:"Linear" } ); 
				Tweener.addTween(holder_mc, { rotationY: 0, time:0.5, transition:"Linear" } );
				
				if (voltar_btn)  { voltar_btn.y = stage.stageHeight - 70 - voltar_btn.height; };
			}
		}
		
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