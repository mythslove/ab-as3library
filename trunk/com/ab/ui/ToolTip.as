package com.ab.ui 
{
	import com.edigma.display.EdigmaSprite;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.display.Stage
	import flash.ui.Mouse
	import com.ab.utils.Move
	
	/**
	* @author ABº
	*/
	
	public class ToolTip extends EdigmaSprite
	{
		public var tooltipbox_mc:MovieClip
		
		private var _TARGET_CLIP:Object
		private var _TITLE:String
		private var _TEXT:String
		private var final_x:Number;
		private var final_y:Number;
		private var title_initsize:Number;
		private var text_initsize:Number;
		
		public function ToolTip()
		{
			this.mouseEnabled = false
			this.mouseChildren = false
			
			tooltipbox_mc.title_tf.autoSize = "left"
			tooltipbox_mc.text_tf.autoSize = "left"
		}
		
		public function activate(clip:Object, _title:String, _text:String=null):void
		{	
			_TARGET_CLIP = clip
			_TITLE = _title
			_TEXT = _text
			
			order()
			
			tooltipbox_mc.title_tf.text = _TITLE
			tooltipbox_mc.title_tf.autoSize = "left"
			
			if (_TEXT != null) 
			{
				tooltipbox_mc.text_tf.y = tooltipbox_mc.title_tf.y + tooltipbox_mc.title_tf.height + 5
				tooltipbox_mc.text_tf.text = _TEXT
			}
			
			GoToAlpha(1, 0.3)
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true)
		}
		
		public function deactivate():void
		{
			GoToAlpha(0, 0.3)
			
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler)
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			//trace("tooltipbox_mc.title_tf.height = " + tooltipbox_mc.title_tf.height)
			//trace("tooltipbox_mc.text_tf.height = " + tooltipbox_mc.text_tf.height)
			
			order()
			
			if (_TARGET_CLIP.hitTestPoint(parent.mouseX, parent.mouseY, true))
			{
				if (parent.mouseY < stage.stageHeight/2) // se o rato estiver no quadrante superior
				{
					final_y = parent.mouseY + 20
				}
				else   // se o rato estiver no quadrante inferior
				{
					final_y = parent.mouseY - this.height - 20
				}
				
				
				if (parent.mouseX < stage.stageWidth / 2) // se o rato estiver no lado esquerdo
				{
					final_x = parent.mouseX - 20
				}
				else // se o rato estiver no lado direito
				{
					final_x = parent.mouseX - this.width + 30
				}
				
				
				if (this.x != final_x)
				{
					GoToPositionX(final_x, 0.2, NaN, "EaseOutSine")
				}
				if (this.y != final_y)
				{
					GoToPositionY(final_y, 0.2)
				}
			}
			else
			{
				deactivate()
			}
		}
		
		private function order():void
		{
			tooltipbox_mc.text_tf.y = tooltipbox_mc.title_tf.y + tooltipbox_mc.title_tf.height + 5
			
			var position:String = ""
			
			// se o rato estiver no lado esquerdo
			if (parent.mouseY < stage.stageHeight/2) // se o rato estiver no quadrante superior
			{
				position = "top"
			}
			else   // se o rato estiver no quadrante inferior
			{
				position = "bottom"
			}
			
			if (parent.mouseX < stage.stageWidth / 2)
			{
				position = position + "left"
			}
			else // se o rato estiver no lado direito
			{
				position = position + "right"
			}
			
			tooltipbox_mc.tooltipbg_mc.gotoAndStop(position)
			
			trace("position = " + position)
			trace("position = " + tooltipbox_mc.tooltipbg_mc.currentFrame)
		}
	}
}