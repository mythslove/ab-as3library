package com.soundstep.ui.layouts {
	
	import flash.display.DisplayObject;	
	import flash.display.MovieClip;	
	import flash.display.Sprite;	
	import com.soundstep.ui.layouts.core.Wrapper;	
	import com.soundstep.ui.ElementUI;	
	import com.soundstep.ui.BaseUI;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 3.0.2<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a><br />
	 * You can use BaseUI in any flash site, except to include/distribute it in another framework, application, template, component or structure that is meant to build, scaffold or generate source files.<br />
	 * <br />
	 * <b>Date:</b> 08-2008<br />
	 * <b>Usage:</b><br />
	 * Manage a list of elements (Element UI) to be displayed<br />
	 * you can use the following properties to handle the position and sizes of the DisplayObject registered:<br />
	 * x, y, left, right, top, bottom, width (also percentage), height (also percentage), horizontalCenter, verticalCenter, ratio, alignX, alignY<br />
	 * @example
	 * <listing version="3.0">
	 * var spacer:SpacerUI = new SpacerUI(100, 100);
	 * addChild(spacer);
	 * </listing>
	 */
	 
	public class SpacerUI extends MovieClip {

		//------------------------------------
		// private properties
		//------------------------------------
		
		// instance of the Wrapper used to set the size and position of the spacer
		internal var _wrapper:Wrapper;
		// internal BaseUI instance used for the wrapper
		internal var _internalBaseUI:BaseUI;
		// ElementUI instance of the wrapper
		internal var _ui:ElementUI;
		// color of the spacer background 
		private var _spacerColor:uint;
		// alpha of the spacer background 
		private var _spacerAlpha:Number;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Constructor
		 * Create an instance of the CanvasUI class
		 * @param widthLayout width of the canvas
		 * @default 10 
		 * @param heightLayout height of the canvas 
		 * @default 10 
		 */
		public function SpacerUI(widthLayout:Number = 10, heightLayout:Number = 10) {
			initSpacer(widthLayout, heightLayout);
			super();
		}
		
		//
		// PRIVATE, PROTECTED, INTERNAL
		//________________________________________________________________________________________________
		
		/** @private */
		// initialize the variables of the spacer
		private function initSpacer(widthLayout:Number, heightLayout:Number):void {
			_spacerColor = 0x000000;
			_spacerAlpha = 0;
			_wrapper = new Wrapper();
			_wrapper.name = "wrapper";
			drawWrapper(widthLayout, heightLayout);
			super.addChild(_wrapper);
			_internalBaseUI = new BaseUI(this);
			_ui = _internalBaseUI.add(_wrapper);
		}
		
		/** @private */
		// redraw the wrapper
		private function drawWrapper(wrapperWidth:Number, wrapperHeight:Number):void {
			_wrapper.graphics.clear();
			_wrapper.graphics.beginFill(_spacerColor, _spacerAlpha);
			_wrapper.graphics.drawRect(0, 0, wrapperWidth, wrapperHeight);
			_wrapper.graphics.endFill();
			if (_ui != null) _ui.refresh();
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * get a the wrapper ElementUI instance
		 * @return ElementUI instance of the Wrapper
		 */
		public function get ui():ElementUI {
			return _ui;
		}
		
		/**
		 * background color of the canvas
		 * @default uint 0x000000
		 * @return uint color
		 */
		public function get spacerColor():uint {
			return _spacerColor;
		}
		
		public function set spacerColor(spacerColor:uint):void {
			_spacerColor = spacerColor;
			drawWrapper(_wrapper.width, _wrapper.height);
		}
		
		/**
		 * background alpha of the canvas
		 * @default Number 0
		 * @return Number alpha
		 */
		public function get spacerAlpha():Number {
			return _spacerAlpha;
		}
		
		/**
		 * get the instance of the wrapper
		 * @return Wrapper
		 */
		public function set spacerAlpha(spacerAlpha:Number):void {
			_spacerAlpha = spacerAlpha;
			drawWrapper(_wrapper.width, _wrapper.height);
		}
		
		public function get wrapper():Wrapper {
			return _wrapper;
		}
		
	}
}