package wpflashblog
{
	/**
	* @author ABº
	* 
	* FlashPressBridge.singleton.getPostByID(getposthandler, 40);
	*/
	
	/// flash
	import flash.display.Sprite;
	import flash.events.Event;
	
	/// flashblog
	import wpflashblog.system.*;
	import wpflashblog.elements.*;
	
	/// ab
	import com.ab.appobjects.Background;
	import com.ab.core.COREApi;
	
	public class FlashBlog extends Object
	{
		private var main_window:MainWindow;
		private var main_footer:MainFooter;
		private var background:Background;
		private var view_mediator:ViewMediator;
		
		public function FlashBlog() 
		{
			start();
		}
		
		public function start():void
		{
			/// construir a MainWindow
			main_window = new MainWindow();
			
			/// construir o Mainfooter
			main_footer = new MainFooter();
			
			/// construir o background
			//background 	= new Background(ABBlogBackground);
			
			/// add them all to the main level
			//COREApi.addChildToLevel(main_window, 	COREApi.LEVEL_MAIN);
			COREApi.addChildToLevel(main_footer, 	COREApi.LEVEL_TOP);
			//COREApi.addChildToLevel(background, 	COREApi.LEVEL_MAIN);
			
			//view_mediator 				= new ViewMediator();
			//view_mediator.main_window 	= main_window;
			//view_mediator.main_footer 	= main_footer;
		}
		
	}

}