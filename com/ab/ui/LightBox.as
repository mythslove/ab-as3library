package com.ab.ui 
{
	import com.edigma.display.EdigmaSprite
	import com.edigma.display.Image
	import flash.events.Event
	import flash.events.MouseEvent;
	import org.casalib.util.StageReference
	import flash.geom.Point
	
	/**
	* @author ABº
	* http://blog.antoniobrandao.com/
	*/
	
	/**
	* USAGE : 
	* 
	* 	  import LightBox
	* 
	* 	  LightBox.create(url:string, target:DisplayObject, onCompleteHandler:Function, progressHandler:Function, frameColour:uint, BGColour:uint)
	* 
	* 
	* DEPENDENCIES : 
	* 
	* 	  com.edigma.display.Image
	* 
	*     EdigmaSprite 
	* 
	* 	  CasaLib AS3 ( CasaSprite / StageReference )
	* 
	* 	  Caurina ( Tweener )
	*/
	
	public class LightBox extends EdigmaSprite
	{
		private var bg_mc:EdigmaSprite
		private var frame_mc:EdigmaSprite
		private var imgholder_mc:EdigmaSprite
		private var this_image:Image
		private var __FRAME_COLOUR:uint;
		public var _ON_COMPLETE_FUNCTION:Function
		public var _ON_PROGRESS_FUNCTION:Function
		public var __PATTERN:*;
		
		public function LightBox(url:String, onComplete:Function=null, onProgress:Function=null, _bg_colour:uint = 0x000000, _frame_colour:uint = 0xFFFFFF, pattern_linkage_id:* = null, close_linkage_id:* = null)
		{
			this.x = 0
			this.y = 0
			
			__FRAME_COLOUR = _frame_colour
			
			if (pattern_linkage_id != null) 
			{
				__PATTERN = pattern_linkage_id
			}
			
			trace("__PATTERN = " + __PATTERN)
			
			if (onComplete != null) { _ON_COMPLETE_FUNCTION = onComplete }
			if (onProgress != null) { _ON_PROGRESS_FUNCTION = onProgress }
			
			bg_mc = new EdigmaSprite()
			frame_mc = new EdigmaSprite()
			imgholder_mc =  new EdigmaSprite()
			
			frame_mc.alpha = 0
			bg_mc.alpha = 0.6
			
			this.addChildAt(bg_mc, 0)
			this.addChildAt(frame_mc, 1)
			frame_mc.addChild(imgholder_mc)
			
			imgholder_mc.x = 10
			imgholder_mc.y = 10
			
			bg_mc.setAlign("stretch")
			frame_mc.setAlign("center", true)
			
			bg_mc.graphics.beginFill(_bg_colour)
			//bg_mc.graphics.drawRoundRect(0, 0, AppManager.stage.stageWidth, AppManager.stage.stageHeight, 0, 0);
			bg_mc.graphics.drawRect(0, 0, AppManager.stage.stageWidth, AppManager.stage.stageHeight);
			bg_mc.graphics.endFill();
			
			this_image = new Image(url, imgLoadCompleteHandler, imgLoadProgressHandler)
			
			imgholder_mc.addChild(this_image)
			
			this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			this.useHandCursor = true
			this.buttonMode = true
		}
		
		public function load():void
		{
			this_image.load()
		}
		
		private function imgLoadProgressHandler(mc:Object):void
		{
			if (_ON_COMPLETE_FUNCTION != null) 
			{
				_ON_COMPLETE_FUNCTION()
			}
		}
		
		private function imgLoadCompleteHandler(mc:Object):void
		{
			var new_width:Number = Number(imgholder_mc.width) + 20
			var new_height:Number = Number(imgholder_mc.height) + 20
			
			frame_mc.GoVisible()
			
			if (__PATTERN != null) 
			{
				frame_mc.graphics.clear()
				frame_mc.graphics.beginBitmapFill(new __PATTERN(0, 0));
				frame_mc.graphics.drawRect(0, 0, new_width, new_height);
				frame_mc.graphics.endFill();
				//addChild(backGroundSprite);
			}
			else
			{
				frame_mc.graphics.clear()
				frame_mc.graphics.beginFill(__FRAME_COLOUR)
				//frame_mc.graphics.drawRoundRect(0, 0, new_width, new_height, 0, 0);
				frame_mc.graphics.drawRect(0, 0, new_width, new_height);
				frame_mc.graphics.endFill();
			}
			
			if (_ON_COMPLETE_FUNCTION != null) 
			{
				_ON_COMPLETE_FUNCTION()
			}
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			close()
		}
		
		public function close()
		{
			frame_mc.removeAlign()
			bg_mc.removeAlign()
			
			GoInvisibleWithOnComplete(0.3, endClose)
		}
		
		private function endClose():void
		{
			bg_mc.destroy()
			frame_mc.destroy()
			imgholder_mc.destroy()
			
			destroy()
		}
		
		public static function create(url:String, target:Object, onComplete:Function=null, onProgress:Function=null, _bg_colour:Number = 0x000000, _frame_colour:Number = 0xFFFFFF, pattern_linkage_id:* = null, close_linkage_id:String = null):LightBox
		{
			var lb:* = new LightBox(url, onComplete, onProgress, _bg_colour, _frame_colour, pattern_linkage_id, close_linkage_id);
			target.addChild(lb);
			lb.load();
			return lb;
		}
	}
}