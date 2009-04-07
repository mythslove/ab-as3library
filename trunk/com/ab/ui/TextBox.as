package com.ab.ui 
{
	/**
	* @author ABº
	* A clip in the library is required - associated with this class
	*/
	
	import com.edigma.display.EdigmaSprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize
	import flash.system.System
	import flash.text.TextFormat
	
	import com.ab.ui.MCYScroller
	import com.ab.utils.Move
	import com.ab.utils.Make
	
	public class TextBox extends EdigmaSprite
	{
		public var _TITULO:String;
		public var _TEXTO:String;
		
		public var textscroller:MCYScroller;
		
		public var title_tf:TextField;
		public var mask_mc:Object;
		public var text_mc:Object;
		public var scrollback_mc:Object;
		public var scrollholder2_mc:Object;
		public var _TEXT_MC_INITHEIGHT:Number;
		public var scrollback:Object;
		public var _USING_SCROLL:Boolean=false;
		public var init_x:Number;
		public var open_x:Number;
		
		public function TextBox(title:String, text:String)
		{
			super();
			
			if (title != null) { _TITULO = title }
			if (text != null) { _TEXTO = text }
			
			//text_mc.mask = mask_mc
			
			_TEXT_MC_INITHEIGHT = text_mc.height
			
			scrollback_mc.alpha = 0
			//scrollback_mc.visible = false
		}
		
		public function build():void
		{
			var fuckitallyeah:TextFormat = new TextFormat()
			fuckitallyeah.size = 35
			title_tf.setTextFormat(fuckitallyeah)
			title_tf.autoSize = TextFieldAutoSize.LEFT;
			
			init_x = this.x
			open_x = this.x - 18
			
			if (_TITULO != null) 
			{
				title_tf.text = _TITULO
				
				if (title_tf.width > 685) 
				{
					var fuckitall:TextFormat = new TextFormat()
					
					fuckitall.size = 28
					
					title_tf.autoSize = TextFieldAutoSize.LEFT;
					title_tf.setTextFormat(fuckitall)
				}
			}
			
			if (_TEXTO != null) 
			{
				text_mc.tf.mouseWheelEnabled  = false
				text_mc.tf.condenseWhite  = true
				text_mc.tf.autoSize = TextFieldAutoSize.LEFT;
				text_mc.tf.htmlText = _TEXTO
				
				applyScrollIfNeeded()
			}
		}
		
		private function applyScrollIfNeeded():void
		{
			if (text_mc.height > mask_mc.height) 
			{
				_USING_SCROLL = true;
				
				//Make.MCToAlpha(scrollback_mc, 1)
				
				textscroller = new MCYScroller(text_mc, mask_mc.height-10, mask_mc.height-26, parent)
				
				scrollholder2_mc.addChild(textscroller)
				
				textscroller.init()
				
				scrollback_mc.alpha = 0
				//scrollback_mc.visible = false
			}
		}
	}
}