package com.ab.ui 
{
	
	/**
	* ...
	* @author ABº
	* 
	* A clip in the library is required - associated with this class
	* 
	*/
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize
	import flash.system.System
	
	import com.ab.ui.MCYScroller
	//import com.ab.utils.DebugTF
	import com.ab.utils.Move
	import com.ab.utils.Make2
	import com.ab.display.ABMovieClip
	
	public class TextBox extends ABMovieClip
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
		
		public function TextBox(title:String, text:String)
		{
			super();
			
			_TITULO = title
			_TEXTO = text
			
			//text_mc.mask = mask_mc
			
			_TEXT_MC_INITHEIGHT = text_mc.height
			
			scrollback_mc.alpha = 0
			scrollback_mc.visible = false
		}
		
		public function build():void
		{
			title_tf.text = _TITULO
			
			text_mc.tf.mouseWheelEnabled  = false
			text_mc.tf.condenseWhite  = true
			text_mc.tf.autoSize = TextFieldAutoSize.LEFT;
			text_mc.tf.text = _TEXTO
			
			applyScrollIfNeeded()
		}
		
		private function applyScrollIfNeeded():void
		{
			trace( "applyScrollIfNeeded" );
			trace( "applyScrollIfNeeded : mask_mc.height = " + mask_mc.height );
			trace( "applyScrollIfNeeded : text_mc.height = " + text_mc.height );
			
			if (text_mc.height > mask_mc.height) 
			{
				//Make2.MCVisible(scrollback, 0.3)
				
				Make2.MCVisible(scrollback_mc)
				
				textscroller = new MCYScroller(text_mc, mask_mc.height-10, mask_mc.height-26, parent)
				
				scrollholder2_mc.addChild(textscroller)
				
				textscroller.init()
			}
		}
		/*
		public function destroy():void
		{
			parent.removeChild(this)
			
			System.gc()
		}
		*/
	}
}