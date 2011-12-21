package com.ab.components 
{
	/**
	 * @author Antonio Brandao
	 * 
	 * @Properties allowed in this component (send via propertiesObject parameter)
	 * 
	 * example:  some_textfield = new EasyTextField("SEND", { text_size: 12, text_colour:0x00ff00 } );
	 * 
	 * // textfield
	 * textfield_width		:Number   ::: provide 0 (zero) along with a TextFieldAutoSize other than "none" for automatic
	 * textfield_height		:Number
	 * embed_fonts			:Boolean
	 * condensewhite		:Boolean
	 * selectable			:Boolean
	 * text_autosize		:TextFieldAutoSize
	 * multiline			:Boolean;
	 * type					:String;
	 * 
	 * // textformat
	 * text_font			:String
	 * text_size			:int
	 * text_colour			:uint
	 * multiline			:Boolean
	 * text_align			:TextFormatAlign
	 * 
	 * // background
	 * use_background		:Boolean
	 * bg_colour			:uint
	 * border_colour		:uint
	 * border_thickness		:Number
	 * border_radius		:Number
	 * 
	 * // rollover options
	 * use_rollover			:Boolean
	 * over_text_colour		:uint
	 * over_bg_colour		:uint
	 */
	
	import com.ab.display.geometry.PolygonQuad;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class EasyTextField extends Sprite
	{
		// functionality
		private var use_rollover:Boolean		= false;
		private var display_text:String;
		
		// publicly available
		public var text_field:TextField;
		public var text_format:TextFormat;
		
		/// parameters to be used in the constructor's "propertiesObject"
		// textfield related
		private var textfield_width:Number		= 80;
		private var textfield_height:Number		= 20;
		private var embed_fonts:Boolean 		= true;
		private var condensewhite:Boolean 		= true;
		private var selectable:Boolean			= false;
		private var text_autosize:String		= TextFieldAutoSize.LEFT;
		private var multiline:Boolean 			= false;
		private var type:String 				= TextFieldType.DYNAMIC;
		
		// text format related
		private var over_text_format:TextFormat;
		private var text_font:String			= "HelveticaNeueCondensed";
		private var text_size:int				= 14;
		private var text_colour:uint			= 0xffffff;
		private var text_align:String			= TextFormatAlign.LEFT;
		private var over_text_colour:uint		= 0xffffff;
		
		// background related
		private var background:PolygonQuad;
		private var background_over:PolygonQuad;
		private var use_background:Boolean		= false;
		private var bg_colour:uint				= 0x0E0E0E;
		private var over_bg_colour:uint			= 0x1A1A1A;
		private var border_colour:uint			= 0xffffff;
		private var over_border_colour:uint		= 0xffffff;
		private var border_thickness:Number		= 1;
		private var border_radius:Number		= 0;
		
		public function EasyTextField(display_text:String, propertiesObject:Object = null) 
		{
			this.display_text = display_text;
			
			
			for (var property:* in propertiesObject)
			{
				if (this[String(property)] != null) 
				{ 
					this[String(property)] = propertiesObject[String(property)]; 
				}
				else { trace("Warning: property not found: " + String(property)); }
			}
			
			text_format 		 		= new TextFormat();
			text_format.font 			= text_font;
			text_format.size 			= text_size;
			text_format.color 			= text_colour;
			text_format.align			= text_align;
			text_format.letterSpacing 	= 0.5;
			text_format.kerning 		= true;
			text_format.leading 		= 3;
			
			text_field 					= new TextField();
			if (textfield_width != 0)  	{ text_field.width = textfield_width; }
			text_field.height 			= textfield_height;
			text_field.embedFonts 		= embed_fonts;
			text_field.condenseWhite	= condensewhite;
			text_field.selectable 		= selectable;
			text_field.autoSize 		= text_autosize;
			text_field.multiline 		= multiline;
			text_field.type 			= type;
			
			trace ("EasyTextField ::: selectable = " + selectable);
			
			trace ("EasyTextField ::: text_field.selectable = " + text_field.selectable);
			
			text_field.text 			= display_text;
			
			text_field.setTextFormat(text_format);
			
			if (use_background) 
			{
				background = new PolygonQuad(textfield_width+3, textfield_height, bg_colour, border_radius, border_radius, border_thickness, border_colour);
				
				addChild(background);
				
				if (!multiline) 
				{
					text_field.y = (background.height / 2 - (text_field.getLineMetrics(0).height / 2)) - text_field.getLineMetrics(0).leading + (text_field.getLineMetrics(0).leading / 4);
				}
				
				text_field.x = 3;
				
				if (use_rollover) 
				{
					background_over	= new PolygonQuad(textfield_width+3, textfield_height, over_bg_colour, border_radius, border_radius, border_thickness, over_border_colour);
					
					background_over.visible = false;
					
					addChild(background_over);
				}
			}
			
			if (use_rollover) 
			{
				this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true);
				this.addEventListener(MouseEvent.ROLL_OUT,  rollOutHandler,  false, 0, true);
				
				over_text_format 		 		= new TextFormat();
				over_text_format.font 			= text_font;
				over_text_format.size 			= text_size;
				over_text_format.color 			= over_text_colour;
				over_text_format.align			= text_align;
				over_text_format.letterSpacing 	= 0.5;
				over_text_format.kerning 		= true;
				over_text_format.leading 		= 3;
			}
			
			addChild(text_field);
		}
		
		private function rollOutHandler(e:MouseEvent):void 
		{
			text_field.setTextFormat(text_format);
			
			if (use_background) 
			{
				background.visible 		= true;
				background_over.visible = false;
			}
		}
		
		private function rollOverHandler(e:MouseEvent):void 
		{
			text_field.setTextFormat(over_text_format);
			
			if (use_background) 
			{
				background.visible 		= false;
				background_over.visible = true;
			}
		}
		
	}

}