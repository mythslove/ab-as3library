package com.ab.core
{
	import com.ab.core.AppClasses;
	import com.ab.core.CORE;
	import com.ab.core.COREApi;
	import com.ab.display.Image;
	import com.ab.settings.XMLSettings;
	import flash.utils.getDefinitionByName;
	
	[Frame(factoryClass = "com.ab.core.Preloader")]
	
	public class AppCore extends CORE
	{
		public var appclasses:AppClasses;
		
		public function AppCore()
		{
			APPLICATION_CLASS = getDefinitionByName(AppClasses.main_app_class) as Class;
		}
	}
}