package
{
	import com.ab.apps.appgenerics.core.CORE;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="925", height="430", frameRate="30", backgroundColor="#000000")]

	public class AppCore extends CORE
	{
		public function AppCore()
		{
			/// define main application class
			APPLICATION_CLASS = ApplicationTest;
			
			// access to flashvars:
			// LoaderInfo(this.root.loaderInfo).parameters;
		}
	}
}