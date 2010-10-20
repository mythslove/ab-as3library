﻿/** * AS3 * Copyright 2009 __noponies__ */package com.noponies.events{	import flash.events.Event;	/**	 *Event subclass description.	 *	 *@langversion ActionScript 3.0	 *@playerversion Flash 9.0	 *	 *@author Dale Sattler	 *@since  15.01.2009	 */	public class NpAmfEvent extends Event {		//--------------------------------------		// CLASS CONSTANTS		//--------------------------------------		public static const RESULT:String = "result";		public static const FAULT:String = "fault";		//--------------------------------------		//  PRIVATE VARIABLES		//--------------------------------------		private var _resultObject:Object;		//--------------------------------------		//  GETTERS / SETTERS		//--------------------------------------		/**		 *Get / 		 *@default 2		 *@return Object		 */		public function get dbResult():Object {			return _resultObject;		}		/**		* @private		*/		public function set dbResult(newResultObject:Object):void {			_resultObject = newResultObject;		}				//--------------------------------------		//  CONSTRUCTOR		//--------------------------------------		/**		 *@constructor		 */		public function NpAmfEvent( type:String, bubbles:Boolean=true, cancelable:Boolean=false ) {			super(type, bubbles, cancelable);		}		//--------------------------------------		//  PUBLIC METHODS		//--------------------------------------		override public function clone():Event {			return new NpAmfEvent(type, bubbles, cancelable);		}		override public function toString():String {			return formatToString("NpAmfEvent","type","bubbles","cancelable","eventPhase");		}	}}