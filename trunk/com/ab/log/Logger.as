package com.ab.log
{
	/**
	* 
	* @author ABº
	* 
	* 
	* @usage:
	* 
	* private var _logger:Logger;
	* 
	* _logger = new Logger();
	* 
	* stage.addChild(_logger);
	* 
	* Logger.singleton.log("qualquer coisa");
	* 
	* 
	* Dependencies:
	* 
	* - Tweener
	* - StageReference (CasaLib)   (to avoid trouble regarding access to stage)
	* - Key 		   (CasaLib)   (to toggle visibility)
	* 
	* In the project root:
	* 
	* StageReference.setStage(stage);
	*/
	
	/// flash
	import com.ab.core.AppManager;
	import com.ab.display.geometry.PolygonQuad;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	/// ab
	import com.ab.ui.YScroller;
	import com.ab.log.LoggerItem;
	
	/// other libs
	import caurina.transitions.Tweener;
	import org.casalib.ui.Key;
	 
	
	public class Logger extends Sprite
	{
		///singleton
		private static var __singleton:Logger;
		
		/// customization vars
		private var _item_spacing:int  	= 5;
		private var _totalwidth:int    	= 200;
		private var _totalheight:int   	= 380;
		private var _init_x:Number		= 50;
		
		/// public options
		private var _start_visible:Boolean;
		
		/// sys
		private var _visible:Boolean   	= false;
		private var _scrooling:Boolean 	= false;
		private var _mode:String="active";
		private var _active:Boolean;
		private var _dragging:Boolean;
		private var _standby_button:Sprite;
		private var _mask:Sprite;
		private var _content:Sprite;
		private var _bg:Sprite;
		
		///system
		private var _init_y:Number		= 50;
		private var _last_x:Number		= 50;
		private var _last_y:Number		= 50;
		private var _startdrag_x:Number;
		private var _startdrag_y:Number;
		
		public function Logger() 
		{
			trace ("Logger ::: Constructor()" ); 
			
			setSingleton();
			
			this.x		 = init_x;
			this.y		 = init_y;
			
			this.visible = _visible;
			
			this.addEventListener(Event.ADDED_TO_STAGE, 	addedHandler, 	false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler, false, 0, true);
		}
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			switch (e.keyCode) 
			{
				case Keyboard.F8:
					toggleVisible();
				break;
				
				case Keyboard.F9:
					log("Logger ::: hello! :)");
				break;
			}
		}
		
		public function get init_x():Number 				{ return _init_x; 		 };
		public function set init_x(value:Number):void  		{ _init_x = value; 		 };
		
		public function get init_y():Number 				{ return _init_y;  		 };
		public function set init_y(value:Number):void  		{ _init_y = value; 		 };
		
		public function get item_spacing():int 				{ return _item_spacing;  };
		public function set item_spacing(value:int):void  	{ _item_spacing = value; };
		
		public function get totalwidth():int 				{ return _totalwidth; 	 };
		public function set totalwidth(value:int):void  	{ _totalwidth = value; 	 };
		
		public function get totalheight():int 				{ return _totalheight;   };
		public function set totalheight(value:int):void  	{ _totalheight = value;  };
		
		private function addedHandler(e:Event):void 
		{
			trace ("Logger() ::: added to stage");
			
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			buildVisuals();
			
			setInteractions();
			
			if (_start_visible == true)  { show(); };
		}
		
		private function setInteractions():void
		{
			AppManager.stage.addEventListener(MouseEvent.MOUSE_UP, 		mouseUpHandler);
			AppManager.stage.addEventListener(MouseEvent.MOUSE_DOWN,	mouseDownHandler);
		}
		
		private function mouseDownHandler(e:MouseEvent):void
		{
			//trace ("Logger ::: mouseDownHandler:"); 
			if (this._bg.hitTestPoint(AppManager.stage.mouseX, AppManager.stage.mouseY, true)) 
			{
				_last_x = this.x;
				_last_y = this.y;
				
				_startdrag_x = this.mouseX;
				_startdrag_y = this.mouseY;
				
				AppManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, temporaryMouseMoveHandler, false, 0, true);
				
				_dragging = true;
			}
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			if (_dragging == true) 
			{
				//trace ("Logger ::: mouseUpHandler: remove mouse move event listener if dragging"); 
				
				AppManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, temporaryMouseMoveHandler);
				
				if (this.x < -this._bg.width + 20 || this.x > AppManager.stage.stageWidth - 20 || this.y < -(this._bg.height)+40 || this.y > AppManager.stage.stageHeight-20)
				{
					Tweener.addTween(this, { x:_last_x, y:_last_y, time:0.5 } );
				}
			}
		}
		
		private function temporaryMouseMoveHandler(e:MouseEvent):void 
		{
			var new_x:Number = AppManager.stage.mouseX - _startdrag_x;
			var new_y:Number = AppManager.stage.mouseY - _startdrag_y;
			
			Tweener.addTween(this, { x:new_x, y:new_y, time:0.5 } );
		}
		
		private function buildVisuals():void
		{
			_bg      		= new Sprite()
			_mask    		= new Sprite()
			_content 		= new Sprite()
			_standby_button = new PolygonQuad(_totalwidth-10, 10, 0x00ff00)
			
			_mask.x 	= 5;
			_mask.y 	= 5;
			
			_standby_button.x 	= 5;
			_standby_button.y 	= - 14;
			
			_content.x 	= 5;
			_content.y 	= 5;
			
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
			this.addChild(_standby_button)
			
			_standby_button.addEventListener(MouseEvent.CLICK, modeChangeHandler);
			
			_content.mask = _mask;
		}
		
		private function modeChangeHandler(e:MouseEvent):void 
		{
			switch (_mode) 
			{
				case "active": 		_mode = "inactive"; 	_standby_button.alpha = 0.3;	break;
				case "inactive": 	_mode = "active"; 		_standby_button.alpha = 1;		break;
			}
		}
		
		public function log(input:*):void
		{
			//checkVisibility();
			
			if (_mode == "active") 
			{
				var _previous_items:Array = new Array();
				var _need_to_move:Boolean = false;
				
				if (_content.numChildren != 0) 
				{
					// if content has children get them, to move them
					for (var x:uint = 0; x < _content.numChildren; x++)
					{
						_previous_items.push(_content.getChildAt(x));
					}
					
					_need_to_move = true;
				}
				
				var newitem:LoggerItem = new LoggerItem(input, _totalwidth, _totalheight);
				
				_content.addChild(newitem);
				
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
			
			var _previous_items:Array = new Array();
			
			
			if (_content.numChildren != 0 && _content.numChildren > 200) 
			{
				LoggerItem(_content.getChildAt(0)).destroy();
			}
		}
		
		private function applyScrool():void
		{
			var newscrool:YScroller 	 	= new YScroller();
			
			newscrool.target_clip 		 	= _content;
			newscrool.visible_height 	 	= _mask.height + 10;
			newscrool.scroll_distance 	 	= _mask.height;
			newscrool.frame_length 		 	= 5;
			newscrool.handle_alpha 		 	= .5;
			newscrool.scrooltrack_alpha  	= .5;
			newscrool.scrooltrack_colour 	= 0xFF0000;
			newscrool.hit_root				= this;
			
			newscrool.x 					= _totalwidth + 1;
			
			this.addChild(newscrool)
		}
		
		public function show():void 
		{ 
			trace("show")
			this.visible 		= true;
			
			Tweener.addTween(this, { alpha:1, time:0.5, transition:"EaseOutSine" } );
			
			_active = true  
		}
		
		public function hide():void 
		{ 
			this.visible 		= false;
			this.alpha 			= 0;
			
			_active = false 
		}
		
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
			if (this._visible == false)  
			{ 
				this.alpha 		= 0;
				this.visible 	= true;
				
				Tweener.addTween(this, { alpha:1, time:0.5, transition:"EaseOutSine" } );
			}
		}
		
		private function removedHandler(e:Event):void 
		{
			AppManager.stage.removeEventListener(MouseEvent.MOUSE_UP, 		mouseUpHandler);
			AppManager.stage.removeEventListener(MouseEvent.MOUSE_DOWN,	mouseDownHandler);
		}
		
		public function get start_visible():Boolean 			{ return _start_visible;  };
		public function set start_visible(value:Boolean):void  	{ _start_visible = value; };
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null)  { throw new Error("Logger ::: SINGLETON REPLICATION ATTEMPTED") }
			
			__singleton = this
		}
		
		public static function get singleton():Logger
		{
			if (__singleton == null) { throw new Error("Logger ::: SINGLETON DOES NOT EXIST (FAILED TO INITIALIZE?)") }
			
			return __singleton;
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
	}
	
}