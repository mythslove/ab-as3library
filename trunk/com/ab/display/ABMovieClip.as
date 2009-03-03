﻿package com.ab.display
{
	/**
	* @author
	* ABº
	*/
	
	import flash.display.MovieClip;
	import org.casalib.display.CasaMovieClip
	import caurina.transitions.Tweener
	import org.casalib.util.ObjectUtil
	
	/* Métodos Funcionais:
	 * 
	 * Colorize
	 * 
	 * GoVisible
	 * GoInvisible
	 * GoInvisibleWithOnComplete
	 * GoToAlpha
	 * GoToPositionX
	 * GoToPositionY
	 * GoToPositionXY
	 * 
	 * 
	 * Under Development:
	 * 
	 * Align System
	 * Drag System
	 * Load System
	 * 
	 */
	
	
	public dynamic class ABMovieClip extends CasaMovieClip
	{
		public var defaultAlignOptions:Object = { 
												anchor: 'top-left', 
												horizontalPadding: 0, 
												verticalPadding: 0, 
												smoothPositioning: true 
												}
		
		public function ABMovieClip() 
		{
			
		}
		
		//////////////////// COLOUR
		//////////////////// COLOUR
		//////////////////// COLOUR
		
		public function Colorize(_colour:*, _time:Number = 0.5, _transition:String = "EaseOutSine" ):void
		{
			Tweener.addTween(this, { color:_colour, time:_time, transition:_transition } );
			
			//TweenLite.to(mc, time, { tint:_colour, ease:Linear.easeOut} );
		}
		
		// erase this one
		public function GoToColour(colour:*, _time:Number, _transition:String = "EaseOutSine" ):void
		{
			Tweener.addTween(this, { color:colour, time:_time, transition:_transition } );
		}
		
		//////////////////// ALPHA / VISIBILITY
		//////////////////// ALPHA / VISIBILITY
		//////////////////// ALPHA / VISIBILITY
		
		public function GoVisible(duration:Number=NaN, onCompleteFunc:Function=null, _transition:String="EaseOutSine"):void
		{
			this.alpha = 0
			this.visible = true
			
			if (onCompleteFunc != null)
			{
				Tweener.addTween(this, {alpha:1, time:isNaN(duration) ? 0.5 : duration, transition:_transition, onComplete:onCompleteFunc })  //Tweener.addTween(this, {alpha:1, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine", onComplete:onCompleteFunc, onCompleteParams:[this]})				
			}
			else
			{
				Tweener.addTween(this, {alpha:1, time:isNaN(duration) ? 0.5 : duration, transition:_transition})
			}
		}
		
		public function GoInvisible(duration:Number=NaN, _transition:String="EaseOutSine"):void
		{
			Tweener.addTween(this, { alpha:0, time:isNaN(duration) ? 0.5 : duration, transition:_transition, onComplete:function(){this.visible = false}} )
		}
		
		public function GoInvisibleWithOnComplete(duration:Number=NaN, oncompletefunc:Function=null):void
		{
			Tweener.addTween(this, { alpha:0, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine", onComplete:function() { this.visible = false;  oncompletefunc() }} )
		}
		
		public function GoToAlpha(alphavalue:Number, duration:Number=NaN, onCompleteFunc:Function=null):void
		{
			if (onCompleteFunc != null)
			{
				Tweener.addTween(this, {alpha:alphavalue, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine", onComplete:onCompleteFunc, onCompleteParams:[this]})
			}
			else
			{
				Tweener.addTween(this, {alpha:alphavalue, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine"})
			}
		}
		
		//////////////////// MOVEMENT
		//////////////////// MOVEMENT
		//////////////////// MOVEMENT
		
		////////////////////////// TO POSITION X
		////////////////////////// TO POSITION X
		
		public function GoToPositionX(xpos:Number, duration:Number, alphavalue=NaN, _transition:String="EaseOutSine"):void
		{
			if (isNaN(alphavalue)) 
			{
				Tweener.addTween(this, { x:xpos, time:duration, transition:_transition } );
			}
			else
			{
				Tweener.addTween(this, { x:xpos, time:duration, alpha:alphavalue, transition: _transition } );
			}	
		}
		
		////////////////////////// TO POSITION Y
		////////////////////////// TO POSITION Y
		
		public function GoToPositionY(ypos:Number, duration:Number, alphavalue:Number=NaN, _transition:String="EaseOutSine"):void
		{
			if (isNaN(alphavalue)) 
			{
				Tweener.addTween(this, { y:ypos, time:duration, transition:_transition } );
			}
			else
			{
				Tweener.addTween(this, { y:ypos, time:duration, alpha:alphavalue, transition:_transition } );
			}
		}
		
		////////////////////////// TO POSITION X Y
		////////////////////////// TO POSITION X Y
		
		public function GoToPositionXY(xpos:Number, ypos:Number, duration:Number, alphavalue:Number=NaN, transitionstyle:String="EaseOutsine"):void
		{
			if (isNaN(alphavalue)) 
			{
				Tweener.addTween(this, { x:xpos, y:ypos, time:duration, transition:transitionstyle } );
			}
			else
			{
				Tweener.addTween(this, { x:xpos, y:ypos, time:duration, alpha:alphavalue, transition:transitionstyle } );
			}
		}
	}
	
	
	/*
	
	
	ABclip.alignTo(
	{
		anchor: left,
		horizontalPadding: 10,
		verticalPadding: 2,
		smoothPositioning: true
	});
	
	ABclip.alignTo({ anchor: left })
	
	public var defaultAlignOptions:Object = 
	{
		anchor: 'top-left',
		horizontalPadding: 0,
		verticalPadding: 0,
		smoothPositioning: true
	}

	public function alignTo(options bject):ABAnimation
	{
		options = ObjectUtil.merge(options, defaultAlignOptions);
		var animation:ABAnimation = !!! to the stuff !!!;
		animation.play();
		return animation;
	}
	

	numa de poder fazer undo às merdas	
	era fixe que a tua ABAnimation desse para fazer:
	- animation.pause()
	- animation.reverse();
*/
}