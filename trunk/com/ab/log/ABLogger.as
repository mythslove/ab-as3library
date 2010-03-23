package com.ab.log
{
	/**
	* @author ABº
	*/
	
	import com.ab.ui.YScroller;
	import com.ab.log.ABLoggerItem;
	import com.ab.utils.Get;
	import com.ab.utils.HitTest;
	import com.ab.utils.Make;
	import com.ab.utils.Move;
	import flash.events.MouseEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import caurina.transitions.Tweener;
	import org.casalib.util.StageReference;
	
	public class ABLogger extends Sprite
	{
		public static var __singleton:ABLogger;
		
		private var _mask:Sprite;
		private var _content:Sprite;
		private var _bg:Sprite;
		private var _item_spacing:int  = 5;
		private var _totalwidth:int    = 200;
		private var _totalheight:int   = 380;
		private var _visible:Boolean   = false;
		private var _scrooling:Boolean = false;
		private var _ref_x:Number;
		private var _ref_y:Number;
		
		/// public options
		private var _start_visible:Boolean;
		
		/// sys
		private var _active:Boolean;
		private var _dragging:Boolean;
		//private var _PREVIOUS_ITEMS:Array;
		
		public function ABLogger() 
		{
			//trace ("ABLogger ::: Constructor()" ); 
			
			setSingleton()
			
			this.y		 = 50;
			this.x		 = 50;
			//this.alpha   = 0;
			this.visible = _visible;
			
			initVars()
			
			this.addEventListener(Event.ADDED_TO_STAGE, 	addedHandler, 	false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler, false, 0, true);
		}
		
		public function get item_spacing():int 				{ return _item_spacing;  };
		public function set item_spacing(value:int):void  	{ _item_spacing = value; };
		
		public function get totalwidth():int 				{ return _totalwidth; 	 };
		public function set totalwidth(value:int):void  	{ _totalwidth = value; 	 };
		
		public function get totalheight():int 				{ return _totalheight;   };
		public function set totalheight(value:int):void  	{ _totalheight = value;  };
		
		private function initVars():void
		{
			this.alpha = 0;
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler)
			
			//trace ("ABLogger ::: buildVisuals()");
			
			buildVisuals();
			
			setInteractions();
			
			if (_start_visible == true)  { show(); };
		}
		
		private function setInteractions():void
		{
			_ref_x = StageReference.getStage().mouseX;
			_ref_y = StageReference.getStage().mouseY;
			
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP, 	mouseUpHandler);
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_DOWN,	mouseDownHandler);
		}
		
		private function mouseDownHandler(e:MouseEvent):void
		{
			//trace ("ABLogger ::: mouseDownHandler:"); 
			
			if (HitTest.MouseHitObject(this, StageReference.getStage()) == true) 
			{
				StageReference.getStage().addEventListener(MouseEvent.MOUSE_MOVE, temporaryMouseMoveHandler, false, 0, true);
				
				_dragging = true;
			}
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			//trace ("ABLogger ::: mouseUpHandler: removing drag"); 
			
			if (_dragging == true) 
			{
				StageReference.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, temporaryMouseMoveHandler);
			}
		}
		
		private function temporaryMouseMoveHandler(e:MouseEvent):void 
		{
			var new_x:Number = StageReference.getStage().mouseX - this.width / 2;
			var new_y:Number = StageReference.getStage().mouseY - 10;
			
			Move.ToPositionXY(this, new_x, new_y, 0.5);
		}
		
		private function buildVisuals():void
		{
			_bg      = new Sprite()
			_mask    = new Sprite()
			_content = new Sprite()
			
			_mask.x = 5;
			_mask.y = 5;
			
			_content.x = 5;
			_content.y = 5;
			
			//_bg.graphics.beginFill(0x222222)
			_bg.graphics.beginFill(0x222222)
			_bg.graphics.drawRect(0, 0, _totalwidth, _totalheight);
			_bg.graphics.endFill();
			_bg.alpha = 0.5;
			
			_mask.graphics.beginFill(0xFF0000)
			_mask.graphics.drawRect(0, 0, _totalwidth-10, _totalheight-10);
			_mask.graphics.endFill();
			
			this.addChild(_bg)
			this.addChild(_content)
			this.addChild(_mask)
			
			_content.mask = _mask;
		}
		
		public function echo(_string:String)
		{
			//checkVisibility();
			
			var _previous_items:Array = new Array();
			var _need_to_move:Boolean = false;
			
			if (_content.numChildren != 0) 
			{
				_previous_items = Get.AllChildren(_content);
				
				_need_to_move = true;
			}
			
			var newitem = _content.addChild(new ABLoggerItem(_string, _totalwidth, _totalheight))
			
			newitem._height = 0;
			
			if (_need_to_move == true) 
			{
				for (var i:int = 0; i < _previous_items.length; i++) 
 				{
					_previous_items[i]._height = _previous_items[i]._height + newitem.height + _item_spacing;
					
					Tweener.addTween(_previous_items[i], { y:_previous_items[i]._height, time:0.2, transition:"EaseOutSine", onComplete:checkHeight() } );
				}
			}
		}
		
		private function checkHeight():void
		{
			if (_scrooling == false) 
			{
				if (_content.height > _mask.height)
				{
					_scrooling = true;
					
					applyScrool();
				}				
			}
		}
		
		private function applyScrool():void
		{
			var newscrool:YScroller 	 = new YScroller();
			
			newscrool.target_clip 		 = _content;
			newscrool.visible_height 	 = _mask.height + 10;
			newscrool.scroll_distance 	 = _mask.height;
			newscrool.frame_length 		 = 5;
			newscrool.handle_alpha 		 = .5;
			newscrool.scrooltrack_alpha  = .5;
			newscrool.scrooltrack_colour = 0xFF0000;
			
			newscrool.x = this.width + 1;
			//newscrool.y = 5;
			//newscrool._handleheight = this.width + 5;
			
			this.addChild(newscrool)
		}
		
		public function show():void { Make.MCVisible(this);   _active = true  };
		public function hide():void { Make.MCInvisible(this); _active = false };
		
		public function toggleVisible():void
		{
			if (this._visible == true) 
			{
				this._visible = false; hide();
			}
			else
			{
				this._visible = true;  show();
			}
		}
		
		private function checkVisibility():void
		{
			if (this._visible == false)  { Make.MCVisible(this) };
		}
		
		private function removedHandler(e:Event):void 
		{
			StageReference.getStage().removeEventListener(MouseEvent.MOUSE_UP, 		mouseUpHandler);
			StageReference.getStage().removeEventListener(MouseEvent.MOUSE_DOWN,	mouseDownHandler);
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("ABLogger ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function get singleton():ABLogger
		{
			if (__singleton == null)
			{
				throw new Error("ABLogger ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)")
			}
			
			return __singleton;
		}
		
		public function get start_visible():Boolean 			{ return _start_visible;  };
		public function set start_visible(value:Boolean):void  	{ _start_visible = value; };
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}
	
}