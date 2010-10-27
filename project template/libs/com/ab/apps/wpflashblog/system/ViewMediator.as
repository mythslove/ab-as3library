package wpflashblog.system 
{
	/**
	* @author ABº
	*/
	
	import wpflashblog.elements.MainFooter;
	import wpflashblog.elements.MainWindow;
	import wpflashblog.elements.SideBar;
	
	public class ViewMediator extends Object
	{
		private var _main_window:MainWindow;
		private var _main_footer:MainFooter;
		
		public function ViewMediator() 
		{
			
		}
	 
		public function get main_window():MainWindow 			{ return _main_window;  }
		public function set main_window(value:MainWindow):void  { _main_window = value; }
		
		public function get main_footer():MainFooter 			{ return _main_footer;  }
		public function set main_footer(value:MainFooter):void  { _main_footer = value; }
		
	}

}