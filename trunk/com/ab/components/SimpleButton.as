package com.ab.components
{
	import com.ab.display.geometry.PolygonQuad;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class SimpleButton extends Sprite
	{
		private var background_normal:PolygonQuad;
		private var background_over:PolygonQuad; 
		public var textField:TextField;
		
		private var up_textFormat:TextFormat;
		private var over_textFormat:TextFormat;
		
		public var button_text:String;
		
		/// parameters to be used in the constructor's "propertiesObject"
		private var button_width:Number     = 80;
		private var button_height:Number    = 20;
		private var text_size:int		   	= 14;
		private var text_colour:uint        = 0xffffff;
		private var up_text_colour:uint     = 0xffffff;
		private var over_text_colour:uint   = 0xffffff;
		private var text_font:String        = "HelveticaNeueCondensed";
		private var up_bg_colour:uint       = 0x0E0E0E;
		private var over_bg_colour:uint     = 0x1A1A1A;
		private var border_colour:uint      = 0xffffff;
		private var border_thickness:Number = 1;
		private var border_radius:Number    = 0;
		
		public function SimpleButton( button_text:String, propertiesObject:Object = null)
		{
			super();
			
			/**
			 * @Properties allowed in the button (send via propertiesObject)
			 * 
			 * example:  some_button = new SimpleButton("SEND", { text_size: 12, text_colour:0x00ff00 } );
			 * 
			 * text_size			:int
			 * text_colour			:int
			 * up_text_colour		:uint
			 * over_text_colour		:uint
			 * text_font			:String
			 * up_bg_colour			:uint
			 * over_bg_colour		:uint
			 * border_colour		:uint
			 * border_thickness		:Number
			 * border_radius		:Number
			 */
			
			for (var property:* in propertiesObject)
			{
				if (this[String(property)] != null) 
				{ 
					this[String(property)] = propertiesObject[String(property)]; 
				}
				else { trace("Warning: property not found: " + String(property)); }
			}
			
			this.button_text 				= button_text;
			
			background_normal 				= new PolygonQuad(button_width, button_height, up_bg_colour, border_radius, border_radius, border_thickness, border_colour);
			background_over					= new PolygonQuad(button_width, button_height, over_bg_colour, border_radius, border_radius, border_thickness, border_colour);
			
			background_over.visible 		= false;
			background_normal.visible 		= true;
			
			up_textFormat					= new TextFormat();
			up_textFormat.font 				= text_font;
			up_textFormat.size 				= text_size;
			up_textFormat.color 			= text_colour;
			up_textFormat.letterSpacing 	= 0.5;
			up_textFormat.align				= "center";
			up_textFormat.kerning 			= true;
			up_textFormat.leading 			= 3;
			
			over_textFormat					= new TextFormat();
			over_textFormat.font 			= text_font;
			over_textFormat.size 			= text_size;
			over_textFormat.color 			= over_text_colour;
			over_textFormat.letterSpacing 	= 0.5;
			over_textFormat.align			= "center";
			over_textFormat.kerning 		= true;
			over_textFormat.leading 		= 3;
			
			textField 						= new TextField();
			textField.embedFonts 			= true;
			textField.selectable 			= false;
			textField.wordWrap				= true;
			//textField.autoSize 			= TextFieldAutoSize.LEFT;
			textField.width					= button_width;
			textField.height 				= button_height;
			textField.text 					= button_text;
			
			textField.defaultTextFormat 	= up_textFormat;
			textField.setTextFormat(up_textFormat);
			
			textField.x 					= 0;
			textField.y 					= (button_height / 2) - (textField.height / 2);
			
			addChildAt(background_normal, 0);
			addChildAt(background_over, 1);
			addChildAt(textField, 2);
			
			this.buttonMode 					= true;
			this.mouseChildren 					= false;
			
			this.addEventListener(MouseEvent.ROLL_OVER, submitOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, submitOutHandler);
		}
		
		private function submitOutHandler(e:MouseEvent):void 
		{
			textField.defaultTextFormat = up_textFormat;
			textField.setTextFormat(up_textFormat);
			
			background_over.visible 			= false;
			background_normal.visible 			= true;
		}
		
		private function submitOverHandler(e:MouseEvent):void 
		{
			textField.defaultTextFormat = over_textFormat;
			textField.setTextFormat(over_textFormat);
			
			background_over.visible 			= true;
			background_normal.visible 			= false;
		}
	}
}