package com.ab 
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
	
	public class PleaseWaitMessage extends EdigmaSprite
	{
		private var bg_mc:EdigmaSprite
		private var assetholder_mc:EdigmaSprite
		private var _instance:*
		
		public function PleaseWaitMessage()
		{
			this.x = 0
			this.y = 0
			this.alpha = 0
			
			bg_mc = new EdigmaSprite()
			assetholder_mc =  new EdigmaSprite()
			
			bg_mc.alpha = 0.6
			
			this.addChildAt(bg_mc, 0)
			this.addChildAt(assetholder_mc, 1)
			
			_instance = assetholder_mc.addChild(new PLEASE_WAIT_MESSAGE_ASSET())
			
			bg_mc.setAlign("stretch")
			assetholder_mc.setAlign("center", false)
			
			bg_mc.graphics.beginFill(0x000000)
			bg_mc.graphics.drawRoundRect(0, 0, StageReference.getStage().stageWidth, StageReference.getStage().stageHeight, 0, 0);
			bg_mc.graphics.endFill();
			
			GoVisible()
		}
		
		public function close():void
		{
			trace("pleasewaitmessage ::: close")
			
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
		
		public static function invoke():PleaseWaitMessage
		{
			var _instance:* = new PleaseWaitMessage();
			Gaia.api.getPage(Gaia.api.getCurrentBranch()).content.addChild(_instance);
			return _instance;
		}	
	}
}