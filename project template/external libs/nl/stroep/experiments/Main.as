package nl.stroep.experiments
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Mark Knol - Stroep.nl - 2009 (c)
	 */
	public class Main extends Sprite 
	{		
		private var menuList:Array = ["Home", "Check out my artworks", "Read my blog", "Social", "Love", "Contact me now"];		
		private var menubar_1:LiquidMenuBar;
		private var menubar_2:LiquidMenuBar;
		private var menubar_3:LiquidMenuBar;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			createTestMenus()
			
			stage.addEventListener(Event.RESIZE, updateMenus);
		}
		
		private function createTestMenus():void
		{						
			var txt1:TextField = new TextField()
			txt1.htmlText = "<font face='arial' color='#FFFFFF'><b>Fixed width</b></font>"
			txt1.y = 0;
			txt1.width = stage.stageWidth;
			this.addChild(txt1);			
			
			menubar_1 = new LiquidMenuBar(menuList, LiquidMenuModes.MODE_LIQUID_FIXED );
			menubar_1.y = 20;			
			menubar_1.width = stage.stageWidth;
			this.addChild(menubar_1);
			
			
			
			var txt2:TextField = new TextField()
			txt2.htmlText = "<font face='arial' color='#FFFFFF'><b>Unnormalized</b> - without Math.sqrt()</font>"
			txt2.y = 80;
			txt2.width = stage.stageWidth;
			this.addChild(txt2);
			
			menubar_2 = new LiquidMenuBar(menuList, LiquidMenuModes.MODE_LIQUID );
			menubar_2.y = 100;
			menubar_2.width = stage.stageWidth;
			this.addChild(menubar_2);
			
			
			
			var txt3:TextField = new TextField()
			txt3.htmlText = "<font face='arial' color='#FFFFFF'><b>Normalized</b> - with Math.sqrt()</font>"
			txt3.y = 160;
			txt3.width = stage.stageWidth;
			this.addChild(txt3);
			
			menubar_3 = new LiquidMenuBar(menuList, LiquidMenuModes.MODE_LIQUID_NORMALIZED );
			menubar_3.y = 180;
			menubar_3.width = stage.stageWidth;
			this.addChild(menubar_3);			
			
		}
		
		
		private function updateMenus(e:Event = null):void 
		{		
			menubar_1.width = stage.stageWidth;
			menubar_2.width = stage.stageWidth;			
			menubar_3.width = stage.stageWidth;			
		}
		
	}
	
}