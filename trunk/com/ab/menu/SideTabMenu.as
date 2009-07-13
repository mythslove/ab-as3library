package com.ab.menu
{
	/**
	* @author ABº
	*/
	import com.ab.log.ABLogger
	import com.ab.display.DynamicWindow;
	import flash.display.Sprite;
	import flash.events.Event;
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
		
		//import com.ab.display.ABSprite;
		
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
			
			/// criar aba
			/// /// dar eventlisteners
			/// /// criar textfield
			/// /// 
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler)
			
			buildVisuals()
		}
		
		private function buildVisuals():void
		{
			/// create items
			/// position items
			/// position items
			
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
			
			
			/*
			this._arial_fmt = new TextFormat();
			this._arial_fmt.font = "Arial";
			this._arial_fmt.size = 40;
			
			this._text_txt.embedFonts = true;
			this._text_txt.autoSize = TextFieldAutoSize.LEFT;
			this._text_txt.defaultTextFormat = this._arial_fmt;
			this._text_txt.text = "Test Arial Format";
			*/
			/// TAB
			
			_tab.x = _custom_width - _tab_area_size;
			_tab.graphics.beginFill(_bg_colour);
			_tab.graphics.drawRect(0, 0, _tab_area_size, _custom_height);
			_tab.graphics.endFill();
			//_tab_text.rotation 	 = 90;
			//_tab_text.y 		 = _custom_height / 2 - _tab_text.width / 2;
			//_tab_text.x 		 = 10
			
			/// TAB TEXT
			
			var font:ArialMENUH2 = new ArialMENUH2();
			
			_tabtext_style 		 = new TextFormat();
			_tabtext_style.font  = font.fontName;
			_tabtext_style.size  = 14;
			_tabtext_style.color = 0xFFFFFF;
			//_tabtext_style.bold  = true;
			
			_tab_text 					= new TextField();
			_tab_text.embedFonts 	 	= true;
			_tab_text.autoSize 	 		= TextFieldAutoSize.LEFT;
			_tab_text.defaultTextFormat = _tabtext_style;
			_tab_text.text 		 		= _title;
			_tab_text.rotation 		 	= 90;
			_tab_text.selectable 		= false;
			_tab_text.y 				= _custom_height / 2 - _tab_text.height / 2;
			_tab_text.x 				= 32;
			
			
			
			/// BUTTONS HOLDER
			_buttons_holder.x 		= _frame_size;
			_buttons_holder.y 		= _frame_size;
			_buttons_holder.mask 	= _mask;
			
			_bg.graphics.beginFill(0x222222)
			
			_bg.alpha = 0.5;
			_tab.alpha = 0.5;
			_buttons_holder.alpha = 0.5;
			
			addChild(_bg);
			addChild(_tab);
			addChild(_buttons_holder);
			addChild(_mask);
			
			_tab.addChild(_tab_text);
		}
		
		public function get bg_colour():uint { return _bg_colour; }
		
		public function set bg_colour(value:uint):void 
		{
			_bg_colour = value;
			
			_bg.graphics.beginFill(value);
			_bg.graphics.drawRect(0, 0, _custom_width, _custom_height);
			_bg.graphics.endFill();
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
	}
	
}