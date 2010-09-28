/*
VERSION: 0.94
DATE: 11/6/2008
ACTIONSCRIPT VERSION: 3.0
DESCRIPTION: 
	 This class provides an easy way to load and/or send an XML file and parse the data into a format that's simple 
	 to work with. Every node becomes an array with the same name. All attributes are also easily accessible because 
	 they become properties with the same name. So for example, if this is your XML:
	 
		<Resources>
			<Book name="Mary Poppins" ISDN="1122563" />
			<Book name="The Bible" ISDN="333777" />
			<Novel name="The Screwtape Letters" ISDN="257896">
				<Description>This is an interesting perspective</Description>
			</Novel>
		</Resources>
	 
	 Then you could access the first book's ISDN with:
	 
	 	Book[0].ISDN
	 
	 The value of a node (like the text between the <Description> and </Description> tags above can
	 be accessed using the "nodeValue" property, like so:
	 
	 	Novel[0].Description[0].nodeValue
	 
	 Just remember that all nodes become arrays even if there's only one node, and attributes become properties. 
	 You can obviously loop through the arrays too which is very useful. The root node is ignored for efficiency 
	 (less code for you to write) unless you set the keepRootNode to true.

EXAMPLE: 
	To simply load a "myDocument.xml" document and parse the data into Object/Array values, do:
	
		import gs.dataTransfer.XMLManager;
		XMLManager.load("myDocument.xml", onFinish);
		function onFinish($results:Object):void { //This function gets called when the XML gets parsed.
			if ($results.success) {
				trace("The first book is: "+$results.parsedObject.Book[0].name);
			} else {
				trace("There was an error.");
			}
		}
		
	Or to send an object to the server in XML format (remember, each element in an array becomes a node and all 
	object properties become node attributes) and load the results back into an ActionScript-friendly format, do:
	
		import gs.dataTransfer.XMLManager;
		//Create an object to send an populate it with values...
		var toSend = new Object();
		toSend.name = "Test Name";
		toSend.Book = new Array();
		toSend.Book.push({title:"Mary Poppins", ISDN:"125486523"});
		toSend.Book.push({title:"The Bible", ISDN:"25478866998"});
		//Now send the data and load the results from the server into the response_obj...
		XMLManager.sendAndLoad(toSend, "http://www.myDomain.com/myScript.php", onFinish);
		function onFinish($results:Object):void {
			if ($results.success) {
				trace("The server responded with this XML: " + $results.xml);
				trace("The server's response was translated into this ActionScript object: " + $results.parsedObject);
			}
		}
		
		In the example above, the server would receive the following XML document:
		
		<XML name="Test Name">
			<Book ISDN="125486523" title="Mary Poppins" />
			<Book ISDN="25478866998" title="The Bible" />
		</XML>
	
NOTES:
	- It is case sensitive, so if you run into problems, check that.
	- The value of any text node can be accessed with the "nodeValue" property as mentioned above.
	- A valid XML document requires a single root element, so in order to consolidate things,
	  That root will be ignored in the resulting arrays. So if your root element is <Library>
	  and it has <Book> nodes, you don't have to access them with Library[0].Book[0]. You can 
	  just do Book[0]. That is, unless you set the keepRootNode property to true.
	- You can simply translate an object into XML (without sending it anywhere) using the 
	  XMLManager.objectToXML(myObject) function which returns an XML instance.
	- Cancel the loading of an XML file using the cancel() method.
		
CODED BY: Jack Doyle, jack@greensock.com
Copyright 2008, GreenSock (This work is subject to the terms in http://www.greensock.com/terms_of_use.html.)
*/

