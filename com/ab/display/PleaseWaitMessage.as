package com.ab.display
{
	/**
	* 
	* @author ABº
	* http://www.antoniobrandao.com/
	* http://blog.antoniobrandao.com/
	* 
	* use it screw it and sell it, no problem
	* 
	* @about
	* This is a "Plase Wait Message" helper class
	* Just have an asset in your library to use as what will be seen
	* create an instance of it and when you're finished use the close() method
	* you may also choose a color for the background and it's alpha although these are optional
	* 
	* @requirements
	* ADDCHILD THIS ON TOP OF EVERYTHING ELSE
	* FIRST YOU NEED TO INITIALIZE A STAGE REFERENCE
	* THIS CLASS USES CASALIB's STAGEREFERENCE CLASS
	* WHICH IS INITIALIZED IN THE ROOT WITH "StageReference.setStage(stage)"
	* IF YOU HAVE A RESIZEABLE STAGE YOU NEED TO TWEAK THIS CLASS (line 61)
	* 
	* ABSprite is required - unless you want to add tweening and align behaviours yourself
	* 
	* @example
	* import com.ab.display.ABSprite;
	* 
	* var nicevarname:PleaseWaitMessage = new PleaseWaitMessage(library_asset_linkage_name, 0x222222, 0.6);
	* addChild(nicevarname);
	* 
	* // later call the close() method
	*/
	
	import com.ab.display.ABSprite;
	
	public class PleaseWaitMessage extends ABSprite
	{
		private var bg_mc:ABSprite
		private var assetholder_mc:ABSprite
		private var _instance:*
		
		public function PleaseWaitMessage(PLEASE_WAIT_MESSAGE_ASSET_LINKAGE_NAME:*, _BG_COLOUR:uint=0x000000, _BG_ALPHA:Number=0.6)
		{
			this.x 			= 0;
			this.y 			= 0;
			this.alpha 		= 0;
			
			bg_mc 			= new ABSprite();
			assetholder_mc 	=  new ABSprite();
			
			bg_mc.alpha 	= _BG_ALPHA;
			
			this.addChildAt(bg_mc, 0);
			this.addChildAt(assetholder_mc, 1);
			
			_instance 		= assetholder_mc.addChild(new PLEASE_WAIT_MESSAGE_ASSET_LINKAGE_NAME());
			
			bg_mc.setAlign("stretch");
			assetholder_mc.setAlign("center", false);
			
			bg_mc.graphics.beginFill(_BG_COLOUR);
			bg_mc.graphics.drawRect(0, 0, AppManager.stage.stageWidth, AppManager.stage.stageHeight);
			bg_mc.graphics.endFill();
			
			GoVisible();
		}
		
		public function close():void
		{
			trace("pleasewaitmessage ::: close");
			
			GoInvisibleWithOnComplete(1, endClose);
		}
		
		private function endClose():void
		{
			bg_mc.removeAlign();
			assetholder_mc.removeAlign();
			
			bg_mc.destroy();
			assetholder_mc.destroy();
			
			destroy();
		}
	}
}