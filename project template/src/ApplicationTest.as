package  
{
	import wpflashblog.FlashBlog;
	import com.ab.utils.Make;
	import com.ab.utils.TextFieldFactory;
	import com.ab.utils.Web;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import com.ab.core.COREApi;
	import com.ab.settings.XMLSettings;
	import com.ab.appobjects.applicationbase.ABApplicationBase;
	
	public class ApplicationTest extends ABApplicationBase
	{
		public function ApplicationTest() 
		{
			trace( "ApplicationTest: constructor" );
		}	 
		
		public function start():void
		{
			trace( "ApplicationTestTest.start()" );
			
			/// START POINT
			
			var flashblog:FlashBlog = new FlashBlog();
			
			flashblog.start();
		}
	}
}