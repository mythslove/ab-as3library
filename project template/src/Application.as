package  
{
	import com.ab.apps.appgenerics.core.AppManager;
	import com.ab.apps.appgenerics.core.COREApi;
	import com.ab.display.FloatWarning;
	import com.ab.display.geometry.Circle;
	import com.ab.display.geometry.PolygonQuad;
	import com.ab.apps.appgenerics.edigma.EdigmaApplicationBase;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Application extends EdigmaApplicationBase
	{
		public function Application() 
		{
			trace( "Application: constructor" );
		}
		
		public function start():void
		{
			trace( "Application.start()" );
			
			/// START POINT
			
			for (var i:int = 0; i < 100; i++) 
			{
				var bola:Circle = new Circle(20, Math.round(Math.random() * 0xFFFFFF), 0.8);
				
				bola.x = Math.random() * stage.stageWidth;
				bola.y = Math.random() * stage.stageHeight;
				
				COREApi.addChildToLevel(bola, COREApi.LEVEL_TOP);
				
			}
			
			var txtholder:Sprite = new Sprite();
			
			COREApi.addChildToLevel(txtholder, COREApi.LEVEL_TOP);
			
			COREApi.writeVectorText(txtholder.graphics, "TESTING", "ModaerneLight", 0xffffff, 50, 0, 300, 200);
		}
	}

}