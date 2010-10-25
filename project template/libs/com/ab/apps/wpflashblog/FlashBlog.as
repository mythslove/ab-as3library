package wpflashblog
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
		private var background:Background;
		
		public function FlashBlog() 
		{
			
		}
		
		public function start():void
		{
			/// construir a MainWindow
			main_window = new MainWindow();
			/// construir o Mainfooter
			main_footer = new MainFooter();
			/// construir o background
			background = new Background(ABBlogBackground);
			
			/// add them all to the main level
			COREApi.addChildToLevel(main_window, 	COREApi.LEVEL_MAIN);
			COREApi.addChildToLevel(main_footer, 	COREApi.LEVEL_MAIN);
			COREApi.addChildToLevel(background, 	COREApi.LEVEL_MAIN);
		}
		
	}

}