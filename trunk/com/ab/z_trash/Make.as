package com.ab.utils 
{
	/**
	* 
	* @author ABº
	* 
	*/
	
	import flash.display.MovieClip
	
	import gs.TweenLite
	import fl.motion.easing.*
	
	public class Make 
	{
		
		public function Make() 
		{
			// e quê tá tudo ?
		}
		
		///////////// MCS ///////////////////////////////////////////////////////////////////////////////////////
		
		public static function MCColour(mc:Object, colour:Number,  tempo:Number = 0.5):void
		{
			TweenLite.to(mc, tempo, { tint:colour, ease:Linear.easeNone} );
		}
		
		public static function MCAppear(mc:Object, tempo:Number):void
		{
			TweenLite.to(mc, tempo, { alpha:1, ease:Linear.easeNone} );
		}
		
		public static function MCDisappear(mc:Object, tempo:Number):void
		{
			TweenLite.to(mc, tempo, { alpha:0, ease:Linear.easeNone} );
		}
		
		public static function MCVisible(mc:Object):void
		{
			mc.visible = true
			mc.alpha = 0
			
			TweenLite.to(mc, 0.5, { alpha:1, ease:Linear.easeOut} );
		}
		
		public static function MCVisibleWithTime(mc:Object, tempo:Number):void
		{
			mc.visible = true
			
			TweenLite.to(mc, tempo, { alpha:1, ease:Linear.easeOut} );
		}
		
		public static function MCInvisible(mc:Object):void
		{
			TweenLite.to(mc, 0.5, { alpha:0, ease:Linear.easeOut, onComplete:unvisibleMovieClip, onCompleteParams:[mc]} );
		}
		
		public static function MCInvisibleWithTime(mc:Object, tempo:Number):void
		{
			TweenLite.to(mc, tempo, { alpha:0, ease:Linear.easeOut, onComplete:unvisibleMovieClip, onCompleteParams:[mc]} );
		}
		
		public static function MCTweenToAlpha(mc:MovieClip, alphavalue:Number):void
		{
			TweenLite.to(mc, 0.5, { alpha:alphavalue, ease:Linear.easeOut} );
		}
		
		public static function MCTweenToAlphaWithTime(mc:MovieClip, alphavalue:Number, time:Number):void
		{
			TweenLite.to(mc, time, { alpha:alphavalue, ease:Linear.easeOut} );
		}
		
		public static function MCAppearAtPos(mc:Object, xpos:Number, ypos:Number, tempo:Number):void
		{
			TweenLite.to(mc, 0.5, { alpha:1, x:xpos, y:ypos, ease:Linear.easeInOut } );	
		}
		
		public static function MCDisappearAtPos(mc:Object, xpos:Number, ypos:Number, trans:String, tempo:Number):void
		{
			
			TweenLite.to(mc, tempo, { x:xpos, y:ypos, alpha:0, ease:trans, onComplete:unvisibleMovieClip, onCompleteParams:[mc]} );
		}
		
		//public static function MCDisappearAtPosAndErase(mc:MovieClip, xpos:Number, ypos:Number, trans:String, tempo:Number):Void
		//{
			//Tweener.addTween(mc, { x:xpos, y:ypos, transition:trans, time:tempo, onComplete:function() {mc.swapDepths(1); mc.removeMovieClip() } } )
		//}
		
		///////////// TIME ///////////////////////////////////////////////////////////////////////////////////////
		
		public static function TimeAndExecuteFunction(duration:Number, func:Function, root)
		{
			var auxTimeVar = 0
			
			TweenLite.to(root, 0.5, { auxTimeVar:10, ease:Linear.easeNone, onComplete:func } );
		}
		
		/////////////////////////////////////////////////////// SYSTEM
		/////////////////////////////////////////////////////// SYSTEM
		/////////////////////////////////////////////////////// SYSTEM
		
		static private function unvisibleMovieClip(mc:Object):void
		{
			mc.visible = false
		}
	}
	
}