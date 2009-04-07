package com.ab.website
{
	/**
	* @author ABº
	*/
	
	import com.edigma.display.EdigmaSprite;
	import com.edigma.display.Image;
	
	import org.casalib.util.StageReference;
	
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	import flash.events.Event;
	import com.gaiaframework.api.Gaia
	
	public class GlobalPreloader extends EdigmaSprite
	{
		private var bg_mc:EdigmaSprite
		private var assetholder_mc:EdigmaSprite
		private var _instance:*
		
		public function GlobalPreloader(preloader_asset:*, bg_colour:uint=0x000000)
		{
			this.x = 0
			this.y = 0
			this.alpha = 0
			
			bg_mc = new EdigmaSprite()
			assetholder_mc =  new EdigmaSprite()
			
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
		
		public static function create(target_object:Object, preloader_asset:*, bg_colour:uint=0x000000):GlobalPreloader
		{
			var _instance:* = new GlobalPreloader(target_object, preloader_asset, bg_colour);
			target_object.addChild(_instance);
			return _instance;
		}	
	}
}