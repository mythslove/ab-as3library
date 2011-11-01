/** * This code is part of the Bumpslide Library by David Knape * http://bumpslide.com/ *  * Copyright (c) 2006, 2007, 2008 by Bumpslide, Inc. *  * Released under the open-source MIT license. * http://www.opensource.org/licenses/mit-license.php * see LICENSE.txt for full license terms */ package com.bumpslide.events {    import flash.events.Event;        /**     * Events fired from URLLoaderQueue     *      * @author David Knape     */    public class URLEvent extends Event {    	    	static public const ERROR:String = "urlError";    	static public const PROGRESS:String = "urlProgress";    	static public const COMPLETE:String = "urlComplete";    	    	private var _result:String;    	private var _message:String;    	private var _url:String;    	private var _data:*;    	private var _percentLoaded:*;            	    	        public function URLEvent(type:String, url:String, result:String="", data:*=null, message:String="", percentLoaded:Number=1)        {            super(type, false, false);            _url = url;            _result = result;            _data = data;            _message = message;            _percentLoaded = percentLoaded;        }                // requested url        public function get url():String        {            return _url;        }                // http result        public function get result ():String        {            return _result;        }                // app-specific data        public function get data ():String        {            return _data;        }                // Error Message        public function get message ():String        {            return _message;        }                public function get percentLoaded() : Number {            return _percentLoaded;        }    }}