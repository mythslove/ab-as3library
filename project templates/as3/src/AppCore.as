package
{
	import com.ab.core.CORE;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flashwp.FlashWP;
	
	[SWF(width = "800", height = "600", frameRate = "30", backgroundColor = "#222222")]
	
	public class AppCore extends CORE
	{
		[Embed(source='../bin/assets/fonts/structurosa.ttf', fontName="structurosa", fontFamily="structurosa", advancedAntiAliasing="true", mimeType="application/x-font")]//, embedAsCFF="true"
		
		public const structurosa:Class;
		
		public function AppCore()
		{
			/// define main application class
			APPLICATION_CLASS = FlashWP;
			
			// access to flashvars:
			// LoaderInfo(this.root.loaderInfo).parameters;
		}
	}
}