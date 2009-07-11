﻿package com.ab.log
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.Tweener;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import org.casalib.display.CasaSprite;
	
	public class ABLoggerItem extends CasaSprite
	{
		public var _height:int = 0;
		
		private var _bg:Sprite
		private var _tf:TextField
		
		private var _window_height:int;
		
		public function ABLoggerItem(_text:String, _width:int, _height:int)
		{
			_bg = new Sprite();
			_bg.graphics.beginFill(0x222222)
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
			
			_tf = new TextField();
			_tf.text      = _text
			_tf.multiline = true;
			_tf.wordWrap  = true;
			_tf.autoSize  = TextFieldAutoSize.LEFT;
			_tf.width     = _width - 10;
			_tf.x 		  = 5;
			
			var _style:TextFormat = new TextFormat();
			_style.color = 0xFFFFFF;
			_style.font = "Arial";
			
			_tf.setTextFormat(_style)
			
			_bg.height = _tf.height + 5;
			//_tf.width     = 100;
			
			addChild(_bg)
			addChild(_tf)
		}
		
		public function die()
		{
			close()
		}
		
		private function close():void
		{
			Tweener.addTween(this, { alpha:0, time:0.5, onComplete:endClose } );
		}
		
		private function endClose():void
		{
			_bg = null;
			_tf = null;
			
			destroy();
		}
	}
}