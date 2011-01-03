/**
 * This code is part of the Bumpslide Library by David Knape
 * http://bumpslide.com/
 * 
 * Copyright (c) 2006, 2007, 2008 by Bumpslide, Inc.
 * 
 * Released under the open-source MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 * see LICENSE.txt for full license terms
 */ 

package com.bumpslide.util {
	
	import flash.utils.describeType;

	/**
	 * Object Dumper (AS3)
	 * 
	 * This code was not written by David Knape, but he found it useful to keep around.
	 * The original version can be found at http://qops.blogspot.com/2007/06/dump-as3.html
	 */ 
	public class Dump {

		static var n:int = 0;
		static var str:String;

		// trace
		public static function Trace(o:Object):void {
			trace(object(o));
		}

		// return the result string
		public static function object(o:Object):String {
			str = "";
			dump(o);
			// remove the lastest \n
			str = str.slice(0, str.length - 1);
			return str;
		}

		static function dump(o:Object):void {
			if(n > 5) {
				str += "...recusion_limit..." + "\n"; 
				return;
			}
			n++;
			var type:String = describeType(o).@name;
			if(type == 'Array') {
				dumpArray(o);
			} else if (type == 'Object') {
				dumpObject(o);
			} else {
				appendStr(o);
			}
			n--;
		}

		static function appendStr(s:Object):void {
			str += s + '\n';
		}

		static function dumpArray(a:Object):void {
			var type:String;
			for (var i:String in a) {
				type = describeType(a[i]).@name;
				if (type == 'Array' || type == 'Object') {
					appendStr(getSpaces() + "[" + i + "]:");
					dump(a[i]);
				} else {
					appendStr(getSpaces() + "[" + i + "]:" + a[i]);
				}
			}
		}

		static function dumpObject(o:Object):void {
			var type:String;
			for (var i:String in o) {
				type = describeType(o[i]).@name;
				if (type == 'Array' || type == 'Object') {
					appendStr(getSpaces() + i + ":");
					dump(o[i]);
				} else {
					appendStr(getSpaces() + i + ":" + o[i]);
				}
			}
		}

		static function getSpaces():String {
			var s:String = "";
			for(var i:int = 1;i < n; i++) {
				s += "  ";
			}
			return s;
		}
	}
}