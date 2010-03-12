package com.ab.apps.appgenerics.core 
{
	/**
	* @author ABº
	* 
	* Esta classe reúne todos os métodos essenciais das classes centrais numa API prática
	*/
	
	import com.ab.apps.appgenerics.core.DataManager;
	import com.ab.apps.appgenerics.core.AppManager;
	import com.ab.apps.appgenerics.core.ScreenSettings;
	import com.ab.apps.appgenerics.core.InactivityManager;
	import flash.geom.Point;
	
	public class COREApi 
	{
		public static function createObjectinLevel(object:*, level:String="MAIN", coordinates:Point=null):void
		{
			if (coordinates == null)  { coordinates = new Point(0, 0); }
			
			AppManager.singleton.createObjectinLevel(object, level, coordinates);
		}
	}
	
}