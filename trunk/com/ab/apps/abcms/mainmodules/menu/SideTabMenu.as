package com.ab.apps.abcms.mainmodules.menu
{
	/**
	* @author ABº
	*/
	import com.ab.log.ABLogger
	import com.ab.display.DynamicWindow;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class SideTabMenu extends DynamicWindow
	{
		private var _bg:Sprite;
		private var _tab:Sprite;
		private var _mask:Sprite;
		private var _buttons_holder:Sprite;
		private var _bg_colour:uint=0x222222;
		private var _tab_text:TextField;
		
		//import com.ab.display.ABSprite;
		
		public function SideTabMenu()
		{
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
			_bg.graphics.drawRect(0, 0, _total_width - 21, _total_height - 21);
			_bg.graphics.endFill();
			
			/// MASK
			_mask.x = 5;
			_mask.y = 5;
			_mask.graphics.beginFill(0xFF0000);
			_mask.graphics.drawRect(0, 0, _total_width-31, _total_height-31);
			_mask.graphics.endFill();
			
			/// TAB
			var _style:TextFormat = new TextFormat();
			_style.color = 0xFFFFFF;
			_style.font = "Arial";
			
			_tab.x = _total_width - 20
			_tab.graphics.beginFill(_bg_colour);
			_tab.graphics.drawRect(0, 0, 20, _total_height);
			_tab.graphics.endFill();
			
			_tab_text 			= new TextField();
			_tab_text.text 		= "menu";
			_tab_text.rotation 	= 0.5;
			_tab_text.y 		= _total_height / 2 - _tab_text.width / 2;
			_tab_text.setTextFormat(_style);
			
			/// BUTTONS HOLDER
			_buttons_holder.x 		= 5;
			_buttons_holder.y 		= 5;
			_buttons_holder.mask 	= _mask;
			
			//_bg.graphics.beginFill(0x222222)
			
			this.addChild(_bg);
			this.addChild(_tab);
			this.addChild(_buttons_holder);
			this.addChild(_mask);
			_tab.addChild(_tab_text);
		}
		
		public function get bg_colour():uint { return _bg_colour; }
		
		public function set bg_colour(value:uint):void 
		{
			_bg_colour = value;
			
			_bg.graphics.beginFill(value);
			_bg.graphics.drawRect(0, 0, _total_width, _total_height);
			_bg.graphics.endFill();
		}
		
	}
	
}