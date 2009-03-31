package com.ab.utils 
{
	/**
	* @author ABº
	*/
	
	import com.gaiaframework.assets.DisplayObjectAsset;
	import flash.display.DisplayObject;
	import flash.display.MovieClip
	import flash.filters.*
	import flash.text.TextField
	import flash.system.System
	import flash.utils.setTimeout;
	import flash.display.Stage
	import caurina.transitions.*
	import caurina.transitions.properties.ColorShortcuts
	import flash.events.MouseEvent
	
	import com.boostworthy.animation.easing.Transitions;
	import com.boostworthy.animation.management.AnimationManager;
	import com.boostworthy.animation.rendering.RenderMethod;
	
	//assim de repente era algo do tipo:
	//onComplete: function(args):void { onCompleteFunc1(args); onCompleteFunc2(args); ....  }
	//
	public class MakeFilter
	{
		public function MakeFilter() 
		{
			// e quê tá tudo ?
			ColorShortcuts.init();
		}
		
		///////////// MCS ///////////////////////////////////////////////////////////////////////////////////////
		///////////// MCS ///////////////////////////////////////////////////////////////////////////////////////
		///////////// MCS ///////////////////////////////////////////////////////////////////////////////////////
		///////////// MCS ///////////////////////////////////////////////////////////////////////////////////////
		
		/// Tweens an Object FILTER's properties to a specified value
		public static function MCFilter(mc:DisplayObject, filter:*,  properties:Array, values:Array, time:Number=0.5):void
		{
			time = time * 1000
			var m_objAnimationManager:AnimationManager = new AnimationManager();
			
			for (var i:int = 0; i < properties.length; i++) 
			{
				m_objAnimationManager.filter(mc, filter, properties[i], values[i], time, Transitions.CUBIC_OUT, RenderMethod.TIMER);
			}			
		}
		
		/////////////////////////////////////////////////////// SYSTEM
		/////////////////////////////////////////////////////// SYSTEM
		/////////////////////////////////////////////////////// SYSTEM
		
		static private function unVisibleMovieClip(params:Array):void
		{
			for (var i:int = 0; i < params.length; i++) 
			{
				params[i].visible = false
			}		
		}
		
		public static function destroyTweens():void
		{
			Tweener.removeAllTweens()
		}
		
		static private function killMovieClip(mc:Object):void
		{
			mc.removeChild()
			
			System.gc()
		}
	}
	
}