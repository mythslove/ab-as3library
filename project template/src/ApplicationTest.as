package  
{
	import com.ab.apps.wpflashblog.FlashBlog;
	import com.ab.utils.Make;
	import com.ab.utils.TextFieldFactory;
	import com.ab.utils.Web;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import com.ab.apps.appgenerics.core.COREApi;
	import com.ab.apps.appgenerics.settings.XMLSettings;
	import com.ab.apps.appgenerics.applicationbase.ABApplicationBase;
	
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
			
			COREApi.addChildToLevel(flashblog, COREApi.LEVEL_MAIN);
		}
	}
}