package com.soundstep.ui.layouts {
	
	import com.soundstep.ui.layouts.core.Padding;
	import com.soundstep.ui.ElementUI;	
	import com.soundstep.ui.events.BaseEventUI;	
	import flash.display.DisplayObject;	
	import flash.geom.Point;	

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
	 * TileUI is a subclass of CanvasUI that lays out its children in a grid of equal-sized cells.<br>
	 * You can set additional properties like horizontalGap, verticalGap, direction and padding.
	 * @example
	 * <listing version="3.0">
	 * var tile:TileUI = new TileUI();
	 * addChildUI(tile);
	 * tile.direction = TileUI.DIRECTION_HORIZONTAL;
	 * tile.padding = new Padding(10, 10, 10, 10);
	 * tile.name = "tile";
	 * tile.reference = this;
	 * tile.percentWidth = "50%";
	 * tile.height = 200;
	 * tile.right = 20;
	 * tile.bottom = 20;
	 * tile.canvasAlpha = .4;
	 * </listing>
	 */
	 
	public class TileUI extends CanvasUI {

		//------------------------------------
		// private properties
		//------------------------------------
		
		// value used to calculate the x and y position in the container of the child added
		private var _currentPos:Point;
		// value used to calculate the x position if the next line or row (depending of the direction)
		private var _bufferX:Number;
		// value used to calculate the y position if the next line or row (depending of the direction)
		private var _bufferY:Number;
		// direction of the children in the tile, horizontal or vertical
		private var _direction:String;
		// horizontal space between each children
		private var _horizontalGap:Number;
		// vertical space between each children
		private var _verticalGap:Number;
		// space around the children 
		private var _padding:Padding;
		// update the width of the container, force the scrollpane to handle correctly the padding
		private var _containerRedrawWidth:Number;
		// update the height of the container, force the scrollpane to handle correctly the padding
		private var _containerRedrawHeight:Number;

		//------------------------------------
		// public properties
		//------------------------------------
		
		/**
		 * static constant for the direction (property direction), the children are added horizontally
		 */
		public static const DIRECTION_HORIZONTAL:String = "horizontal";
		/**
		 * static constant for the direction (property direction), the children are added vertically
		 */
		public static const DIRECTION_VERTICAL:String = "vertical";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Constructor
		 * Create an instance of the TileUI class
		 * @param widthLayout width of the tile
		 * @default 100 
		 * @param heightLayout height of the tile 
		 * @default 100 
		 * @param layoutScrollbar whether or not the canvas creates and uses a mask to show only the content within the box
		 * @default true
		 * @param layoutMask whether or not the canvas creates and uses scrollbars if the content is bigger than the tile (scrollpane instance)
		 * @default true
		 */
		public function TileUI(widthLayout:Number = 100, heightLayout:Number = 100, layoutScrollbar:Boolean = true, layoutMask:Boolean = true) {
			initTile();
			super(widthLayout, heightLayout, layoutScrollbar, layoutMask);
		}
		
		//
		// PRIVATE, PROTECTED, INTERNAL
		//________________________________________________________________________________________________
		
		/** @private */
		// initialize the variables of the tile
		private function initTile():void {
			_direction = TileUI.DIRECTION_HORIZONTAL;
			_horizontalGap = 10;
			_verticalGap = 10;
			_padding = new Padding(10, 10, 10, 10);
			resetStyle();
		}
		
		/** @private */
		// reset the _currentX, _currentY and buffers position value before recalculate the children position in the box
		private function resetStyle():void {
			_currentPos = new Point(_padding.left, _padding.top);
			_bufferY = _padding.top;
			_bufferX = _padding.left;
		}
		
		/** @private */
		// calculate the children position in the tile
		private function updatePosition(child:DisplayObject):void {
			var nextX:Number;
			var nextY:Number;
			switch (_direction) {
				case DIRECTION_HORIZONTAL:
					if (_currentPos.x + child.width > _wrapper.width - _padding.right) {
						// new line
						nextX = _currentPos.x = _padding.left;
						nextY = _currentPos.y = _bufferY + _verticalGap;
					}
					else {
						nextX = _currentPos.x;
						nextY = _currentPos.y;
					}
					if (_currentPos.y + child.height > _bufferY) _bufferY = _currentPos.y + child.height;
					updateChildPosition(child, nextX, nextY);
					_currentPos.x += child.width + _horizontalGap;
					break;
				case DIRECTION_VERTICAL:
					if (_currentPos.y + child.height > _wrapper.height - _padding.bottom) {
						// new col
						nextY = _currentPos.y = _padding.top;
						nextX = _currentPos.x = _bufferX + _horizontalGap;
					}
					else {
						nextY = _currentPos.y;
						nextX = _currentPos.x;
					}
					if (_currentPos.x + child.width > _bufferX) _bufferX = _currentPos.x + child.width;
					updateChildPosition(child, nextX, nextY);
					_currentPos.y += child.height + _verticalGap;
					break;
			}
		}
		
		/** @private */
		// set the positon calculated to the DisplayObject
		private function updateChildPosition(child:DisplayObject, x:Number, y:Number):void {
			var el1:ElementUI = _baseUI.getElement(child);
			if (el1 != null) {
				el1.x = x;
				el1.y = y;
			}
			else {
				child.x = x;
				child.y = y;
			}
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
		
		/** @private */
		// update the mask and scrollpane instance to match the new size of the wrapper
		override protected function updateUI(e:BaseEventUI = null):void {
			resetStyle();
			for (var i:int=0; i<_container.numChildren; i++) {
				updatePosition(_container.getChildAt(i));
			}
			redrawContainer();
			super.updateUI();
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Adds a child DisplayObject instance to this Tile container
		 * @param child DisplayObject
		 * @return DisplayObject
		 */
		override public function addChild(child:DisplayObject):DisplayObject {
			super.addChild(child);
			updatePosition(child);
			redrawContainer();
			if (_scrollPane != null) _scrollPane.refreshPane();
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
				addChild(child);
				return el;
			}
			trace(child, " has been already added");
			return null;
		}
		
		/**
		 * refresh the tile elements and its children position
		 */
		override public function refresh(e:BaseEventUI = null):void {
			resetStyle();
			for (var i:int=0; i<_container.numChildren; i++) {
				updatePosition(_container.getChildAt(i));
			}
			redrawContainer();
			super.refresh();
		}
		
		/**
		 * direction of the children added in the tile, can be TileUI.DIRECTION_HORIZONTAL or TileUI.DIRECTION_VERTICAL
		 */
		public function get direction():String {
			return _direction;
		}
		
		public function set direction(direction:String):void {
			_direction = direction;
		}
		
		/**
		 * horizontal space between each children
		 */
		public function get horizontalGap():Number {
			return _horizontalGap;
		}
		
		public function set horizontalGap(horizontalGap:Number):void {
			_horizontalGap = horizontalGap;
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
	}
}