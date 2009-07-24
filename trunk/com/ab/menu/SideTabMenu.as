package com.ab.menu
{
	/**
	* @author ABº
	*/
	import caurina.transitions.Tweener;
	import com.ab.display.ABSprite;
	import com.ab.log.ABLogger
	import com.ab.display.DynamicWindow;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class SideTabMenu extends ABSprite
	{
		//[Embed(source="C:\WINDOWS\Fonts\Arial.TTF", fontFamily="Arial")]
		private var _bg:Sprite;
		private var _tab:Sprite;
		private var _tab_bg:Sprite;
		private var _mask:Sprite;
		private var _buttons_holder:Sprite;
		private var _bg_colour:uint=0x111111;
		private var _tab_text:TextField;
		private var _title:String="Unnamed SideTabMenu";
		
		private var _tab_area_size:Number     = 10;
		private var _buttons_area_size:Number = 100;
		private var _elements_spacing:Number  = 100;
		private var _content_indent:Number    = 5;
		private var _arial_fmt:TextFormat;
		private var _tabtext_style:TextFormat;
		private var _bg_color:uint=0xFFFFFF;
		private var _tab_text_color:uint=0xFFFFFF;
		private var _status:String = "docked";
		
		private var _menu_item_type:Class=null;
		private var _sidetabmenuitems:Array;
		private var _button_spacing:Number;
		private var _contents_height:Number=0;
		//import com.ab.display.ABSprite; setalign
		
		public function SideTabMenu()
		{
			initVars();
			
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
		
		private function initVars():void
		{
			_sidetabmenuitems 	= new Array();
			_tabtext_style 		= new TextFormat();
			
			_bg      			= new Sprite();
			_tab     			= new Sprite();
			_tab_bg    			= new Sprite();
			_mask 				= new Sprite();
			_buttons_holder 	= new Sprite();
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler)
			
			buildVisuals();
			addEventListeners();
		}
		
		public function buildButtons():void
		{
			for (var i:int = 0; i < _sidetabmenuitems.length; i++) 
			{
				_buttons_holder.addChild(_sidetabmenuitems[i]);
				
				if (_sidetabmenuitems[i].custom_height == null) 
				{
					_contents_height += _sidetabmenuitems[i].height;
					
					_sidetabmenuitems[i].y = i * _sidetabmenuitems[i].height + _button_spacing;
				}
				else
				{
					_contents_height += _sidetabmenuitems[i].custom_height;
					
					_sidetabmenuitems[i].y = i * (_sidetabmenuitems[i].custom_height + _button_spacing);
				}
				
			}
			
			finishedBuildingButtons()
			//_sidetabmenuitems.forEach(addChild, _buttons_holder);
			//_sidetabmenuitems.forEach(function(mi:SideTabMenuItem):void {} addChild, _buttons_holder);
			//for each(var mi:SideTabMenuItem in _sidetabmenuitems) { };
		}
		
		private function finishedBuildingButtons():void
		{
			_contents_height = _contents_height + ((_sidetabmenuitems.length+1) * _button_spacing);
			
			if (_buttons_holder.height < _bg.height) 
			{
				_bg.height 		= _contents_height;
				_tab_bg.height 	= _contents_height;
				custom_height 	= _contents_height;
			}
		}
		
		private function buildVisuals():void
		{
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
									_custom_width - _tab_area_size - _elements_spacing - _content_indent * 2,
									_custom_height - _content_indent * 2);
			_mask.graphics.endFill();
			
			/// TAB
			
			_tab.mouseChildren = false;
			_tab.x = _custom_width - _tab_area_size;
			_tab_bg.graphics.beginFill(_bg_colour);
			_tab_bg.graphics.drawRect(0, 0, _tab_area_size, _custom_height);
			_tab_bg.graphics.endFill();
			
			/// TAB TEXT
			
			_tab_text 					= new TextField();
			_tab_text.autoSize 	 		= TextFieldAutoSize.LEFT;
			_tab_text.defaultTextFormat = _tabtext_style;
			_tab_text.embedFonts 	 	= true;
			_tab_text.text 		 		= _title;
			_tab_text.alpha			 	= 1;
			_tab_text.rotation 		 	= 90;
			_tab_text.selectable 		= false;
			_tab_text.y 				= _tab_area_size/4;//_custom_height / 2 - _tab_text.height / 2;
			_tab_text.x 				= _tab_area_size - 1;
			
			//trace("_tab_text.text = " + _tab_text.alpha)
			
			/// BUTTONS HOLDER
			_buttons_holder.x 		= _content_indent;
			_buttons_holder.y 		= _content_indent;
			//_buttons_holder.mask 	= _mask;
			
			_bg.graphics.beginFill(_bg_colour);
			
			addChild(_bg);
			addChild(_tab);
			addChild(_buttons_holder);
			//addChild(_mask);
			
			_tab.addChild(_tab_bg);
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
			
			if (_bg != null) 
			{
				_bg.graphics.clear();
				_bg.graphics.beginFill(value);
				_bg.graphics.drawRect(0, 0, _custom_width, _custom_height);
				_bg.graphics.endFill();
			}
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
		
		public function setDocked():void
		{
			setAlign("left", true, 0, 0);
			
			h_padding = custom_width - tab_area_size - elements_spacing;
			h_padding = h_padding * ( -1);
			
			_status = "docked";
			
			Tweener.addTween(_tab_text, { alpha:0.5, time:0.5} );
		}
		
		public function get menu_item_type():Class 					{ return _menu_item_type; 		};
		public function set menu_item_type(value:Class):void  		{ _menu_item_type = value; 		};
		
		public function get tab_area_size():Number 					{ return _tab_area_size; 	  	};
		public function set tab_area_size(value:Number):void  		{ _tab_area_size = value; 	  	};
		
		public function get buttons_area_size():Number 				{ return _buttons_area_size;  	};
		public function set buttons_area_size(value:Number):void  	{ _buttons_area_size = value; 	};
		
		public function get elements_spacing():Number 				{ return _elements_spacing;   	};
		public function set elements_spacing(value:Number):void  	{ _elements_spacing = value;  	};
		
		public function get content_indent():Number 				{ return _content_indent; 		};
		public function set content_indent(value:Number):void  		{ _content_indent = value; 		};
		
		public function get title():String 							{ return _title; 				};
		public function set title(value:String):void  				{ _title = value; 				};
		
		public function get sidetabmenuitems():Array 				{ return _sidetabmenuitems; 	};
		public function set sidetabmenuitems(value:Array):void 		{ _sidetabmenuitems = value; 	};
		
		public function get button_spacing():Number					{ return _button_spacing; 		};
		public function set button_spacing(value:Number):void  		{ _button_spacing = value; 		};
		
		public function get tabtext_style():TextFormat 				{ return _tabtext_style; 		};
		public function set tabtext_style(value:TextFormat):void 	{ _tabtext_style = value; 		};
	}                                                                                    
	
}