package com.ab.apps.abcms.mainmodules.configurators 
{
	/**
	* @author ABº
	*/
	
	import flash.text.TextFormat;
	
	public class ABCMSSiteTextFormats
	{
		public static function H1P():TextFormat
		{
			var _textformat:TextFormat 	= new TextFormat();
			var font:ArialMENUH2 		= new ArialMENUH2();
			
			_textformat.font  = font.fontName;
			_textformat.color = 0xFF66FF;
			_textformat.size  = 18;
			
			return _textformat;
		}
		public static function H2P():TextFormat
		{
			var _textformat:TextFormat 	= new TextFormat();
			var font:ArialMENUH2 		= new ArialMENUH2();
			
			_textformat.font  = font.fontName;
			_textformat.color = 0xFF66FF;
			_textformat.size  = 14;
			
			return _textformat;
		}
		public static function H3P():TextFormat
		{
			var _textformat:TextFormat 	= new TextFormat();
			var font:ArialMENUH2 		= new ArialMENUH2();
			
			_textformat.font  = font.fontName;
			_textformat.color = 0xFF66FF;
			_textformat.size  = 12;
			
			return _textformat;
		}
		
		public static function H2B():TextFormat
		{
			var _textformat:TextFormat 	= new TextFormat();
			var font:ArialMENUH2 		= new ArialMENUH2();
			
			_textformat.font  = font.fontName;
			_textformat.color = 0x0099FF;
			_textformat.size  = 14;
			
			return _textformat;
		}
		
		public static function T1():TextFormat
		{
			var _textformat:TextFormat 	= new TextFormat();
			var font:ArialMENUH2 		= new ArialMENUH2();
			
			_textformat.font  = font.fontName;
			_textformat.color = 0xCCCCCC;
			_textformat.size  = 10;
			
			return _textformat;
		}
		
		public static function WARNING():TextFormat
		{
			var _textformat:TextFormat 	= new TextFormat();
			var font:ArialMENUH2 		= new ArialMENUH2();
			
			_textformat.font  = font.fontName;
			_textformat.color = 0xFF0000;
			_textformat.size  = 14;
			
			return _textformat;
		}
		
	}
	
}