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
		private var _instance:*
		
		public function DarkBackGroundObject(preloader_asset:*, bg_colour:uint=0x000000)
		{
			this.x = 0
			this.y = 0
			this.alpha = 0
			
			bg_mc = new ABSprite()
			assetholder_mc =  new ABSprite()
			
			this.addChildAt(bg_mc, 0)
			
			_instance = assetholder_mc.addChild(new preloader_asset())
			
			assetholder_mc.setAlign("center", true)
			
			if (bg_colour != 0) 
			{
				bg_mc.alpha = 0.6
				bg_mc.setAlign("stretch")
				bg_mc.graphics.beginFill(bg_colour)
				bg_mc.graphics.drawRoundRect(0, 0, StageReference.getStage().stageWidth, StageReference.getStage().stageHeight, 0, 0);
				bg_mc.graphics.endFill();
			}
			
			GoVisible()
		}
		
		public function close():void
		{
			GoInvisibleWithOnComplete(1, endClose)
		}
		
		private function endClose():void
		{
			bg_mc.removeAlign()
			assetholder_mc.removeAlign()
			
			bg_mc.destroy()
			assetholder_mc.destroy()
			
			destroy()
		}
		
		public static function create(target_object:Object, preloader_asset:*, bg_colour:uint=0x000000):DarkBackGroundObject
		{
			var _instance:* = new DarkBackGroundObject(target_object, preloader_asset, bg_colour);
			target_object.addChild(_instance);
			return _instance;
		}	
	}
}