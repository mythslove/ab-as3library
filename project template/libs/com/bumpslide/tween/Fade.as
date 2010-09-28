package com.bumpslide.tween {
	
	//import caurina.transitions.Tweener;
	//import caurina.transitions.properties.DisplayShortcuts;
	
	import gs.TweenMax;
	import gs.easing.Quad;
	
	import flash.display.DisplayObject;	

	/**
	 * FadeIn/FadeOut shortcuts using TweenMax
	 * 
	 * These are the functions that were in BaseClip.
	 * They have been moved here to remove the dependencies 
	 * on an external tweening engine. 
	 * 
	 * @author David Knape
	 */
	public class Fade {
		
		/**
		 *  fade in - with onComplete callback which gets run instantaneously if no tween is neded
		 */
		static public function In(target:DisplayObject, delay:Number=0, duration:Number=.4, onComplete:Function=null) : void {			
			//Tweener.removeTweens(target, '_autoAlpha');
			if (target.alpha == 1 && target.visible) {
				if(onComplete!=null) onComplete.call(null); 
				return;
			}
			if(!target.visible) {
				target.visible = true; 
				target.alpha=0;
			}
			//Tweener.addTween( target, { _autoAlpha:1, time:duration, transition:'easeOutQuad', delay:delay, onComplete:onComplete});
			TweenMax.to( target, duration, { 'autoAlpha':1, ease:Quad.easeOut, delay:delay, onComplete:onComplete});         
		}
		
		/**
		 *  fade out - with onComplete callback which gets run instantaneously if no tween is neded
		 */
		static public function Out(target:DisplayObject, delay:Number=.1, duration:Number=.2, onComplete:Function=null) : void {
			//Tweener.removeTweens(target, '_autoAlpha');
			if (!target.visible) { target.alpha = 0; if(onComplete!=null) onComplete.call(null); return; }
			//Tweener.addTween( target, { _autoAlpha:0, time:duration, transition:'easeInQuad', delay:delay, onComplete:onComplete});
			TweenMax.to( target, duration, { 'autoAlpha':0, ease:Quad.easeIn, delay:delay, onComplete:onComplete});        
		}
		
	}
}
