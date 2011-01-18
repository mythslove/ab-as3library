package com.ab.paging 
{
	/**
	* @author AB
	*/
	
	import com.ab.events.CentralEventSystem;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class CirclesPaging extends Sprite
	{
		/// sys vars
		private var _items:Array = new Array();
		private var _num_pages:int;
		private var _selected_index:int;
		private var _circles_size:int = 8;
		private var _item_spacing:int = 8;
		private var _select_function:Function;
		private var _selected_page:int;
		
		/// visual assets
		private var _visuals_holder:Sprite;
		private var visuals_holder:Sprite;
		
		public function CirclesPaging() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			stage.addEventListener(Event.RESIZE, resizeHandler, false, 0, true);
			
			_visuals_holder = new Sprite()
			
			for (var i:int = 0; i < _num_pages; i++) 
			{
				var newitem:CirclesPagingItem = new CirclesPagingItem();
				
				newitem.page 			= i + 1;
				newitem.select_function = _select_function;
				newitem.host 			= this;
				newitem.x 				= (_circles_size + _item_spacing) * i;
				
				if (i == 0) 
				{
					newitem.selected 	= true;
				}
				
				_visuals_holder.addChild(newitem);
				
				_items.push(newitem);
			}
			
			this.addChild(_visuals_holder);
			
			this.x 				= stage.stageWidth  / 2;
			this.y 				= stage.stageHeight - 90;
			_visuals_holder.x 	= -_visuals_holder.width  / 2;
			_visuals_holder.y 	= -_visuals_holder.height / 2;
			
			start();
		}
		
		private function resizeHandler(e:Event):void 
		{
			if (stage) 
			{
				this.x 				= stage.stageWidth  / 2;
				this.y 				= stage.stageHeight - 90;
			}
			
			_visuals_holder.x 	= -_visuals_holder.width  / 2;
			_visuals_holder.y 	= -_visuals_holder.height / 2;
		}
		
		private function start():void
		{
			
		}
		
		private function activatePage(num:int):void
		{
			deactivateAllPagesExcept(num);
		}
		
		private function deactivateAllPagesExcept(num:int):void 
		{
			for (var i:int = 0; i < _items.length; i++) 
			{
				if (i != num) 
				{
					_items[i].deactivate();
				}
			}
		}
		
		public function get num_pages():int 			{ return _num_pages; }
		public function set num_pages(value:int):void  	{ _num_pages = value; }
		
		public function get select_function():Function 	{ return _select_function; }
		public function set select_function(value:Function):void 
		{
			_select_function = value;
		}
		
		public function get selected_page():int { return _selected_page; }
		public function set selected_page(value:int):void 
		{
			_selected_page = value;
			
			for (var i:int = 0; i < _items.length; i++) 
			{
				if (CirclesPagingItem(_items[i]).page == value)
				{
					CirclesPagingItem(_items[i]).selected = true;
				}
				else
				{
					CirclesPagingItem(_items[i]).selected = false;
				}
			}
		}
		
	}

}