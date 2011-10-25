package com.ab.core
{
	import com.ab.appobjects.preloaders.minimalbar.MinimalBarPreloader;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Antonio Brandao
	 */
	public class Preloader extends MovieClip 
	{
		private var preloader:MinimalBarPreloader;
		public var percentage_value:Number=0;
		
		public function Preloader() 
		{
			if (stage) 
			{
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align 	= StageAlign.TOP_LEFT;
				
				preloader = new MinimalBarPreloader(new Rectangle(0, 0, 130, 40), 0x080808, new Rectangle(0, 0, 110, 2), 0x3366FF, "fill_from_center");
				
				preloader.x = Math.floor((stage.stageWidth / 2) - (130 / 2));
				preloader.y = Math.floor((stage.stageHeight / 2) - 40);
				
				addChild(preloader);
			}
			
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO show loader
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			trace(".Preloader.progress");
			// TODO update loader
			
			var new_percentage:Number = (e.bytesLoaded * 100) / e.bytesTotal;
			trace("new_percentage : " + new_percentage);
			
			//if (new_percentage > 20) 
			//{
				preloader.setPercentage(new_percentage);
			//}
		}
		
		private function checkFrame(e:Event):void 
		{
			trace(".Preloader.checkFrame");
			
			if (currentFrame == totalFrames) 
			{
				stop();
				preloader.setPercentage(100);
				//preloader.setPercentageFast(100);
				loadingFinished();
				
				//setTimeout(loadingFinished, 800);
			}
		}
		
		private function loadingFinished():void 
		{
			trace(".Preloader.loadingFinished");
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			preloader.vanish(0.8);
			//preloader.shrinkBar();
			
			//preloader.vanishBar();
			
			//setTimeout(startup, 800);
			
			startup();
		}
		
		private function startup():void 
		{
			trace(".Preloader.startup");
			var coreClass:Class = getDefinitionByName("com.ab.core.AppCore") as Class;
			addChild(new coreClass() as DisplayObject);
		}
	}
}