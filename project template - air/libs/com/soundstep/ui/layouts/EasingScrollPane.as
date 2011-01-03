package com.soundstep.ui.layouts
{
	import com.edigma.ui.Box;
	import com.exanimo.containers.BaseScrollPane;
	import com.exanimo.controls.BaseScrollBar;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import gs.*;
	import gs.easing.*;
	
	public class EasingScrollPane extends BaseScrollPane
	{
		public function EasingScrollPane() {
			verticalScrollBar.scaleThumb = false;
		}
		
		/**
		 *
		 *
		 *
		 */
		override protected function moveContent(x:Number, y:Number):void
		{
			var contentContainer:DisplayObjectContainer = this.getContentContainer();
			TweenLite.to(contentContainer, 1, {y: y, ease:Strong.easeOut});
		}
		
		override public function set width(value:Number) : void {
			verticalScrollBar.x = value - verticalScrollBar.width ;
			
			this.getContentContainer().mask.width = value;
		}
		
		override public function set height(value:Number) : void {

		}
	}
}
