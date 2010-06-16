package com.ab.display.galleries.plane3dgallery 
{
	/**
	* @author ABº
	*/
	//buttonMode
	//import com.ab.display.Image;
	import caurina.transitions.Tweener;
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.display.ABSprite;
	import com.ab.display.geometry.PolygonQuad;
	import com.ab.events.CentralEventSystem;
	import com.ab.ui.SimpleFrame;
	import com.ab.utils.Make;
	import com.ab.utils.Move;
	import com.bumpslide.ui.Image
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	//import sekati.ui.Image
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import org.casalib.util.RatioUtil;
	//import caurina.transitions.properties.TextShortcuts;
	//import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.properties.FilterShortcuts;
	
	public class Plane3DItem extends ABSprite
	{
		public var beVisibleOnLoadImage:Boolean=false;
		//public var frame:SimpleFrame;
		public var frame:PolygonQuad;
		public var init_y:Number;
		
		private var _id_item:int;
		private var _index:Number;
		private var _title:String;
		private var _text:String;
		private var _image:String;
		private var _fullimage:String;
		private var _target:Plane3DGallery;
		
		private var _image_display_object:Image;
		
		private var _max_width:Number  = 129;
		private var _max_height:Number = 86;
		
		private var _frame_size:Number = 5;
		
		private var _w:Number  = 129;
		private var _h:Number = 86;
		
		private var _selected_frame:MovieClip;
		private var _roll_over_frame:MovieClip;
		
		private var _selected:Boolean = false;
		private var _item_select_listener_active:Boolean;
		
		public function Plane3DItem() 
		{
			CentralEventSystem.singleton.addEventListener(ItemEvent.SELECT, selectItemEventListener, false, 0, true);
			
			_item_select_listener_active = true;
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, 	addedHandler, 	false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler, false, 0, true);
			this.addEventListener(MouseEvent.CLICK, 		clickHandler, 	false, 0, true);
		}
		
		public function removeItemSelectionListener():void
		{
			_item_select_listener_active = false;
			
			CentralEventSystem.singleton.removeEventListener(ItemEvent.SELECT, selectItemEventListener);
		}
		
		private function addedHandler(e:Event):void 
		{
			trace("Plane3DItem ::: addedHandler");
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			this.buttonMode = true;
			
			frame = new PolygonQuad(_w, _h, 0xffffff);
			
			_image_display_object = new Image(_image, Image.SCALE_CROP, _w - frame_size*2, _h - frame_size*2, imageLoadComplete);
			
			_image_display_object.fadeOnLoad = true;
			
			_image_display_object.x = frame_size;
			_image_display_object.y = frame_size;
			
			this.addChildAt(frame, 0);
			this.addChildAt(_image_display_object, 1);
			
			//frame.alpha = 0.1;
			frame.alpha = 1;
			
			this.addEventListener(MouseEvent.ROLL_OUT, 	itemRollOutHandler, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OVER, itemRollOverHandler, false, 0, true);
		}
		
		private function itemRollOverHandler(e:MouseEvent):void 
		{
			trace("itemRollOverHandler");
			
			litFrame();
		}
		
		private function itemRollOutHandler(e:MouseEvent):void 
		{
			trace("itemRollOutHandler");
			
			unlitFrame();
		}
		
		private function unlitFrame():void 		
		{ 
			Tweener.addTween(frame, { alpha:1, _color:0xffffff, _Glow_blurX:0,  _Glow_blurY:0,  _Glow_quality:15, _Glow_color:0x009900, time:2 } ); 
			//Tweener.removeTweens(frame);
			//Tweener.addTween(frame, { alpha:1, transition:"EaseOutQuad", time:0.5 } ); 
			//trace( "frame : " + frame );
			
			//frame.alpha = 1;
		}
		
		private function litFrame():void		
		{
			//frame.alpha = 0; 
			//frame.visible = true; 
			Tweener.addTween(frame, { alpha:1, _color:0x009900, _Glow_blurX:5,  _Glow_blurY:5,  _Glow_quality:10, _Glow_color:0x009900, time:1 } ); 
			//Tweener.removeTweens(frame);
			//Tweener.addTween(frame, { alpha:0.2, transition:"EaseOutQuad", time:0.5 } ); 
			//trace( "frame : " + frame );
			//frame.alpha = 0;
		}
		
		
		private function clickHandler(e:MouseEvent):void 
		{
			//clickAction();
			removeItemSelectionListener();
			
			CentralEventSystem.singleton.dispatchEvent(new ItemEvent(ItemEvent.SELECT, "select_plane3d_item"));
		}
		
		public function clickAction():void 
		{
			trace ("Plane3DItem ::: clickAction();");	
		}
		
		private function imageLoadComplete(e:Event):void
		{
			trace ("Plane3DItem ::: imageLoadComplete");
			
			///Make.MCRollOverRollOut(this, rollOver, rollOut);
		}
		
		private function rollOver(o:*):void
		{
			litFrame();
		}
		
		private function rollOut(o:*):void
		{
			unlitFrame();
		}
		
		private function selectItemEventListener(e:ItemEvent):void 
		{
			if (e.data == "select_plane3d_item")
			{
				//Tweener.addTween(this, { z:20, alpha:0, time:index * 0.3 } );
				
				startClose();
			}
		}
		
		public function startClose():void
		{
			if (this.hasEventListener(MouseEvent.CLICK)) 
			{
				this.removeEventListener(MouseEvent.CLICK, 			clickHandler);
			}
			
			if (this.hasEventListener(Event.ADDED_TO_STAGE)) 
			{
				this.removeEventListener(Event.ADDED_TO_STAGE, 		addedHandler);
			}
			
			//Tweener.addTween(this, { alpha:0, y:y - 30, z:20, time:0.3, delay:index * 0.05, onComplete:goodbye} );
			Tweener.addTween(this, { alpha:0, time:0.3, onComplete:goodbye} );
		}
		
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
		
		public function get w():Number 							{ return _w; }
		public function set w(value:Number):void  				{ _w = value; }
		
		public function get h():Number 							{ return _h; }
		public function set h(value:Number):void  				{ _h = value; }
		
		public function get frame_size():Number 				{ return _frame_size; }
		public function set frame_size(value:Number):void  		{ _frame_size = value; }
		
		private function removedHandler(e:Event):void 
		{
			//trace ("Plane3DItem ::: removedHandler()"); 
			
			if (_item_select_listener_active == true)
			{
				_item_select_listener_active = false;
				
				CentralEventSystem.singleton.removeEventListener(ItemEvent.SELECT, selectItemEventListener);
			}
			
			
			
			if (this.hasEventListener(MouseEvent.CLICK)) 
			{
				this.removeEventListener(MouseEvent.CLICK, 			clickHandler);
			}
			
			if (this.hasEventListener(Event.REMOVED_FROM_STAGE)) 
			{
				this.removeEventListener(Event.REMOVED_FROM_STAGE, 	removedHandler);
			}
		}
		
	}
	
}