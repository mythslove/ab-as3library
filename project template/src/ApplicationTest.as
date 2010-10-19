package  
{
	import com.ab.utils.Make;
	import com.ab.utils.TextFieldFactory;
	import com.ab.utils.Web;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import com.ab.apps.appgenerics.core.COREApi;
	import com.ab.apps.appgenerics.settings.XMLSettings;
	import com.ab.apps.appgenerics.applicationbase.EdigmaApplicationBase;
	
	//[Embed(source='../bin/flash/assets/fonts/TAHOMA.ttf', fontName="Tahoma", fontFamily="Tahoma", advancedAntiAliasing="true", mimeType = "application/x-font")]
	
	
	public class ApplicationTest extends EdigmaApplicationBase
	{
		public function ApplicationTest() 
		{
			trace( "ApplicationTest: constructor" );
		}
		
		public function start():void
		{
			trace( "ApplicationTestTest.start()" );
			
			/// START POINT
			
			var txtholder:Sprite = new Sprite();
			
			COREApi.addChildToLevel(txtholder, COREApi.LEVEL_TOP, { alpha:1, x:200, y:200 } );
			
			COREApi.writeVectorText(txtholder.graphics, "VECTOR TEXT", "ModaerneLight", 0xffffff, 50, 0, 0, 0);
			
			stage.addEventListener(MouseEvent.CLICK, clickHadnler);
			
			var tf:TextField = TextFieldFactory.createTextField("testing", "ModaerneLight", 60, 0xffffff, 300, "left", true, false, 400);
			//var tf2:TextField = TextFieldFactory.createTextField("testing", "structurosa", 60, 0xffffff, 300, "left", true, true, 0);
			
			COREApi.addChildToLevel(tf, COREApi.LEVEL_TOP, { x:500, y:200 } );
			
			var tf2:TextField = TextFieldFactory.createTextField("testing", "structurosa", 60, 0xffffff, 300, "left", true, true);
			
			COREApi.addChildToLevel(tf2, COREApi.LEVEL_ALERT, { x:0, y:0 } );
		}
		
		private function clickHadnler(e:MouseEvent):void 
		{
			COREApi.log(Math.random() * 12038012);
		}
	}
}