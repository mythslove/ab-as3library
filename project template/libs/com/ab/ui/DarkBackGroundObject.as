package com.ab.ui
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.ABSprite;
	
	import org.casalib.util.StageReference;
	
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	import flash.events.Event;
	
	public class DarkBackGroundObject extends ABSprite
	{
		private var bg_mc:ABSprite
		private var assetholder_mc:ABSprite
		private var _object:*
		private var _bg_colour:uint;
		
		public function DarkBackGroundObject(object:*, bg_colour:uint=0x000000)
		{
			this.x 			= 0;
			this.y 			= 0;
			this.alpha 		= 0;
			
			_bg_colour 		= bg_colour;
			_object 		= object;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		public function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			bg_mc 			= new ABSprite();
			assetholder_mc 	= new ABSprite();
			
			this.addChildAt(bg_mc, 0);
			this.addChildAt(assetholder_mc, 1);
			
			assetholder_mc.addChild(_object);
			
			_object.x = -_object.width  / 2;
			_object.y = -_object.height / 2;
			
			//_instance 		= assetholder_mc.addChild(object);
			
			assetholder_mc.setAlign("center", true);
			
			this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			//StageReference.getStage().addEventListener(Event.RESIZE, resizeHandler, false, 0, true);
			
			bg_mc.alpha = 0.8;
			bg_mc.setAlign("stretch");
			bg_mc.graphics.beginFill(_bg_colour);
			bg_mc.graphics.drawRoundRect(0, 0, StageReference.getStage().stageWidth, StageReference.getStage().stageHeight, 0, 0);
			bg_mc.graphics.endFill();
			
			GoVisible();
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
			
			
			blurOutAndExecuteFunction(endClose, 0.5);
			//Tweener.addTween(assetholder_mc, { alpha:0, _Blur_blurX:40, _Blur_blurY:40, time:0.8, scaleX:1.3, scaleY:1.3, transition:"EaseInOutBack", onComplete:close } )
		}
		
		public function close():void
		{
			blurOutAndExecuteFunction(endClose, 0.5);
		}
		
		private function endClose():void
		{
			assetholder_mc.removeAlign();
			bg_mc.removeAlign();
			
			bg_mc.destroy();
			assetholder_mc.destroy();
			
			destroy();
		}
		
		//public static function create(object:*, bg_colour:uint=0x000000):DarkBackGroundObject
		//{
			//var _instance:* = new DarkBackGroundObject(object, bg_colour);
			//assetholder_mc.addChild(_instance);
			//return _instance;
		//}	
	}
}