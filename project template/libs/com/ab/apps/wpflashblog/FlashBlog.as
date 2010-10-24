package com.ab.apps.wpflashblog 
{
	/**
	* @author ABº
	* 
	* FlashPressBridge.singleton.getPostByID(getposthandler, 40);
	*/
	
	import com.ab.appobjects.Background;
	import com.ab.core.COREApi;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class FlashBlog extends Object
	{
		private var main_window:MainWindow;
		private var main_footer:MainFooter;
		private var background:ABBlogBackground;
		
		public function FlashBlog() 
		{
			
		}
		
		public function start():void
		{
			/// construir a MainWindow
			main_window = new MainWindow();
			COREApi.addChildToLevel(main_window, COREApi.LEVEL_MAIN);
			
			/// construir o Mainfooter
			main_footer = new MainFooter();
			COREApi.addChildToLevel(main_footer, COREApi.LEVEL_MAIN);
			
			/// construir o background
			background = new Background(ABBlogBackground);
			COREApi.addChildToLevel(background, COREApi.LEVEL_MAIN);
		}
		
	}

}