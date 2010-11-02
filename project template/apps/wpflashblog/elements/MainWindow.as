package wpflashblog.elements
{
	/**
	* @author ABº
	*/
	
	import flash.display.Sprite;
	
	public class MainWindow extends Sprite
	{
		private var posts:Posts;
		private var sidebar:SideBar;
		
		public function MainWindow()
		{
			/// - construir o Posts
			posts 					= new Posts();
			posts.x 				= 0;
			posts.custom_width 		= 400;
			posts.custom_height		= 600;
			
			/// - construir a Sidebar
			sidebar 				= new SideBar();
			sidebar.x 				= 400;
			sidebar.custom_width 	= 200;
			sidebar.custom_height	= 600;
			
			this.addChild(posts);
			this.addChild(sidebar);
		}
		
	}

}