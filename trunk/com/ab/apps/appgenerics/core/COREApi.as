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
	import flash.display.StageDisplayState;
	import flash.geom.Point;
	import com.ab.log.ABLogger;
	import org.casalib.util.StageReference;
	
	public class COREApi
	{
		public static const LEVEL_BACK:String = "BACK";
		public static const LEVEL_MAIN:String = "MAIN";
		public static const LEVEL_MENU:String = "MENU";
		public static const LEVEL_TOP:String  = "TOP";
		
		/// OBJECT CREATION IN LEVELS
		public static function createObjectinLevel(object:*, level:String="MAIN", coordinates:Point=null):void
		{
			if (object != null) 
			{
				if (coordinates == null)  
				{ 
					coordinates = new Point(0, 0); 
				}
				
				AppManager.singleton.createObjectinLevel(object, level, coordinates);
			}
			else 
			{ 
				trace("< ERROR > COREApi ::: createObjectinLevel() ::: Object is NULL or not specified"); 
			}	
		}
		/// LOGGING TOOL
		public static function log(s:String):void
		{
			if (s) 
			{
				ABLogger.singleton.echo(s); 
			} 
			else 
			{ 
				trace("< ERROR > COREApi ::: log() ::: String invalid or not specified"); 
			};
		}
		
		/// SCREENSAVER
		public static function setScreenSaver(_class:*, _active:Boolean=true, _time:Number=NaN):void
		{
			if (_class != null) 
			{ 
				AppManager.singleton.setScreenSaver(_class, _active, _time); 
			}			
			else 
			{ 
				trace("< ERROR > COREApi ::: setScreenSaver() ::: Provided class NULL or not specified"); 
			}
		}
		
		/// SET FULLSCREEN
		public static function setFullscreen():void
		{
			StageReference.getStage().displayState = StageDisplayState.FULL_SCREEN;
		}
		
		/// SET NORMAL SCREEN
		public static function setNormalScreen():void
		{
			StageReference.getStage().displayState = StageDisplayState.NORMAL;
		}
		
		public static function setScreenSaverOn():void	{ AppManager.singleton.SCREEN_SAVER_ACTIVE = true;   };
		public static function setScreenSaverOff():void { AppManager.singleton.SCREEN_SAVER_ACTIVE = false;  };
	}
	
}


/*

//COREApi.createSection(EmpresaSection, CoreAPI.LEVEL_MAIN);
            //COREApi.createSection(EmpresaSection, CoreAPI.LEVEL_MAIN, "path/to/section", true, {x:100, y:200, alpha:0.5} );
            //
            //COREApi.gotoSection(EmpresaSection);
            //
            //COREApi.setSWFAddress("path/to/section");
            //COREApi.setSWFAddress("path/to/section", null, true);
            //COREApi.setSWFAddress("path/to/section", {param1:"blah", param2:"blah2"});
            //COREApi.setSWFAddressParameter("param1", "blah3");
            //
            //COREApi.getSWFAddress();
            //COREApi.getSWFAddressParameters().param1;
            //
            //COREApi.createObjectInLevel(CloseButton, CoreAPI.LEVEL_MAIN, { x:10, y:10, alpha:0.1, cacheAsBitmap:true } );
            //
            //COREApi.log(); 
			
			
*/