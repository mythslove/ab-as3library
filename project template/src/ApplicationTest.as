package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import com.ab.apps.appgenerics.core.COREApi;
	import com.ab.apps.appgenerics.settings.XMLSettings;
	import com.ab.apps.appgenerics.applicationbase.EdigmaApplicationBase;
	
	public class ApplicationTest extends EdigmaApplicationBase
	{
		public function ApplicationTest() 
		{
			trace( "ApplicationTest: constructor" );
		}
		
		public function start():void
		{
			trace( "ApplicationTestTest.start()" );
			
			// XMLSettings.setting("NADA")
			
			/// START POINT
			
			//trace( "XMLSettings.setting(\"DATA_TYPE\") : " + XMLSettings.setting("DATA_TYPE") );
			
			var txtholder:Sprite = new Sprite();
			
			COREApi.addChildToLevel(txtholder, COREApi.LEVEL_TOP, { alpha:0.5, x:200, y:200 } );
			
			COREApi.writeVectorText(txtholder.graphics, "VECTOR TEXT", "ModaerneLight", 0xffffff, 50, 0, 0, 0);
			
			COREApi.getXMLdata("settings/settings.xml", testreturn);
		}
		
		private function testreturn(e:*):void
		{
			trace ("ApplicationTest ::: typeof e = " + typeof e ); 
			
			trace ("ApplicationTest ::: e = " + e ); 
		}
	}

}