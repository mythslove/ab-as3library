package com.soundstep.ui.layouts {
	
	import com.soundstep.ui.layouts.core.Padding;
	import com.soundstep.ui.ElementUI;	
	import com.soundstep.ui.events.BaseEventUI;	
	import flash.display.DisplayObject;	

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
	 * HBox is a subclass of CanvasUI that lays out the children vertically in the box.<br>
	 * You can set additional properties like verticalGap, padding, alignChildren and horizontalCenterChildren.
	 * @example
	 * <listing version="3.0">
	 * var vbox:VBoxUI = new VBoxUI();
	 * addChildUI(vbox);
	 * vbox.alignChildren = VBoxUI.ALIGN_CENTER;
	 * vbox.horizontalCenterChildren = 40;
	 * vbox.padding = new Padding(10, 25, 10, 10);
	 * vbox.name = "vbox";
	 * vbox.reference = this;
	 * vbox.percentWidth = "50%";
	 * vbox.height = 200;
	 * vbox.right = 20;
	 * vbox.bottom = 20;
	 * vbox.canvasAlpha = .4;
	 * </listing>
	 */
	 
	public class VBoxUI extends CanvasUI {

		//------------------------------------
		// private properties
		//------------------------------------
		
		// value used to calculate the y position in the container of the child added
		private var _currrentY:Number;
		// vertical space between each children
		private var _verticalGap:Number;
		// space around the children 
		private var _padding:Padding;
		// update the width of the container, force the scrollpane to handle correctly the padding
		private var _containerRedrawWidth:Number;
		// update the height of the container, force the scrollpane to handle correctly the padding
		private var _containerRedrawHeight:Number;
		// alignment of the children, can be left, center or right
		private var _alignChildren:String;
		// horizontal alignment value of the children if alignChildren has been set to center
		private var _horizontalCenterChildren:Number;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		/**
		 * static constant for the alignment (property alignChildren), the children are aligned top in the layout 
		 */
		public static const ALIGN_LEFT:String = "left";
		/**
		 * static constant for the alignment (property alignChildren), the children are centered in the layout 
		 */
		public static const ALIGN_CENTER:String = "center";
		/**
		 * static constant for the alignment (property alignChildren), the children are aligned bottom in the layout 
		 */
		public static const ALIGN_RIGHT:String = "right";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Constructor
		 * Create an instance of the VBoxUI class
		 * @param widthLayout width of the box
		 * @default 100 
		 * @param heightLayout height of the box 
		 * @default 100 
		 * @param layoutScrollbar whether or not the canvas creates and uses a mask to show only the content within the box
		 * @default true
		 * @param layoutMask whether or not the canvas creates and uses scrollbars if the content is bigger than the box (scrollpane instance)
		 * @default true
		 */
		public function VBoxUI(widthLayout:Number = 100, heightLayout:Number = 100, layoutScrollbar:Boolean = true, layoutMask:Boolean = true) {
			initVBox();
			super(widthLayout, heightLayout, layoutScrollbar, layoutMask);
		}
		
		//
		// PRIVATE, PROTECTED, INTERNAL
		//________________________________________________________________________________________________
		
		/** @private */
		// initialize the variables of the box
		private function initVBox():void {
			_alignChildren = VBoxUI.ALIGN_LEFT;
			_verticalGap = 10;
			_horizontalCenterChildren = 0;
			_padding = new Padding(10, 10, 10, 10);
			resetStyle();
		}
		
		/** @private */
		// reset the _currentY value before recalculate the children position in the box
		private function resetStyle():void {
			_currrentY = _padding.top;
		}
		
		/** @private */
		// calculate the children position in the box
		private function updatePosition(child:DisplayObject):void {
			var el:ElementUI = _baseUI.getElement(child);
			switch (_alignChildren) {
				case ALIGN_LEFT:
					el.left = _padding.left;
					el.right = NaN;
					break;
				case ALIGN_CENTER:
					el.horizontalCenter = _horizontalCenterChildren;
					break;
				case ALIGN_RIGHT:
					el.right = _padding.right;
					el.left = NaN;
					break;
			}
			el.top = _currrentY;
			_currrentY = el.element.y + el.element.height + _verticalGap;
		}
		
		/** @private */
		// redraw the container
		private function redrawContainer():void {
			if (_scrollPane != null) {
				_container.graphics.clear();
				_containerRedrawWidth = container.width + _padding.left + _padding.right;
				_containerRedrawHeight = container.height + _padding.top + _padding.bottom;
				forceSizeContainer(_containerRedrawWidth, _containerRedrawHeight);
			}			
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Adds a child DisplayObject instance to this VBox container, a ElementUI will be created
		 * @param child DisplayObject
		 * @return DisplayObject
		 */
		override public function addChild(child:DisplayObject):DisplayObject {
			super.addChild(child);
			addChildUI(child);
			updatePosition(child);
			redrawContainer();
			if (_scrollPane != null) _scrollPane['refreshPane']();
			return child;
		}
		
		/**
		 * create an ElementUI instance and add the child to the display list
		 * @param child DisplayObject
		 * @return ElementUI
		 */
		override public function addChildUI(child:DisplayObject):ElementUI {
			if (!_baseUI.contains(child)) {
				var el:ElementUI = _baseUI.add(child);
				el.name = child.name;
				el.reference = _wrapper;
			}
			if (!super.contains(child)) addChild(child);
			return el;
		}
		
		/**
		 * refresh the box elements and its children position
		 */
		override public function refresh(e:BaseEventUI = null):void {
			resetStyle();
			for (var i:int=0; i<_container.numChildren; i++) {
				updatePosition(_container.getChildAt(i));
			}
			if (_scrollPane != null) {
				_container.graphics.clear();
				_containerRedrawWidth = container.width + _padding.left + _padding.right;
				_containerRedrawHeight = container.height + _padding.top + _padding.bottom;
				forceSizeContainer(_containerRedrawWidth, _containerRedrawHeight);
			}
			super.refresh();
		}
		
		/**
		 * vertical space between each children
		 */
		public function get verticalGap():Number {
			return _verticalGap;
		}
		
		public function set verticalGap(verticalGap:Number):void {
			_verticalGap = verticalGap;
		}
		
		/**
		 * space around the children
		 */
		public function get padding():Padding {
			return _padding;
		}
		
		public function set padding(padding:Padding):void {
			_padding = padding;
		}
		
		/**
		 * alignment of the children, can be VBoxUI.ALIGN_LEFT, VBoxUI.ALIGN_CENTER or VBoxUI.ALIGN_RIGHT
		 */
		public function get alignChildren():String {
			return _alignChildren;
		}
		
		public function set alignChildren(value:String):void {
			_alignChildren = value;
			refresh();
		}
		
		/**
		 * horizontal alignment value of the children if alignChildren has been set to VBoxUI.ALIGN_CENTER
		 */
		public function get horizontalCenterChildren():Number {
			return _horizontalCenterChildren;
		}
		
		public function set horizontalCenterChildren(value:Number):void {
			_horizontalCenterChildren = value;
			if (_alignChildren == ALIGN_CENTER) {
				for each (var el:ElementUI in _baseUI.elements) {
					el.horizontalCenter = _horizontalCenterChildren;
				}
			}
		}
	}
}