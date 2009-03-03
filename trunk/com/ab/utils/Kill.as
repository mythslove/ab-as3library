﻿package com.ab.utils 
{
	/**
	* @author ABº
	*/
	
	import flash.display.MovieClip
	import flash.system.System
	import fl.motion.easing.*
	
	import com.ab.as3websystem.util.TweenLite
	
	public class Kill
	{
		
		public function Kill()
		{
			// e quê tá tudo ?
		}
		
		///////////// SIMPLE ///////////////////////////////////////////////////////////////////////////////////////
		
		public static function MCFast(mc:Object):void
		{
			mc.parent.removeChild(mc)
		}
		
		public static function ArrayFast(_array:Array):void
		{
			if (_array != null) 
			{
				for (var i:int = 0; i < _array.length; i++) 
				{
					if (_array[i] != null) 
					{
						if (_array[i].parent != null) 
						{
							_array[i].parent.removeChild(_array[i])
							
							//DebugTF.getSingleton().echo("Kill ::: removing _array[i] = " + _array[i].name)
						}
					}
				}
			}
			
			_array = []
			System.gc()
		}
		
		///////////// FADEOUT //////////////////////////////////////////////////////////////////////////////////////
		
		public static function MCWithFadeOut(mc:Object, tempo:Number):void
		{
			TweenLite.to(mc, tempo, { alpha:0, ease:Linear.easeNone, onComplete:destroyObject, onCompleteParams:[mc] } );
		}
		
		public static function arrayWithFadeOut(_array:Array, tempo:Number):void
		{
			for (var i:int = 0; i < _array.length; i++) 
			{
				
				var tmpArray:Array = [_array[i]]
				
				TweenLite.to(_array[i], tempo, { alpha:0, ease:Linear.easeNone, onComplete:destroyObject, onCompleteParams:tmpArray } );
			}
		}
		
		public static function arrayWithFadeOutAndDelay(_array:Array, tempo:Number, delayfactor:Number):void
		{
			for (var i:int = 0; i < _array.length; i++) 
			{
				TweenLite.to(_array[i], tempo, { alpha:0, ease:Linear.easeNone, delay:i*0.1, onComplete:destroyObject, onCompleteParams:[_array[i]] } );
			}
		}
		
		
		/////////////////////////////////////////////////////// SYSTEM
		/////////////////////////////////////////////////////// SYSTEM
		/////////////////////////////////////////////////////// SYSTEM
		
		static private function destroyObject(mc_in_array:Array):void
		{
			//params[0].parent.removeChild(params[0]);
			
			mc_in_array[0].parent.removeChild(mc_in_array[0]);
			
			//DebugTF.getSingleton().echo("typeof mc_in_array[0] = " + typeof mc_in_array[0])
			
			System.gc()
		}
	}
	
}