package com.ab.display.galleries.plane3dgallery 
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.display.ABSprite;
	import com.ab.display.geometry.PolygonQuad;
	import com.ab.events.CentralEventSystem;
	import com.bumpslide.ui.Image;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Plane3DItem extends ABSprite
	{
		/// data
		private var _id_item:int;
		private var _index:Number;
		private var _title:String;
		private var _text:String;
		private var _image:String;
		private var _fullimage:String;
		private var _target:Plane3DGallery;
		
		/// measures
		private var _max_width:Number  	= 129;
		private var _max_height:Number 	= 86;
		private var _frame_size:Number 	= 5;
		private var _w:Number  			= 129;
		private var _h:Number 			= 86;
		
		/// external handlers
		private var _click_function:Function;
		private var _on_roll_over:Function;
		private var _on_roll_out:Function;
		
		/// sys
		public var frame:PolygonQuad;
		public var init_y:Number;
		public var init_x:Number;
		private var _image_display_object:Image;
		private var _selected_frame:MovieClip;
		private var _roll_over_frame:MovieClip;
		private var _selected:Boolean 	= false;
		private var closing:Boolean 	= false;
		private var _item_select_listener_active:Boolean;
		private var _page:int;
		private var _items_in_page:int;
		
		
		public function Plane3DItem() 
		{
			_item_select_listener_active 	= true;
			
			this.addEventListener(Event.ADDED_TO_STAGE, 	addedHandler, 	false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler, false, 0, true);
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			this.buttonMode 	= true;
			this.mouseChildren 	= false;
			frame = new PolygonQuad(_w, _h, 0xffffff);
			
			_image_display_object = new Image(_image, Image.SCALE_CROP, _w - frame_size * 2, _h - frame_size * 2);
			
			_image_display_object.fadeOnLoad = true;
			
			_image_display_object.x = frame_size;
			_image_display_object.y = frame_size;
			
			this.addChildAt(frame, 0);
			this.addChildAt(_image_display_object, 1);
			
			frame.alpha = 1;
			
			this.addEventListener(MouseEvent.ROLL_OUT, 	itemRollOutHandler, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OVER, itemRollOverHandler, false, 0, true);
			
			CentralEventSystem.singleton.addEventListener(ItemEvent.SELECT, selectItemEventListener, false, 0, true);
		}
		
		/// FRAME EFFECT
		/// FRAME EFFECT
		/// FRAME EFFECT
		
		private function itemRollOverHandler(e:MouseEvent):void { litFrame();   }
		private function itemRollOutHandler(e:MouseEvent):void  { unlitFrame(); }
		
		private function unlitFrame():void 		
		{ 
			Tweener.removeTweens(frame);
			Tweener.addTween(frame, { alpha:1, _color:0xffffff, _Glow_blurX:0,  _Glow_blurY:0,  _Glow_quality:15, _Glow_color:0x009900, time:2 } ); 
		}
		
		private function litFrame():void		
		{
			Tweener.removeTweens(frame);
			Tweener.addTween(frame, { alpha:1, _color:0x009900, _Glow_blurX:5,  _Glow_blurY:5,  _Glow_quality:10, _Glow_color:0x009900, time:1 } ); 
		}
		
		/// CLICK HANDLER
		/// CLICK HANDLER
		/// CLICK HANDLER
		
		private function setUpClickHandler():void 
		{
			this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			_item_select_listener_active = false;
			
			if (click_function != null)  { click_function(this); };
			
			CentralEventSystem.singleton.removeEventListener(ItemEvent.SELECT, selectItemEventListener);
			
			CentralEventSystem.singleton.dispatchEvent(new ItemEvent(ItemEvent.SELECT, "select_plane3d_item"));
		}
		
		private function selectItemEventListener(e:ItemEvent):void 
		{
			if (e.data == "select_plane3d_item") { startClose(); };
		}
		
		/// EXTERNAL ROLL OVER / ROLL OUT
		/// EXTERNAL ROLL OVER / ROLL OUT
		/// EXTERNAL ROLL OVER / ROLL OUT
		
		private function setUpRollOver():void 
		{
			this.addEventListener(MouseEvent.ROLL_OVER, callExternalRollOverHandler, false, 0, true );
		}
		
		private function callExternalRollOverHandler(e:MouseEvent):void
		{
			if (_on_roll_over != null)  { _on_roll_over(this); };
			
			litFrame();
		}
		
		private function setUpRollOut():void 
		{
			this.addEventListener(MouseEvent.ROLL_OUT, callExternalRollOutHandler, false, 0, true )
		}
		
		private function callExternalRollOutHandler(e:MouseEvent):void
		{
			if (_on_roll_out != null)  { _on_roll_out(); };
		}
		
		/// CLOSE FUNCTION
		/// CLOSE FUNCTION
		/// CLOSE FUNCTION
		
		public function close(new_page_number:Number):void
		{
			if (closing != true)
			{
				closing = true;
				
				var destination_x:Number;
				var delay_amount:Number;
				
				if (new_page_number > this.page ) 
				{
					destination_x = -stage.stageWidth;
					delay_amount  = this.index * 0.1;
				}
				else 
				{ 
					destination_x = stage.stageWidth + 200; 
					delay_amount  = (_items_in_page - this.index) * 0.1;
				}
				
				Tweener.addTween(this, { x:destination_x , alpha:0, transition:"EaseInCubic", time:0.5, delay:delay_amount, onComplete:destroy } );
			}
		}
		
		/// GETTERS / SETTERS
		
		public function get items_in_page():int 				{ return _items_in_page; }
		public function set items_in_page(value:int):void  		{ _items_in_page = value; }
		
		public function get target():Plane3DGallery 			{ return _target;  };
		public function set target(value:Plane3DGallery):void  	{ _target = value; };
		
		public function get image():String 						{ return _image;  };
		public function set image(value:String):void  			{ _image = value; };
		
		public function get fullimage():String 					{ return _fullimage;  };
		public function set fullimage(value:String):void  		{ _fullimage = value; };
		
		public function get title():String 						{ return _title;  };
		public function set title(value:String):void  			{ _title = value; };
		
		public function get text():String 						{ return _text;  };
		public function set text(value:String):void  			{ _text = value; };
		
		public function get index():Number 						{ return _index;  };
		public function set index(value:Number):void  			{ _index = value; };
		
		public function get id_item():int 						{ return _id_item;  };
		public function set id_item(value:int):void  			{ _id_item = value; };
		
		public function get w():Number 							{ return _w;  };
		public function set w(value:Number):void  				{ _w = value; };
		
		public function get h():Number 							{ return _h;  };
		public function set h(value:Number):void  				{ _h = value; };
		
		public function get frame_size():Number 				{ return _frame_size;  };
		public function set frame_size(value:Number):void  		{ _frame_size = value; };
		
		public function get page():int 							{ return _page;  };
		public function set page(value:int):void  				{ _page = value; };
		
		public function get click_function():Function 			{ return _click_function;  };
		public function set click_function(value:Function):void { _click_function = value; setUpClickHandler() };
		
		public function get on_roll_over():Function 			{ return _on_roll_over;  };
		public function set on_roll_over(value:Function):void  	{ _on_roll_over = value; setUpRollOver() };
		
		public function get on_roll_out():Function 				{ return _on_roll_out;  };
		public function set on_roll_out(value:Function):void 	{ _on_roll_out = value; setUpRollOut() };
		
		/// WASTE DISPOSAL
		/// WASTE DISPOSAL
		/// WASTE DISPOSAL
		
		public function startClose():void
		{
			Tweener.addTween(this, { alpha:0, time:0.3, onComplete:destroy} );
		}
		
		private function removedHandler(e:Event):void 
		{
			removeListeners();
		}
		
		private function removeListeners():void 
		{
			if (_item_select_listener_active == true)
			{
				_item_select_listener_active = false;
				CentralEventSystem.singleton.removeEventListener(ItemEvent.SELECT, selectItemEventListener);
			}
			
			if (this.hasEventListener(MouseEvent.CLICK))  		{ this.removeEventListener(MouseEvent.CLICK, clickHandler); }
			if (this.hasEventListener(MouseEvent.ROLL_OVER))  	{ this.removeEventListener(MouseEvent.ROLL_OVER, callExternalRollOverHandler); }
			if (this.hasEventListener(MouseEvent.ROLL_OUT))  	{ this.removeEventListener(MouseEvent.ROLL_OUT, callExternalRollOutHandler); }
			
			if (_item_select_listener_active == true)
			{
				_item_select_listener_active = false;
				CentralEventSystem.singleton.removeEventListener(ItemEvent.SELECT, selectItemEventListener);
			}
		}
		
	}
	
}