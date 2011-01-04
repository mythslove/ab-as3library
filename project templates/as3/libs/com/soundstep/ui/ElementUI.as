/**
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 * 
 * http://www.mozilla.org/MPL/
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 * See the License for the specific language governing rights and
 * limitations under the License.
 * 
 * The Original Code is BaseUI.
 * 
 * The Initial Developer of the Original Code is Romuald Quantin.
 * romu@soundstep.com (www.soundstep.com).
 * 
 * Portions created by
 * 
 * Initial Developer are Copyright (C) 2008-2009 Soundstep. All Rights Reserved.
 * All Rights Reserved.
 * 
 */

package com.soundstep.ui {
	
	import com.soundstep.ui.layouts.CanvasUI;	
	import flash.display.DisplayObjectContainer;	
	import flash.display.Shape;	 
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import com.soundstep.ui.events.BaseEventUI;
	
	/**
	 * Dispatched when a display object has been updated
	 * @eventType com.soundstep.ui.events.UPDATED
	 */
	[Event(name="UPDATED", type="com.soundstep.ui.events.BaseEventUI")]

	/**
	 * Dispatched before updating the DisplayObject
	 * @eventType com.soundstep.ui.events.BEFORE_UPDATE
	 */
	[Event(name="BEFORE_UPDATE", type="com.soundstep.ui.events.BaseEventUI")]
	
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
	 * var baseUI:BaseUI = new BaseUI(this);
	 * var element:ElementUI = baseUI.add(mySprite);
	 * element.right = 10;
	 * element.bottom = 10;
	 * element.width = "50%"
	 * element.height = 200;
	 * addChild(mySprite);
	 * </listing>
	 * <br />
	 * the list of the properties used to change position and sizes are:
	 * x, y, left, right, top, bottom, width, height, horizontalCenter, verticalCenter, ratio, alignX, alignY
	 */
	 
	public class ElementUI extends EventDispatcher {
		
		//------------------------------------
		// private properties
		//------------------------------------
		
		// instance of the BaseUI
		private var _baseUI:BaseUI;
		// instance of the DisplayObject
		private var _element:DisplayObject;
		// whether or not the DisplayObject is resized or positioned to the stage (false with the parent DisplayObject)  
		private var _onStage:Boolean = true;
		// specify a DisplayObjectContainer reference on which the size and position of the ElementUI will refer to<br/>
		// if not set, the onStage property value is the reference (onStage true = stage, onStage false = parent)
		private var _reference:DisplayObjectContainer;
		// initial width recorded when registered
		private var _initialWidth:Number;
		// initial height recorded when registered
		private var _initialHeight:Number;
		// mode of the backgrounds (ratio in, ratio out)
		private var _ratio:String = "";
		// ratio value of the DisplayObject 
		private var _ratioValue:Number;
		// force the element to use the initial size (useful with anything that break the real size of an element)
		private var _useInitialSize:Boolean = false;
		// Object used to memorize values when changed
		private var _memValues:Object;
		// Object used to memorize values when changed before a ratio selection
		private var _memValuesBeforeRatio:Object;
		// X axis position of the DisplayObject
		private var _x:* = NaN;
		// Y axis position of the DisplayObject
		private var _y:* = NaN;
		// value between the top of the reference (stage or parent) and the DisplayObject
		private var _top:* = NaN;
		// value between the bottom of the reference (stage or parent) and the DisplayObject
		private var _bottom:* = NaN;
		// value between the left of the reference (stage or parent) and the DisplayObject
		private var _left:* = NaN;
		// value between the right of the reference (stage or parent) and the DisplayObject
		private var _right:* = NaN;
		// value from the horizontal center of the reference (stage or parent), using this value will horizontaly center the DisplayObject
		private var _horizontalCenter:* = NaN;
		// value from the vertical center of the reference (stage or parent), using this value will verticaly center the DisplayObject
		private var _verticalCenter:* = NaN;
		// value of the width of the DisplayObject, can accept percent value
		private var _width:* = NaN;
		// value of the height of the DisplayObject, can accept percent value
		private var _height:* = NaN;
		// value of the width of the DisplayObject that will be displayed (after calculation)
		private var _screenWidth:Number = NaN;
		// value of the height of the DisplayObject that will be displayed (after calculation)
		private var _screenHeight:Number = NaN;
		// value of the horizontal alignment of the DisplayObject, used only in mode ratio_in and ratio_out
		private var _alignX:String = ALIGN_CENTER;
		// value of the vertical alignment of the DisplayObject, used only in mode ratio_in and ratio_out
		private var _alignY:String = ALIGN_CENTER;
		// whether or not the ElementUI has a mask (mask created for the mode ratio_out)
		private var _hasMask:Boolean = false;
		// instance of the mask (mask created for the mode ratio_out)
		private var _bgMask:Shape;
		// whether or not the DisplayObject will be resized (not working with ratio set to RATIO_IN or RATIO_OUT)
		private var _bypassSize:Boolean = false;
		// the DisplayObject is kept in the screen
		private var _keepOnScreen:Boolean = true;
		// force the width of the reference
		private var _forceReferenceWidth:Number;
		// force the height of the reference
		private var _forceReferenceHeight:Number;
		// whether or not the size/position of the DisplayObject is recalculate after a property change
		private var _autoRefresh:Boolean;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		/**
		 * static constant for the mode ratio_in (ElementUI.RATIO_IN)
		 */
		public static const RATIO_IN:String = "ratio_in";
		/**
		 * static constant for the mode ratio_out (ElementUI.RATIO_OUT)
		 */
		public static const RATIO_OUT:String = "ratio_out";
		/**
		 * static constant for the alignment (property alignX) in mode ratio_in or ratio_out (ElementUI.ALIGN_LEFT)
		 */
		public static const ALIGN_LEFT:String = "left";
		/**
		 * static constant for the alignment (property alignX) in mode ratio_in or ratio_out (ElementUI.ALIGN_RIGHT)
		 */
		public static const ALIGN_RIGHT:String = "right";
		/**
		 * static constant for the alignment (property alignY) in mode ratio_in or ratio_out (ElementUI.ALIGN_TOP)
		 */
		public static const ALIGN_TOP:String = "top";
		/**
		 * static constant for the alignment (property alignY) in mode ratio_in or ratio_out (ElementUI.ALIGN_BOTTOM)
		 */
		public static const ALIGN_BOTTOM:String = "bottom";
		/**
		 * static constant for the alignment (property alignX and alignY) in mode ratio_in or ratio_out (ElementUI.ALIGN_CENTER)
		 */
		public static const ALIGN_CENTER:String = "center";
		/**
		 * name of the ElementUI
		 */
		public var name:String;
		/**
		 * Specify the ElementUI instance to display rounded values
		 */
		public var rounded:Boolean = true;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Constructor
		 * Not used, instead use the add method of the BaseUI instance to create an element
		 * @param baseUI instance of the BaseUI that creates the element
		 * @param displayObject instance o the DisplayObject that will be handle by the ElementUI instance 
		 */
		public function ElementUI(baseUI:BaseUI, displayObject:DisplayObject) {
			addEventListener(BaseEventUI.BEFORE_UPDATE, setValues, false, -1);
			setElement(baseUI, displayObject);
		}
		
		//
		// PRIVATE
		//________________________________________________________________________________________________
		
		/** @private */
		// set the first parameters for the element
		private function setElement(baseUI:BaseUI, displayObject:DisplayObject):ElementUI {
			name = displayObject.name;
			_autoRefresh = true;
			_baseUI = baseUI;
			_element = displayObject;
			_x = displayObject.x;
			_y = displayObject.y;
			if (displayObject.width != 0) _initialWidth = _width = displayObject.width;
			if (displayObject.height != 0) _initialHeight = _height = displayObject.height;
			_ratioValue = _initialWidth / _initialHeight;
			_memValues = {_x:_x, _y:_y, _horizontalCenter:0, _verticalCenter:0, _left:0, _right:0, _top:0, _bottom:0, _width:_width, _height:_height, _alignX:_alignX, _alignY:_alignY};
			return this;
		}
		
		/** @private */
		// method that calcultates the sizes and positions of the DisplayObject, dispatch a BaseEventUI.UPDATED event
		private function doRefresh():void {
			if (_element is CanvasUI) return;
			var baseWidth:Number = (onStage) ? _element.stage.stageWidth : _element.parent.width;
			var baseHeight:Number = (onStage) ? _element.stage.stageHeight : _element.parent.height;
			if (_reference != null) {
				if (_reference is CanvasUI) {
					baseWidth = CanvasUI(_reference).wrapper.width;
					baseHeight = CanvasUI(_reference).wrapper.height;
				}
				else {
					baseWidth = (_reference == _element.stage) ? _element.stage.stageWidth : _reference.width;
					baseHeight = (_reference == _element.stage) ? _element.stage.stageHeight : _reference.height;
				}
			}
			if (!isNaN(_forceReferenceWidth)) baseWidth = _forceReferenceWidth;
			if (!isNaN(_forceReferenceHeight)) baseHeight = _forceReferenceHeight;
			_screenWidth = (_useInitialSize) ? _initialWidth : _width;
			_screenHeight = (_useInitialSize) ? _initialHeight : _height;
			var obj:Object = {};
			try {
				//ratio
				if (_ratio == RATIO_IN) {
					if (_hasMask) removeMask();
					_screenWidth = baseWidth - _left - _right;
					_screenHeight = baseHeight - _top - _bottom;
					if (_screenWidth / _ratioValue > _screenHeight) _screenWidth = _screenHeight * _ratioValue;
					else _screenHeight = _screenWidth / _ratioValue;
					if (rounded) {
						_screenWidth = Math.round(_screenWidth);
						_screenHeight = Math.round(_screenHeight);
					}
					obj['width'] = _screenWidth;
					obj['height'] = _screenHeight;
					// alignX
					if (_alignX == ElementUI.ALIGN_LEFT) {
						obj['x'] = 0 + _left;
					}
					else if (_alignX == ElementUI.ALIGN_CENTER) {
						obj['x'] = (baseWidth*.5 - _screenWidth*.5) + _left*.5 + _right*.5 - _right;
					}
					else if (_alignX == ElementUI.ALIGN_RIGHT) {
						obj['x'] = baseWidth - _screenWidth - _right;
					}
					// alignY
					if (_alignY == ElementUI.ALIGN_TOP) {
						obj['y'] = 0 + _top;
					}
					else if (_alignY == ElementUI.ALIGN_CENTER) {
						obj['y'] = (baseHeight/2 - obj['height']/2) + _top / 2 + _bottom / 2 - _bottom;
					}
					else if (_alignY == ElementUI.ALIGN_BOTTOM) {
						obj['y'] = baseHeight - obj['height'] - _bottom;
					}
				}
				else if (_ratio == RATIO_OUT) {
					if (!_hasMask) buildMask();
					_screenWidth = baseWidth;
					_screenHeight = baseHeight;
					if (_screenWidth / _ratioValue < _screenHeight) _screenWidth = _screenHeight * _ratioValue;
					else _screenHeight = _screenWidth / _ratioValue;
					if (rounded) {
						_screenWidth = Math.round(_screenWidth);
						_screenHeight = Math.round(_screenHeight);
					}
					obj['width'] = _screenWidth;
					obj['height'] = _screenHeight;
					// alignX
					if (_alignX == ElementUI.ALIGN_LEFT) obj['x'] = 0;
					else if (_alignX == ElementUI.ALIGN_CENTER) obj['x'] = 0 - (_screenWidth - baseWidth)*.5;
					else if (_alignX == ElementUI.ALIGN_RIGHT) obj['x'] = 0 - (_screenWidth - baseWidth);
					// alignY
					if (_alignY == ElementUI.ALIGN_TOP) obj['y'] = 0;
					else if (_alignY == ElementUI.ALIGN_CENTER) obj['y'] = 0 - (_screenHeight - baseHeight)*.5;
					else if (_alignY == ElementUI.ALIGN_BOTTOM) obj['y'] = 0 - (_screenHeight - baseHeight);
					// mask
					_bgMask.x = _left;
					_bgMask.y = _top;
					_bgMask.width = baseWidth - _left - _right;
					_bgMask.height = baseHeight - _top - _bottom;
				}
				else {
					if (_hasMask) removeMask();
					if (!bypassSize) {
						// width
						if (!isNaN(_left) && !isNaN(_right)) {
							obj['width'] = baseWidth - _left - _right;
							_screenWidth = obj['width'];
						}
						else {
							if (!isNaN(_width)) {
								obj['width'] = _width;
								_screenWidth = obj['width'];
							}
							else if (_width is String) {
								var posWidth:int = String(_width).indexOf("%");
								var percentWidth:Number = Number(String(_width).substring(0, posWidth));
								obj['width'] = baseWidth * percentWidth / 100;
								_screenWidth = obj['width'];
							}
						}
						// height
						if (!isNaN(_top) && !isNaN(_bottom)) {
							obj['height'] = baseHeight - _top - _bottom;
							_screenHeight = obj['height'];
						}
						else {
							if (!isNaN(_height)) {
								obj['height'] = _height;
								_screenHeight = obj['height'];
							}
							else if (_height is String) {
								var posHeight:int = String(_height).indexOf("%");
								var percentHeight:Number = Number(String(_height).substring(0, posHeight));
								obj['height'] = baseHeight * percentHeight / 100;
								_screenHeight = obj['height'];
							}
						}
					}
					// x
					if (!isNaN(_x)) obj['x'] = _x;
					// y
					if (!isNaN(_y)) obj['y'] = _y;
					// left
					if (!isNaN(_left)) obj['x'] = _left;
					// right
					if (!isNaN(_right)) obj['x'] = baseWidth - _screenWidth - _right;
					// top
					if (!isNaN(_top)) obj['y'] = _top;
					// bottom
					if (!isNaN(_bottom)) obj['y'] = baseHeight - _screenHeight - _bottom;
					// horizontal center
					if (!isNaN(_horizontalCenter)) obj['x'] = ((baseWidth * .5) - (_screenWidth * .5)) + _horizontalCenter;
					// vertical center
					if (!isNaN(_verticalCenter)) obj['y'] = ((baseHeight * .5) - (_screenHeight * .5)) + _verticalCenter;
					// percent check
					if (_width is String && _screenWidth + obj['x'] > baseWidth) {
						if (!bypassSize) obj['width'] = _screenWidth = baseWidth - obj['x'];
					}
					if (_height is String && _screenHeight + obj['y'] > baseHeight) {
						if (!bypassSize) obj['height'] = _screenHeight = baseHeight - obj['y'];
					}
					// keep on screen check
					if (_keepOnScreen) {
						var leftMargin:Number = (isNaN(_left)) ? 0 : _left;
						var topMargin:Number = (isNaN(_top)) ? 0 : _top;
						if (obj['x'] < leftMargin) {
							if (!isNaN(_left)) obj['x'] = _left;
							else obj['x'] = 0;
						}
						if (obj['y'] < topMargin) {
							if (!isNaN(_top)) obj['y'] = _top;
							else obj['y'] = 0;
						}
					}
				}
				// set values
				dispatchEvent(new BaseEventUI(BaseEventUI.BEFORE_UPDATE, this, obj));
			}
			catch (e:Error) { trace(e.message); }
			finally {}
		}
		
		/** @private */
		// set the values to the DisplayObject
		private function setValues(e:BaseEventUI):void {
			var obj:Object = e.properties;
			for (var prop:String in obj) {
				//trace(_element.name, ": ", prop, " = " + Math.round(obj[prop]));
				if (rounded) _element[prop] = Math.round(obj[prop]);
				else _element[prop] = obj[prop];
			}
			if (rounded) {
				_screenWidth = Math.round(_screenWidth);
				_screenHeight = Math.round(_screenHeight);
			}
			dispatchEvent(new BaseEventUI(BaseEventUI.UPDATED, this, null));
		}
		
		/** @private */
		// memorize the value before be set to NaN
		private function memorize(prop:String):void {
			var testString:Boolean = this[prop] is String;
			if (!isNaN(this[prop]) || testString) _memValues[prop] = this[prop];
		}
		
		/** @private */
		// restore the value
		private function restore(prop:String):void {
			var testString:Boolean = this[prop] is String;
			if (isNaN(this[prop]) && !testString) this[prop] = _memValues[prop];
		}
		
		/** @private */
		// get the value String or Number and return the right type
		private function getValue(value:*):* {
			try {
				if (value is Number) return value;
				else if (value is String && String(value).indexOf("%") == -1) return Number(value);
				else if (value is String && String(value).indexOf("%") != -1) return String(value);
				else throw new Error("Error setting a property in ElementUI " + _element.name + ": type " + typeof(value) + " is invalid");
			}
			catch (e:Error) { trace(e.message); }
		}
		
		/** @private */
		// build the Shape of the mask (in case of ratio out)
		private function buildMask():void {
			_hasMask = true;
			var elementRoot:DisplayObjectContainer = _element.parent as DisplayObjectContainer;
			_bgMask = new Shape();
			_bgMask.graphics.beginFill(0xFF0000);
			var w:Number = _element.stage.stageWidth - _right - _left;
			var h:Number = _element.stage.stageHeight - _bottom - _top;
			_bgMask.graphics.drawRect(0, 0, w, h);
			elementRoot.addChild(_bgMask);
			_element.mask = _bgMask;
		}
		
		/** @private */
		// remove the mask (in case of ratio out)
		private function removeMask():void {
			_hasMask = false;
			_element.mask = null;
			_element.parent.removeChild(_bgMask);
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * get the DisplayObject handle by the ElementUI instance
		 * @return DisplayObject 
		 */
		public function get element():DisplayObject {
			return _element;
		}
		
		/**
		 * position on the x axis of the ElementUI instance, Number or String
		 */
		public function get x():Number {
			return _x;
		}
		
		public function set x(x:*):void {
			try {
				if (ratio == RATIO_IN || ratio == RATIO_OUT ) {
					if (!isNaN(x)) throw new Error("Error in ElementUI " + _element.name + ": the x property can't be used in mode RATIO_IN or RATIO_OUT");
				}
				x = getValue(x);
				memorize("_x");
				_x = x;
				if (!isNaN(_x)) {
					memorize("_left");
					_left = NaN;
					memorize("_horizontalCenter");
					_horizontalCenter = NaN;
					memorize("_right");
					_right = NaN;
				}
				if (_autoRefresh) forceRefresh();
			}
			catch (e:Error) { trace(e.message); }
		}
		
		/**
		 * position on the y axis of the ElementUI instance, Number or String
		 */
		public function get y():Number {
			return _y;
		}
		
		public function set y(y:*):void {
			try {
				if (ratio == RATIO_IN || ratio == RATIO_OUT) {
					if (!isNaN(y)) throw new Error("Error in ElementUI " + _element.name + ": the y property can't be used in mode RATIO_IN or RATIO_OUT");
				}
				y = getValue(y);
				memorize("_y");
				_y = y;
				if (!isNaN(_y)) {
					memorize("_top");
					_top = NaN;
					memorize("_verticalCenter");
					_verticalCenter = NaN;
					memorize("_bottom");
					_bottom = NaN;
				}
				if (_autoRefresh) forceRefresh();
			}
			catch (e:Error) { trace(e.message); }
		}
		
		/**
		 * value between the top of the reference (stage or parent) and the ElementUI, Number or String
		 */
		public function get top():Number {
			return _top;
		}
		
		public function set top(top:*):void {
			top = getValue(top);
			memorize("_top");
			_top = top;
			if (!isNaN(_top)) {
				memorize("_y");
				_y = NaN;
				memorize("_verticalCenter");
				_verticalCenter = NaN;
				if (!isNaN(_bottom)) {
					memorize("_height");
					_height = NaN;
				}
			}
			else {
				if (isNaN(_bottom) && isNaN(_verticalCenter)) restore("_y");
				restore("_height");
			}
			if (_autoRefresh) forceRefresh();
		}
		
		/**
		 * value between the bottom of the reference (stage or parent) and the ElementUI, Number or String
		 */
		public function get bottom():Number {
			return _bottom;
		}
		
		public function set bottom(bottom:*):void {
			bottom = getValue(bottom);
			memorize("_bottom");
			_bottom = bottom;
			if (!isNaN(_bottom)) {
				memorize("_y");
				_y = NaN;
				memorize("_verticalCenter");
				_verticalCenter = NaN;
				if (!isNaN(_top)) {
					memorize("_height");
					_height = NaN;
				}
			}
			else {
				if (isNaN(_top) && isNaN(_verticalCenter)) restore("_y");
				restore("_height");
			}
			if (_autoRefresh) forceRefresh();
		}

		/**
		 * value between the left of the reference (stage or parent) and the ElementUI, Number or String
		 */
		public function get left():Number {
			return _left;
		}
		
		public function set left(left:*):void {
			left = getValue(left);
			memorize("_left");
			_left = left;
			if (!isNaN(_left)) {
				memorize("_x");
				_x = NaN;
				memorize("_horizontalCenter");
				_horizontalCenter = NaN;
				if (!isNaN(_right)) {
					memorize("_width");
					_width = NaN;
				}
			}
			else {
				if (isNaN(_right) && isNaN(_horizontalCenter)) restore("_x");
				restore("_width");
			}
			if (_autoRefresh) forceRefresh();
		}

		/**
		 * value between the right of the reference (stage or parent) and the ElementUI, Number or String
		 */
		public function get right():Number {
			return _right;
		}
		
		public function set right(right:*):void {
			right = getValue(right);
			memorize("_right");
			_right = right;
			if (!isNaN(_right)) {
				memorize("_x");
				_x = NaN;
				memorize("_horizontalCenter");
				_horizontalCenter = NaN;
				if (!isNaN(_left)) {
					memorize("_width");
					_width = NaN;
				}
			}
			else {
				if (isNaN(_left) && isNaN(_horizontalCenter)) restore("_x");
				restore("_width");
			}
			if (_autoRefresh) forceRefresh();
		}
		
		/**
		 * value from the center of the reference (stage or parent), align the ElementUI to the center on the x axis, Number or String
		 */
		public function get horizontalCenter():Number {
			return _horizontalCenter;
		}
		
		public function set horizontalCenter(horizontalCenter:*):void {
			try {
				if (ratio == RATIO_IN || ratio == RATIO_OUT) {
					if (!isNaN(horizontalCenter)) throw new Error("Error in ElementUI " + _element.name + ": the horizontalCenter property can't be used in mode RATIO_IN or RATIO_OUT");
				}
				horizontalCenter = getValue(horizontalCenter);
				memorize("_horizontalCenter");
				_horizontalCenter = horizontalCenter;
				if (!isNaN(_horizontalCenter)) {
					memorize("_x");
					_x = NaN;
					memorize("_left");
					_left = NaN;
					memorize("_right");
					_right = NaN;
				}
				else {
					if (isNaN(_left) && isNaN(_right)) restore("_x");
				}
				if (ratio != RATIO_IN && ratio != RATIO_OUT) restore("_width");
				if (_autoRefresh) forceRefresh();
			}
			catch (e:Error) { trace(e); }
		}
		
		/**
		 * value from the center of the reference (stage or parent), align the ElementUI to the center on the y axis, Number or String
		 */
		public function get verticalCenter():Number {
			return _verticalCenter;
		}
		
		public function set verticalCenter(verticalCenter:*):void {
			try {
				if (ratio == RATIO_IN || ratio == RATIO_OUT) {
					if (!isNaN(verticalCenter)) throw new Error("Error in ElementUI " + _element.name + ": the verticalCenter property can't be used in mode RATIO_IN or RATIO_OUT");
				}
				verticalCenter = getValue(verticalCenter);
				memorize("_verticalCenter");
				_verticalCenter = verticalCenter;
				if (!isNaN(_verticalCenter)) {
					memorize("_y");
					_y = NaN;
					memorize("_top");
					_top = NaN;
					memorize("_bottom");
					_bottom = NaN;
				}
				else {
					if (isNaN(_top) && isNaN(_bottom)) restore("_y");
				}
				if (ratio != RATIO_IN && ratio != RATIO_OUT) restore("_height");
				if (_autoRefresh) forceRefresh();
			}
			catch (e:Error) { trace(e); }
		}
		
		/**
		 * width of the ElementUI, Number, String or percentage value
		 */
		public function get width():* {
			return _width;
		}
		
		public function set width(width:*):void {
			if (_ratio != RATIO_IN && _ratio != RATIO_OUT) {
				width = getValue(width);
				memorize("_width");
				_width = width;
				if (_autoRefresh) forceRefresh();
			}
		}
		
		public function get height():* {
			return _height;
		}
		
		/**
		 * height of the ElementUI, Number, String or percentage value
		 */
		public function set height(height:*):void {
			if (_ratio != RATIO_IN && _ratio != RATIO_OUT) {
				height = getValue(height);
				memorize("_height");
				_height = height;
				if (_autoRefresh) forceRefresh();
			}
		}
		
		/**
		 * width of the ElementUI that will be displayed on the screen (after calculation)
		 */
		public function get screenWidth():Number {
			return _screenWidth;
		}
		
		/**
		 * height of the ElementUI that will be displayed on the screen (after calculation)
		 */
		public function get screenHeight():Number {
			return _screenHeight;
		}
		
		/**
		 * set the stage as a reference to calculate position ans sizes, if false the parent will be the reference
		 */
		public function get onStage():Boolean {
			return _onStage;
		}
		
		public function set onStage(onStage:Boolean):void {
			_onStage = onStage;
			if (_autoRefresh) forceRefresh();
		}
		
		/**
		 * width of the DisplayObject when added to the BaseUI instance
		 */
		public function get initialWidth():Number {
			return _initialWidth;
		}
		
		public function set initialWidth(initialWidth:Number):void {
			_initialWidth = initialWidth;
			if (_autoRefresh) forceRefresh();
		}
		
		/**
		 * height of the DisplayObject when added to the BaseUI instance
		 */
		public function get initialHeight():Number {
			return _initialHeight;
		}
		
		public function set initialHeight(initialHeight:Number):void {
			_initialHeight = initialHeight;
			if (_autoRefresh) forceRefresh();
		}
		
		/**
		 * type of ratio of the ElementUI, can be ElementUI.RATIO_IN or ElementUI.RATIO_OUT<br/>
		 * any other String will set the ratio to none <br/>
		 * the following properties cannot be set or are not used a ratio has been specified:<br/>
		 * x, y, width, height, horizontalCenter and verticalCenter 
		 */
		public function get ratio():String {
			return _ratio;
		}
		
		public function set ratio(ratio:String):void {
			try {
				var oldRatio:String = _ratio;
				_ratio = ratio;
				if (ratio == RATIO_IN || ratio == RATIO_OUT) {
					if (oldRatio != RATIO_IN && oldRatio != RATIO_OUT) _memValuesBeforeRatio = {top:_top, bottom:_bottom, left:_left, right:_right, horizontalCenter:_horizontalCenter, verticalCenter:_verticalCenter};
					if (isNaN(_top)) restore("_top");
					if (isNaN(_right)) restore("_right");
					if (isNaN(_left)) restore("_left");
					if (isNaN(_bottom)) restore("_bottom");
					memorize("_width");
					_width = NaN;
					memorize("_height");
					_height = NaN;
					memorize("_x");
					_x = NaN;
					memorize("_y");
					_y = NaN;
					memorize("_horizontalCenter");
					_horizontalCenter = NaN;
					memorize("_verticalCenter");
					_verticalCenter = NaN;
					restore("_alignX");
					restore("_alignY");
				}
				else {
					if (_hasMask) removeMask();
					properties = _memValues;
					for (var prop:String in _memValuesBeforeRatio) {
						this[prop] = _memValuesBeforeRatio[prop];
					}
				}
				if (_autoRefresh) forceRefresh();
			}
			catch (e:Error) { trace(e.message); }
		}
		
		/**
		 * horizontal alignment when the property ratio is set to ElementUI.RATIO_IN or ElementUI.RATIO_OUT<br/>
		 * can accept ElementUI.ALIGN_LEFT, ElementUI.ALIGN_RIGHT, ElementUI.ALIGN_CENTER
		 */
		public function get alignX():String {
			return _alignX;
		}
		
		public function set alignX(alignX:String):void {
			if (alignX != ALIGN_LEFT && alignX != ALIGN_CENTER && alignX != ALIGN_RIGHT) {
				throw new Error("Error in ElementUI " + _element.name + ": the alignX property must be ElementUI.ALIGN_LEFT, ElementUI.ALIGN_CENTER or ElementUI.ALIGN_RIGHT");
			}
			memorize("_alignX");
			_alignX = alignX;
			if (_autoRefresh) forceRefresh();
		}
		
		/**
		 * vertical alignment when the property ratio is set to ElementUI.RATIO_IN or ElementUI.RATIO_OUT<br/>
		 * can accept ElementUI.ALIGN_CENTER, ElementUI.ALIGN_TOP, ElementUI.ALIGN_BOTTOM 
		 */
		public function get alignY():String {
			return _alignY;
		}
		
		public function set alignY(alignY:String):void {
			if (alignY != ALIGN_TOP && alignY != ALIGN_CENTER && alignY != ALIGN_BOTTOM) {
				throw new Error("Error in ElementUI " + _element.name + ": the alignY property must be ElementUI.ALIGN_TOP, ElementUI.ALIGN_CENTER or ElementUI.ALIGN_BOTTOM");
			}
			memorize("_alignY");
			_alignY = alignY;
			if (_autoRefresh) forceRefresh();
		}
		
		/**
		 * use the size that has been recorded when the DisplayObject has been added to the BaseUI instance<br/>
		 * useful when a mask or other DisplayObject can disturb the real size of the DisplayObject 
		 */
		public function get useInitialSize():Boolean {
			return _useInitialSize;
		}
		
		public function set useInitialSize(useInitialSize:Boolean):void {
			_useInitialSize = useInitialSize;
			if (_autoRefresh) forceRefresh();
		}
		
		/**
		 * return the BaseUI instance that has created the ElementUI
		 * @return BaseUI
		 */
		public function get baseUI():BaseUI {
			return _baseUI;
		}
		
		/**
		 * refresh the position and sizes, bypassing the refresh function
		 */
		public function forceRefresh():void {
			if (_element.stage != null) doRefresh();
		}
		
		/**
		 * refresh the position and sizes only if the the DisplayObject is visible or if the alpha property is superior to 0
		 */
		public function refresh():void {
			if (_element.alpha > 0 && _element.visible) forceRefresh();
		}
		
		/**
		 * return an Object containing the value memorized
		 */
		public function get memorized():Object {
			return _memValues;
		}
		
		/**
		 * Object to get or set the ElementUI properties, for example:<br/>
		 * <code>element.properties = {top:0, bottom:"20", onStage:false, width:"50%"};</code>
		 */
		public function get properties():Object {
			return {x:_x,
				y:_y,
				left:_left,
				horizontalCenter:_horizontalCenter,
				right:_right,
				top:_top,
				verticalCenter:_verticalCenter,
				bottom:_bottom,
				width:_width,
				height:_height,
				ratio:_ratio,
				alignX:_alignX,
				alignY:_alignY,
				reference:_reference,
				keepOnScreen:_keepOnScreen,
				forceReferenceWidth:_forceReferenceWidth,
				forceReferenceHeight:_forceReferenceHeight
			};
		}
		
		public function set properties(obj:Object):void {
			if (obj.hasOwnProperty("ratio")) _ratio = obj['ratio'];
			for (var prop:String in obj) {
				if (this.hasOwnProperty(prop) && prop != "ratio") this[prop] = obj[prop];
			}
			if (_autoRefresh) forceRefresh();
		}
		
		/**
		 * whether or not the ElementUI has a mask applied, used when the ratio is set to ElementUI.RATIO_OUT
		 * @return Boolean
		 */
		public function get hasMask():Boolean {
			return _hasMask;
		}
		
		/**
		 * get the Shape instance of the mask used when the ratio is set to ElementUI.RATIO_OUT
		 * @return Shape
		 */
		public function get bgMask():Shape {
			return _bgMask;
		}
		
		/**
		 * remove the mask when the ratio is set to ElementUI.RATIO_OUT, used internally in BaseUI
		 */
		public function dispose():void {
			removeEventListener(BaseEventUI.BEFORE_UPDATE, setValues, false);
			if (_hasMask) removeMask();
		}
		
		/**
		 * whether or not the DisplayObject will be resized (not working with ratio set to RATIO_IN or RATIO_OUT)
		 */
		public function get bypassSize():Boolean {
			return _bypassSize;
		}
		
		public function set bypassSize(bypassSize:Boolean):void {
			try {
				if (ratio == RATIO_IN || ratio == RATIO_OUT) throw new Error("Error in ElementUI " + _element.name + ": the bypassSize property can't be used in mode RATIO_IN or RATIO_OUT");
			}
			catch (e:Error) { trace(e.message); }
			_bypassSize = bypassSize;
			_useInitialSize = bypassSize;
		}
		
		/**
		 * specify a DisplayObjectContainer reference on which the size and position of the ElementUI will refer to<br/>
		 * if not set, the onStage property value is the reference (onStage true = stage, onStage false = parent)
		 */
		public function get reference():DisplayObjectContainer {
			return _reference;
		}
		
		public function set reference(reference:DisplayObjectContainer):void {
			_reference = reference;
		}
		
		/**
		 * keep a DisplayObject in the screen
		 */
		public function get keepOnScreen():Boolean {
			return _keepOnScreen;
		}
		
		public function set keepOnScreen(keepOnScreen:Boolean):void {
			_keepOnScreen = keepOnScreen;
		}
		
		/**
		 * force the width of the reference
		 */
		public function get forceReferenceWidth():Number {
			return _forceReferenceWidth;
		}
		
		public function set forceReferenceWidth(forceReferenceWidth:Number):void {
			_forceReferenceWidth = forceReferenceWidth;
		}
		
		/**
		 * force the height of the reference
		 */
		public function get forceReferenceHeight():Number {
			return _forceReferenceHeight;
		}
		
		public function set forceReferenceHeight(forceReferenceHeight:Number):void {
			_forceReferenceHeight = forceReferenceHeight;
		}
		
		/**
		 * whether or not the size/position of the DisplayObject is recalculate after a property change
		 * @default true
		 */
		public function get autoRefresh():Boolean {
			return _autoRefresh;
		}
		
		public function set autoRefresh(autoRefresh:Boolean):void {
			_autoRefresh = autoRefresh;
		}
	}
}