package com.ab.appobjects.toplevel
{
	/**
	* @author ABº
	*/
	
	import com.ab.core.AppManager;
	import com.ab.display.ABSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	 
	
	public class AlertWindow extends ABSprite
	{
		private var bg_mc:Sprite;
		private var textbox:Sprite;
		private var textfield:TextField;
		
		public function AlertWindow(_alert:String="", _bg_alpha:Number=0.6, _bg_colour:uint=0x000000, _message_bg_colour:uint=0x000000, _text_style:TextFormat=null):void
		{
			this.x = 0;
			this.y = 0;
			this.alpha = 0;
			
			bg_mc 			= new ABSprite();
			textbox 		= new ABSprite();
			textfield 		= new TextField();
			
			bg_mc.alpha = _bg_alpha;
			
			this.addChild(bg_mc);
			this.addChild(textbox);
			textbox.addChild(textfield);
			
			/// tf
			textfield.width 	= AppManager.stage.width / 4;
			
			if (_text_style != null) 
			{
				textfield.defaultTextFormat = _text_style;
				textfield.embedFonts = true;
			}
			
			textfield.autoSize = TextFieldAutoSize.LEFT;
			textfield.text = _alert;
			
			var edge:Number = textfield.width / 6;
			
			custom_width 	= textfield.width + (edge * 2);
			
			textfield.x 	= (custom_width / 2) - (textfield.width / 2);
			textfield.y 	= textfield.height;
			
			textbox.graphics.beginFill(_message_bg_colour);
			textbox.graphics.drawRect(0, 0, custom_width, textfield.height * 3);
			textbox.graphics.endFill();
			
			bg_mc.graphics.beginFill(_bg_colour);
			bg_mc.graphics.drawRect(0, 0, AppManager.stage.stageWidth, AppManager.stage.stageHeight);
			bg_mc.graphics.endFill();
			
			ABSprite(bg_mc).setAlign("stretch");
			ABSprite(textbox).setAlign("center", true);
			setAlign("topleft", false);
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			this.buttonMode = true;
			this.mouseChildren = false;
			
			GoVisible();
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
			
			close()
		}
		
		public function close():void
		{
			trace("pleasewaitmessage ::: close");
			
			blurOutAndExecuteFunction(endClose, 0.5);
		}
		
		private function endClose():void
		{
			ABSprite(bg_mc).removeAlign();
			ABSprite(textbox).removeAlign();
			
			ABSprite(bg_mc).destroy();
			ABSprite(textbox).destroy();
			
			destroy();
		}
		
	}
	
}