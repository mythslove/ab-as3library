package com.ab.menu
{
	/**
	* @author ABº
	*/
	import caurina.transitions.Tweener;
	import com.ab.log.ABLogger
	import com.ab.display.DynamicWindow;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class SideTabMenu extends DynamicWindow
	{
		//[Embed(source="C:\WINDOWS\Fonts\Arial.TTF", fontFamily="Arial")]
		private var _bg:Sprite;
		private var _tab:Sprite;
		private var _mask:Sprite;
		private var _buttons_holder:Sprite;
		private var _bg_colour:uint=0x222222;
		private var _tab_text:TextField;
		private var _title:String="Unnamed SideTabMenu";
		
		private var _tab_area_size:Number     = 10;
		private var _buttons_area_size:Number = 100;
		private var _elements_spacing:Number  = 100;
		private var _frame_size:Number        = 5;
		private var _arial_fmt:TextFormat;
		private var _tabtext_style:TextFormat;
		private var _bg_color:uint=0xFFFFFF;
		private var _tab_text_color:uint=0xFFFFFF;
		private var _status:String="docked";
		
		//import com.ab.display.ABSprite; setalign
		
		public function SideTabMenu()
		{
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true)
			
			/// criar main area
			
			/// /// bg
			/// zona de botoes
			/// zona da aba
			/// 
			/// /// scrooled content sprite
			/// /// scrooler
			
			/// /// dar eventlisteners
			/// /// 
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler)
			
			buildVisuals()
			addEventListeners()
		}
		
		private function buildVisuals():void
		{
			_bg      		= new Sprite()
			_tab     		= new Sprite()
			_mask 			= new Sprite()
			_buttons_holder = new Sprite()
			
			/// BG
			_bg.graphics.beginFill(_bg_colour);
			_bg.graphics.drawRect(0, 0, _custom_width - _tab_area_size - _elements_spacing, _custom_height);
			_bg.graphics.endFill();
			
			/// MASK
			_mask.x = 5;
			_mask.y = 5;
			_mask.graphics.beginFill(0xFF0000);
			_mask.graphics.drawRect(0,
									0, 
									_custom_width - _tab_area_size - _elements_spacing - _frame_size * 2,
									_custom_height - _frame_size * 2);
			_mask.graphics.endFill();
			
			/// TAB
			
			_tab.x = _custom_width - _tab_area_size;
			_tab.graphics.beginFill(_bg_colour);
			_tab.graphics.drawRect(0, 0, _tab_area_size, _custom_height);
			_tab.graphics.endFill();
			
			/// TAB TEXT
			
			var font:ArialMENUH2 = new ArialMENUH2();
			
			_tabtext_style 		 = new TextFormat();
			_tabtext_style.font  = font.fontName;
			_tabtext_style.color = _tab_text_color;
			
			_tab_text 					= new TextField();
			_tab_text.embedFonts 	 	= true;
			_tab_text.autoSize 	 		= TextFieldAutoSize.LEFT;
			_tab_text.defaultTextFormat = _tabtext_style;
			_tab_text.text 		 		= _title;
			_tab_text.alpha			 	= 0.5;
			_tab_text.rotation 		 	= 90;
			_tab_text.selectable 		= false;
			_tab_text.y 				= _custom_height / 2 - _tab_text.height / 2;
			_tab_text.x 				= 30;
			
			/// BUTTONS HOLDER
			_buttons_holder.x 		= _frame_size;
			_buttons_holder.y 		= _frame_size;
			_buttons_holder.mask 	= _mask;
			
			_bg.graphics.beginFill(0x222222);
			
			addChild(_bg);
			addChild(_tab);
			addChild(_buttons_holder);
			addChild(_mask);
			
			_tab.addChild(_tab_text);
		}
		
		private function addEventListeners():void
		{
			_tab.addEventListener(MouseEvent.MOUSE_OVER, tabHoverHandler)
		}
		
		private function tabHoverHandler(e:MouseEvent):void 
		{
			toggleStatus()
		}
		
		private function toggleStatus():void
		{
			switch (_status) 
			{
				case "docked":
					setOpen();
				break;
				case "open":
					setDocked();
				break;
			}
		}
		
		public function get bg_colour():uint { return _bg_colour; }
		
		public function set bg_colour(value:uint):void 
		{
			_bg_colour = value;
			
			_bg.graphics.beginFill(value);
			_bg.graphics.drawRect(0, 0, _custom_width, _custom_height);
			_bg.graphics.endFill();
		}
		
		public function get status():String { return _status; }
		public function set status(value:String):void 
		{
			_status = value;
			
			switch (_status) 
			{
				case "open": setOpen(); break;
				
				case "docked": setDocked();  break;
				
				case "centered": setCentered();  break;
			}
		}
		
		private function setCentered():void
		{
			setAlign("center", true);
			_status = "centered";
		}
		
		private function setOpen():void
		{
			setAlign("left", true, 0, 0);
			h_padding = 0;
			
			_status = "open";
			
			Tweener.addTween(_tab_text, { alpha:1, time:0.5} );
		}
		
		private function setDocked():void
		{
			setAlign("left", true, 0, 0);
			h_padding = custom_width - tab_area_size - elements_spacing;
			h_padding = h_padding * ( -1);
			
			_status = "docked";
			
			Tweener.addTween(_tab_text, { alpha:0.5, time:0.5} );
		}
		
		public function get tab_area_size():Number 					{ return _tab_area_size; 	  	};
		public function set tab_area_size(value:Number):void  		{ _tab_area_size = value; 	  	};
		
		public function get buttons_area_size():Number 				{ return _buttons_area_size;  	};
		public function set buttons_area_size(value:Number):void  	{ _buttons_area_size = value; 	};
		
		public function get elements_spacing():Number 				{ return _elements_spacing;   	};
		public function set elements_spacing(value:Number):void  	{ _elements_spacing = value;  	};
		
		public function get frame_size():Number 					{ return _frame_size; 			};
		public function set frame_size(value:Number):void  			{ _frame_size = value; 			};
		
		public function get title():String 							{ return _title; 				};
		public function set title(value:String):void  				{ _title = value; 				};
		
		public function get bg_color():uint 			{ return _bg_color; }
		public function set bg_color(value:uint):void  	{ _bg_color = value;  _bg.graphics.beginFill(_bg_color); }
		
		public function get tab_text_color():uint 			{ return _tab_text_color; }
		public function set tab_text_color(value:uint):void { _tab_text_color = value; _tabtext_style.color = _tab_text_color; }
	}
	
}