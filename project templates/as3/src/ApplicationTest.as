package  
{
	import com.ab.appobjects.DoubleSidedPlane;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import org.osflash.signals.Signal;
	
	import com.ab.appobjects.ApplicationItem;
	import com.ab.display.geometry.PolygonQuad;
	import com.ab.signals.SignalsManager;
	import com.ab.swfaddress.SWFAddressManager;
	
	import com.ab.utils.Make;
	import com.ab.utils.TextFieldFactory;
	import com.ab.utils.Web;
	
	import com.ab.core.COREApi;
	import com.ab.settings.XMLSettings;
	import com.ab.appobjects.applicationbase.ABApplicationBase;
	
	import flashwp.FlashWP;
	//import com.ab.apps.appgenerics.events.AppEvent
	import com.ab.events.AppEvent
	
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
			
			//var fb:FlashWP = new FlashWP();
			
			var lalala:DoubleSidedPlane = new DoubleSidedPlane(new PolygonQuad(200, 200, 0x0000ff, 5, 5), new PolygonQuad(200, 200, 0x00ff00, 5, 5));
			
			addChild(lalala);
			
			trace("jgjkg");
			
			//var bola1:Classtest1 	= new Classtest1();
			//
			//COREApi.addChildToLevel(bola1);
			//
			//SignalsManager.singleton.addSignalAndListener("testsignal", bola1.testListener, String, int);
			//SignalsManager.singleton.addListenerToSignal("testsignal", bola1.testListener2);
			//
			//stage.addEventListener(MouseEvent.CLICK, clickHAndler);
		}
		
		private function clickHAndler(e:MouseEvent):void 
		{
			SignalsManager.singleton.dispatch("testsignal", "someString", Math.round(Math.random() * 7845));
			SignalsManager.singleton.removeSignal("testsignal");
		}
	}
}