package  
{
	import com.ab.appobjects.ApplicationItem;
	import com.ab.display.geometry.PolygonQuad;
	import com.ab.swfaddress.SWFAddressManager;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import org.osflash.signals.Signal;
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
		private var testsignal:Signal;
		
		public function ApplicationTest() 
		{
			trace( "ApplicationTest: constructor" );
		}	 
		
		public function start():void
		{
			trace( "ApplicationTestTest.start()" );
			
			/// START
			
			//var fb:FlashBlog = new FlashBlog();
			
			testsignal 				= new Signal(String, int);
			var bola1:Classtest1 	= new Classtest1();
			
			COREApi.addChildToLevel(bola1);
			
			testsignal.add(bola1.testListener);
			testsignal.add(bola1.testListener2);
			
			stage.addEventListener(MouseEvent.CLICK, clickHAndler);
		}
		
		private function clickHAndler(e:MouseEvent):void 
		{
			testsignal.dispatch("teste", Math.round(Math.random() * 7845));
		}
	}
}