package gs.dataTransfer {
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	public class XMLManager extends EventDispatcher {
		public var keepRootNode:Boolean = false;
		public var parseLineBreaks:Boolean = false;
		private var _loaded:Boolean = false;
		private var _request:URLRequest;
		private var _onComplete:Function;
		private var _loader:URLLoader;
		private var _xml:XML;
		private static var _all:Array = [];
		
		public function XMLManager() {
			XML.ignoreWhitespace = XML.ignoreComments = true;
			_loader = new URLLoader();
			setupListeners();
			_all.push(this);
		}
		
		public static function load($xmlUrl:String, $onComplete:Function = null, $keepRootNode:Boolean = false, $parseLineBreaks:Boolean = false):XMLManager {
			var parser:XMLManager = new XMLManager();
			parser.initLoad($xmlUrl, $onComplete, $keepRootNode, $parseLineBreaks);
			return parser;
		}
		
		public static function sendAndLoad($toSend:Object, $xmlUrl:String, $onComplete:Function = null, $keepRootNode:Boolean = false, $parseLineBreaks:Boolean = false):XMLManager {
			var parser:XMLManager = new XMLManager();
			parser.initSendAndLoad($toSend, $xmlUrl, $onComplete, $keepRootNode, $parseLineBreaks);
			return parser;
		}
		
		public function initLoad($xmlUrl:String, $onComplete:Function = null, $keepRootNode:Boolean = false, $parseLineBreaks:Boolean = false):void {
			_request = new URLRequest($xmlUrl);
			_onComplete = $onComplete;
			this.keepRootNode = $keepRootNode;
			this.parseLineBreaks = $parseLineBreaks;
			_xml = new XML();
			_loaded = false;
			_loader.load(_request);
		}
		
		private function setupListeners():void {
			_loader.addEventListener(Event.COMPLETE, parseLoadedXML);
			_loader.addEventListener(Event.OPEN, onEvent);
            _loader.addEventListener(ProgressEvent.PROGRESS, onEvent);
            _loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onEvent);
            _loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function onSecurityError($e:SecurityErrorEvent):void {
			trace("Security error while loading "+_request.url);
			_onComplete({target:this, success:false});
			//onEvent($e);
		}
		
		private function onIOError($e:IOErrorEvent):void {
			trace("IO error while loading "+_request.url);
			_onComplete({target:this, success:false});
			//onEvent($e); //Will STOP all progress! 
		}
		
		private function onEvent($e:*):void {
			dispatchEvent($e);
		}
		
		public function initSendAndLoad($toSend:Object, $xmlUrl:String, $onComplete:Function, $keepRootNode:Boolean = false, $parseLineBreaks:Boolean = false):void {
			_request = new URLRequest($xmlUrl);
			_onComplete = $onComplete;
			this.keepRootNode = $keepRootNode;
			this.parseLineBreaks = $parseLineBreaks;
			var xmlToSend:XML;
			if ($toSend is XML) {
				xmlToSend = $toSend as XML;
			} else {
				xmlToSend = objectToXML($toSend);
			}
			_xml = new XML();
			_loaded = false;
			_request.contentType = "text/xml";
			_request.data = _xml.toXMLString();
			_request.method = URLRequestMethod.POST;
			_loader.load(_request);
		}		
	
		protected function parseLoadedXML($e:Event):void {
			_loader.removeEventListener(Event.COMPLETE, parseLoadedXML);
			var loader:URLLoader = $e.target as URLLoader;
			if (loader == null) {
				_onComplete({target:this, success:false});
				onEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, "Failed to load the XML"));
				return;
			}
			_xml = new XML(loader.data);
			var parsedObject:Object = XMLToObject(_xml, this.keepRootNode, this.parseLineBreaks);
			_onComplete({target:this, success:true, parsedObject:parsedObject, xml:_xml});
		}
		
		
		public static function XMLToObject($xml:XML, $keepRootNode:Boolean = false, $parseLineBreaks:Boolean = false):Object { 
			var obj:Object = {};
			var objLookup:Array = []; //A way to keep track of each node's parent object. Tried using a Dictionary at first (which would have been easier/faster), but there was a bug that prevented it from looking XML object up conistently!
			var c:XML = $xml.copy();
			var lastNode:XML = c;
			
			if (!$keepRootNode) {
				lastNode = c.children()[c.children().length() - 1];
				c = c.children()[0];
			}
			
			var o:Object, attributes:XMLList, attr:XML, nextNode:XML, po:Object; //parent object
			while (c != null) {
				if (c.nodeKind() == "element") {
					o = {};
					if (c.text().toString() != "") {
						o.nodeValue = clean(c.text().toString(), $parseLineBreaks);
					}
					attributes = c.attributes();
					for each (attr in attributes) {
						o[attr.name().toString()] = clean(attr, $parseLineBreaks);
					}
					if (c.parent() == undefined) { //If it's the root node, it won't have a parent!
						po = obj;
					} else {
						po = objLookup[c.parent().@_objLookupIndex] || obj;
					}
					if (po[c.name()] == undefined) {
						po[c.name()] = [];
					}
					po[c.name()].push(o);
					c.@_objLookupIndex = objLookup.length;
					objLookup.push(o);
				}
				
				if (c.children().length() != 0) {
					c = c.children()[0];
				} else {
					nextNode = c;
					while (nextNode.parent() != undefined && nextNode.parent().children().length() < nextNode.childIndex() + 2) {
						nextNode = nextNode.parent();
					}
					if (nextNode.parent() != undefined && nextNode != lastNode) {
						c = nextNode.parent().children()[nextNode.childIndex() + 1];
					} else {
						c = null;
					}
				}
			}
			return obj;
		}
		
		private static function clean($s:String, $parseLineBreaks:Boolean = false):Object {
			if (!isNaN(Number($s)) && $s != "" && $s.substr(0, 1) != "0") {
				return Number($s);
			} else if ($parseLineBreaks) {
				return $s.split("\\n").join("\n");
			} else {
				return $s;
			}
		}
		
		//Allows us to translate an object (typically with arrays attached to it) back into an XML object. This is useful when we need to send it back to the server or save it somewhere.
		public static function objectToXML($o:Object, $rootNodeName:String = "XML"):XML {
			var xml:XML = new XML("<" + $rootNodeName + " />");
			var n:XML = xml;
			var props:Array = [];
			var i:int, prop:*, p:String;
			for (p in $o) {
				props.push(p);
			}
			for (i = props.length - 1; i > -1; i--) { //By default, attributes are looped through in reverse, so we go the opposite way to accommodate for this.
				prop = props[i];
				if ($o[prop] is Array) { //Means it's an array!
					if ($o[prop].length != 0) {
						arrayToNodes($o[prop], n, xml, prop);
					}
				} else if (prop == "nodeValue") {
					n.appendChild(new XML($o.nodeValue));
				} else {
					n.@[prop] = $o[prop];
				}
			}
			return xml;
		}
		
		//Recursive function that walks through any sub-arrays as well...
		protected static function arrayToNodes($a:Array, $parentNode:XML, $xml:XML, $nodeName:String):void {
			var chldrn:Array = [];
			var props:Array, prop:String, n:XML, o:Object, i:int, j:int, p:String;
			for (i = $a.length - 1; i >= 0; i--) {
				n = new XML("<" + $nodeName + " />");
				o = $a[i];
				props = [];
				for (p in o) {
					props.push(p);
				}
				for (j = props.length - 1; j >= 0; j--) { //By default, attributes are looped through in reverse, so we go the opposite way to accommodate for this.
					prop = props[j];
					if (o[prop] is Array) { //Means it's an array!
						arrayToNodes(o[prop], n, $xml, prop);
					} else if (prop != "nodeValue") {
						n.@[prop] = o[prop];
					} else {
						n.appendChild(new XML(o.nodeValue));
					}
				}
				chldrn.push(n);
			}
			for (i = chldrn.length - 1; i >= 0; i--) {
				$parentNode.appendChild(chldrn[i]);
			}
		}
		
		public function cancel():void {
			_loader.close();
		}
		
		public function destroy():void {
			cancel();
			_xml = new XML();
			for (var i:int = _all.length - 1; i >= 0; i--) {
				if (this == _all[i]) {
					_all.splice(i, 1);
					break;
				}
			}
		}
		
		
	//---- GETTERS / SETTERS --------------------------------------------------------------------
		
		public static function get active():Boolean {
			if (_all.length > 0) {
				return true;
			} else {
				return false;
			}
		}
		
		public function get progress():Number {
			return (this.bytesLoaded / this.bytesTotal)
		}
		
		public function get percentLoaded():Number {
			return (this.bytesLoaded / this.bytesTotal) * 100;
		}
		
		public function get xml():XML {
			return _xml;
		}
		
		public function get bytesLoaded():Number {
			return _loader.bytesLoaded || 0;
		}
		
		public function get bytesTotal():Number {
			if (_loaded) {
				return _loader.bytesTotal || 0;
			} else {
				return _loader.bytesTotal || 1024; //We should report back some size for preloaders so that if they do something like (my_mc.getBytesLoaded() + myParser_obj.bytesLoaded) / (my_mc.getBytesTotal() + myParser_obj.bytesTotal) because it might look like it's 100% loaded even though it hasn't started yet!
			}
			
		}
		
	}
}