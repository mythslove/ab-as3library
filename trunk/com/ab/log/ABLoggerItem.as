package com.ab.log
{
	/**
	* @author ABº
	*/
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ABLoggerItem extends Sprite
	{
		private var _bg:Sprite
		private var _tf:TextField
		
		public function ABLoggerItem(_text:String)
		{
			this.x = 5
			
			_bg = new Sprite();
			_bg.graphics.beginFill(0x222222)
			_bg.graphics.drawRect(0, 0, 200, 400);
			_bg.graphics.endFill();
			
			_tf = new TextField();
			_tf.text      = _text
			_tf.multiline = true;
			_tf.wordWrap  = true;
			_tf.autoSize  = TextFieldAutoSize.LEFT;
			_tf.width     = 190;
			_tf.y 		  = 5;
			
			var _style:TextFormat = new TextFormat();
			_style.color = 0xFFFFFF;
			_style.font = "Arial";
			
			_tf.setTextFormat(_style)
			
			_bg.height = _tf.height + 5;
			//_tf.width     = 100;
			
			addChild(_bg)
			addChild(_tf)
		}
	}
}