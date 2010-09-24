package com.ab.apps.appgenerics.core 
{
	/**
	* @author ABº
	*/
	
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import wumedia.vector.VectorText;
	
	public class VectorFontsManager extends Object
	{
		private var _loader:URLLoader;
		
		public function VectorFontsManager() 
		{
			
		}
		
		public function init():void
		{
			_loader 			= new URLLoader();
			_loader.dataFormat 	= URLLoaderDataFormat.BINARY;
			_loader.addEventListener(Event.COMPLETE, onLoaded);
			
			_loader.load(new URLRequest("assets/fonts/fonts.swf"));
		}
		
		private function onLoaded(e:Event):void 
		{
			_loader.removeEventListener(Event.COMPLETE, onLoaded);
			
			VectorText.extractFont(_loader.data, null, true);	
		}
		
		public function write(_graphics:Graphics, _text:String, _font:String, _colour:uint=0x00ff00, _size:Number=24, _leading:Number=0, _x:Number=0, _y:Number=0, _kerning:Number=0):void
		{
			_graphics.beginFill(_colour);
			
			VectorText.write(_graphics, _font, _size, _leading, _kerning, _text, _x, _y);
		}
		
	}

}