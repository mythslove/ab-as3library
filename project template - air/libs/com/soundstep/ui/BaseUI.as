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
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.display.Stage;
	import com.soundstep.ui.events.BaseEventUI;
	import com.soundstep.ui.ElementUI;
	import flash.events.FullScreenEvent;
	
	/**
	 * Dispatched when a display object has been added to the BaseUI instance.
	 * @eventType com.soundstep.ui.events.ADDED
	 */
	[Event(name="ADDED", type="com.soundstep.ui.events.BaseEventUI")]
	
	/**
	 * Dispatched when a display object has been removed from the BaseUI instance.
	 * @eventType com.soundstep.ui.events.REMOVED
	 */
	[Event(name="REMOVED", type="com.soundstep.ui.events.BaseEventUI")]
	
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
	 */
	 
	public class BaseUI extends EventDispatcher {
		
		//------------------------------------
		// private properties
		//------------------------------------
		
		// container holder of the BaseUI instance (such as the main class)
		private var _holder:DisplayObjectContainer;
		// array of the elements registered in the BaseUI instance
		private var _listElements:Array;
		// array of the elements registered in the BaseUI instance and added to the stage
		private var _listElementsToRender:Array;
		// Boolean, whether or not the resize listener has been created 
		private var _resizeListenerAdded:Boolean = false;
		// whether or not the DisplayObject is resized or positioned to the stage (false with the parent DisplayObject)  
		private var _onStage:Boolean = true;
		// specify a DisplayObjectContainer reference on which the size and position of the ElementUI will refer to<br/>
		// if not set, the onStage property value is the reference (onStage true = stage, onStage false = parent)
		private var _reference:DisplayObjectContainer = null;
		// the DisplayObject is kept in the screen
		private var _keepOnScreen:Boolean = true;
		// whether or not the size/position of the DisplayObject is recalculate after a property change
		private var _autoRefresh:Boolean = true;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Constructor
		 * Create an instance of the BaseUI class
		 * @param holder DisplayObjectContainer of the BaseUI instance that will contains the elements
		 */
		public function BaseUI(holder:DisplayObjectContainer) {
			_holder = holder;
			_listElements = [];
			_listElementsToRender = [];
		}
		
		//
		// PRIVATE, INTERNAL
		//________________________________________________________________________________________________
		
		/** @private */
		// triggered if an element has been added to the display list
		private function elementDisplayed(e:Event = null):void {
			if (e.currentTarget == e.target) {
				var el:ElementUI = getElement(DisplayObject(e.currentTarget));
				if (el != null) {
					addToRender(el);
				}
			}
		}
		
		/** @private */
		// add an ElementUI to the Render List
		private function addToRender(el:ElementUI):void {
			_listElementsToRender.push(el);
			addResizeListener();
			el.forceRefresh();
		} 
		
		/** @private */
		// triggered if an element has been removed to the display list
		private function elementUndisplayed(e:Event = null):void {
			if (e.currentTarget == e.target) {
				var el:ElementUI = getElement(DisplayObject(e.target));
				if (el != null) {
					removeFromRender(el);
				}
			}
		}
		
		/** @private */
		// remove an ElementUI from the Render List
		private function removeFromRender(el:ElementUI):void {
			for (var etr:uint=0; etr<_listElementsToRender.length; etr++) {
				if (el == _listElementsToRender[etr]) {
					_listElementsToRender.splice(etr, 1);
				}
				removeResizeListener();
			}
		}
		
		/** @private */
		// create the resize listener
		private function addResizeListener():void {
			if (!_resizeListenerAdded) {
				_holder.stage.addEventListener(Event.RESIZE, resizeHandler);
				
				_resizeListenerAdded = true;
				resizeHandler();
			}
		}
		
		/** @private */
		// remove the resize listener
		private function removeResizeListener():void {
			if (_listElementsToRender.length == 0) {
				_holder.stage.removeEventListener(Event.RESIZE, resizeHandler);
				_resizeListenerAdded = false;
			}
		}
		
		/** @private */
		// triggered by the resize listener
		private function resizeHandler(e:Event = null):void {
			updateUI();
		}
		
		/** @private */
		// update the list of elements that are in the display list
		private function updateUI():void {
			for (var li:uint = 0; li < _listElementsToRender.length; li++) {
				_listElementsToRender[li].refresh();
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * add a element to the BaseUI list (DisplayObject like Sprite, MovieClip, TextField, Bitmap, ...)
		 * @param element DisplayObject instance of the element to be added to the BaseUI list
		 * @return return an instance ElementUI
		 */
		public function add(displayObject:DisplayObject):ElementUI {
			for (var li:uint = 0; li < _listElements.length; li++) {
				if (displayObject == _listElements[li].element) {
					trace("The DisplayObject " + displayObject.name + " has been already added in the BaseUI instance");
					return null;
				}
			}
			displayObject.addEventListener(Event.ADDED_TO_STAGE, elementDisplayed);
			displayObject.addEventListener(Event.REMOVED_FROM_STAGE, elementUndisplayed);
			var el:ElementUI = new ElementUI(this, displayObject);
			el.onStage = _onStage;
			el.reference = _reference;
			el.keepOnScreen = _keepOnScreen;
			el.autoRefresh = _autoRefresh;
			_listElements.push(el);
			if (displayObject.stage != null) addToRender(el);
			dispatchEvent(new BaseEventUI(BaseEventUI.ADDED, el, null));
			return el;
		}
		
		/**
		 * remove a element from the BaseUI list
		 * @param element DisplayObject instance of the element to be removed from the BaseUI list
		 */
		public function remove(displayObject:DisplayObject):void {
			for (var i:uint = 0; i < _listElements.length; i++) {
				if (displayObject == _listElements[i].element) {
					
					_listElements[i].element.removeEventListener(Event.ADDED_TO_STAGE, elementDisplayed);
					_listElements[i].element.removeEventListener(Event.REMOVED_FROM_STAGE, elementUndisplayed);
					dispatchEvent(new BaseEventUI(BaseEventUI.REMOVED, _listElements[i], null));
					_listElements[i].dispose();
					_listElements[i] = null;
					_listElements.splice(i, 1);
					_listElementsToRender.splice(i, 1);
					removeResizeListener();
					return;
				}
			}
			throw new Error("Attempt remove: " + displayObject + " has not been found");
		}
		
		/**
		 * remove all elements from the BaseUI list
		 */
		public function removeAll():void {
			var rem:Array = [];
			for (var i1:uint=0; i1<_listElements.length; i1++) rem.push(_listElements[i1]);
			for (var i2:uint=0; i2<rem.length; i2++) remove(rem[i2].element);
		}
		/**
		 * get the ElementUI instance
		 * @param element DisplayObject instance of the DisplayObject
		 * @return return the ElementUI instance of the DisplayObject
		 */
		public function getElement(displayObject:DisplayObject):ElementUI {
			for (var i:uint=0; i<_listElements.length; i++) {
				if (displayObject == _listElements[i].element) return _listElements[i];
			}
			return null;
		}
		
		/**
		 * get the ElementUI list
		 * @return return an Array, the list of the elements registered in the BaseUI instance
		 */
		public function get elements():Array {
			return _listElements;
		}
		
		/**
		 * refresh all the elements
		 */
		public function refresh():void {
			updateUI();
		}
		
		/**
		 * return the holder
		 * @return return a DisplayObjectContainer
		 */
		public function get holder():DisplayObjectContainer {
			return _holder;
		}
		
		/**
		 * set the stage as a reference to calculate position ans sizes, if false the parent will be the reference
		 * this is a global default value applied on every DisplayObject added to the BaseUI instance, it can be overridden in each ElementUI instance
		 * @default true
		 */
		public function get onStage():Boolean {
			return _onStage;
		}
		
		public function set onStage(onStage:Boolean):void {
			_onStage = onStage;
		}
		
		/**
		 * specify a DisplayObjectContainer reference on which the size and position of the ElementUI will refer to<br/>
		 * if not set, the onStage property value is the reference (onStage true = stage, onStage false = parent)
		 * this is a global default value applied on every DisplayObject added to the BaseUI instance, it can be overridden in each ElementUI instance
		 */
		public function get reference():DisplayObjectContainer {
			return _reference;
		}
		
		public function set reference(reference:DisplayObjectContainer):void {
			_reference = reference;
		}
		
		/**
		 * keep a DisplayObject in the screen<br/>
		 * this is a global default value applied on every DisplayObject added to the BaseUI instance, it can be overridden in each ElementUI instance
		 * @default true
		 */
		public function get keepOnScreen():Boolean {
			return _keepOnScreen;
		}
		
		public function set keepOnScreen(keepOnScreen:Boolean):void {
			_keepOnScreen = keepOnScreen;
		}
		
		/**
		 * whether or not the BaseUI instance contains the DisplayObject
		 * @return Boolean
		 */
		public function contains(displayObject:DisplayObject):Boolean {
			if (getElement(displayObject) is ElementUI) return true;
			else return false;
		}
		
		/**
		 * whether or not the size/position of the DisplayObject is recalculate after a property change<br/>
		 * this is a global default value applied on every DisplayObject added to the BaseUI instance, it can be overridden in each ElementUI instance
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