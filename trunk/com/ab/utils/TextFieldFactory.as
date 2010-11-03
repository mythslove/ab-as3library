package com.ab.utils 
{
	/**
	* @author ABº
	*/
	
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class TextFieldFactory
	{
		
		public function TextFieldFactory() 
		{
			
		}
		
		public static function createTextField(text:String="", font:String="Arial", size:int=12, colour:uint=0xffffff, width:Number=100, autosize:String="left", multiline:Boolean=true, wordwrap:Boolean=true, embedfonts:Boolean=true, sharpness:int=200):TextField
		{
			var _text_fmt:TextFormat 		= new TextFormat();
			_text_fmt.font 					= font;
			_text_fmt.size 					= size;
			_text_fmt.color					= colour;
			
			var new_textfield:TextField 	= new TextField();
			new_textfield.width 			= width;
			new_textfield.autoSize 			= autosize;
			new_textfield.wordWrap 			= wordwrap;
			new_textfield.selectable		= false;
			new_textfield.condenseWhite		= true;
			new_textfield.multiline			= multiline;
			new_textfield.embedFonts		= embedfonts;
			new_textfield.sharpness			= sharpness;
			new_textfield.defaultTextFormat = _text_fmt;
			new_textfield.antiAliasType 	= AntiAliasType.ADVANCED;
			
			if (text != "")  				{ new_textfield.htmlText = text; }
			
			new_textfield.x = 0;
			new_textfield.y = 0;
			new_textfield.z = 0;
			
			return new_textfield;
		}
		
	}

}