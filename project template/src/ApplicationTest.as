package  
{
	import com.ab.appobjects.ApplicationItem;
	import com.ab.display.geometry.PolygonQuad;
	import com.ab.swfaddress.SWFAddressManager;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import wpflashblog.FlashBlog;
	import com.ab.utils.Make;
	import com.ab.utils.TextFieldFactory;
	import com.ab.utils.Web;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import metaballs.MetaballsMain;
	
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
			
			/// START
			
			var fb:FlashBlog = new FlashBlog();
		}
	}
}