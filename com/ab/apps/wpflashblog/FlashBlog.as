package com.ab.apps.wpflashblog 
{
	/**
	* @author ABº
	* 
	* FlashPressBridge.singleton.getPostByID(getposthandler, 40);
	*/
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class FlashBlog extends Sprite
	{
		private var main_window:MainWindow;
		private var main_footer:MainFooter;
		
		public function FlashBlog() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			start();
		}
		
		private function start():void
		{
			/// construir a MainWindow
			main_window = new MainWindow();
			this.addChild(main_window);
			
			/// construir o Mainfooter
			main_footer = new MainFooter();
			this.addChild(main_footer);
		}
		
	}

}