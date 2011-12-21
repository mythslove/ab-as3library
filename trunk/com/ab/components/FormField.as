package com.ab.components
{
	/**
	* @author Antonio Brandao
	*/
	
	import com.ab.display.geometry.PolygonQuad;
	import com.ab.ui.SimpleScrollPane;
	import com.ab.utils.ABStringUtils;
	import com.kaltura.kdpfl.util.emailValidator;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class FormField extends Sprite
	{
		public var input_textfield:TextField;
		public var is_correct_entry:Boolean = false;
		
		private var default_width:Number;
		private var default_height:Number;
		
		private var textformat_input:TextFormat;
		
		private var input_background:PolygonQuad;
		private var input_backgroundblur:Sprite;
		private var has_focus:Boolean=false;
		
		private var warning_colour:uint=0xFF1F06;
		private var correct_colour:uint=0x32A800;
		
		public var scrollpane:SimpleScrollPane;
		
		public var display_text:String;
		public var mandatory:Boolean;
		private var email:Boolean;
		private var multiline:Boolean;
		private var main_headline:TextField;
		private var bg_colour:uint;
		private var border_thickness:Number;
		private var border_colour:uint;
		private var border_radius:Number;
		private var inner_glow_colour:uint;
		private var use_inner_glow:Boolean;
		private var text_colour:uint;
		private var text_size:int;
		
		public function FormField(  display_text:String, 
									default_width:Number, 
									default_height:Number, 
									text_colour:uint 		= 0xffffff, 
									text_size:int 			= 12, 
									multiline:Boolean 		= false, 
									email:Boolean 			= false, 
									mandatory:Boolean 		= false, 
									bg_colour:uint 			= 0x000000, 
									border_colour:uint 		= 0xffffff, 
									border_thickness:Number = 1, 
									border_radius:Number 	= 0, 
									use_inner_glow:Boolean 	= false, 
									inner_glow_colour:uint 	= 0xffffff )
		{
			super();
			
			// get parameters
			this.display_text 		= display_text;
			this.default_width 		= default_width;
			this.default_height 	= default_height;
			this.multiline			= multiline;
			this.email				= email;
			this.mandatory			= mandatory;
			this.bg_colour 			= bg_colour;
			this.border_thickness 	= border_thickness;
			this.border_colour 		= border_colour;
			this.border_radius 		= border_radius;
			this.use_inner_glow 	= use_inner_glow;
			this.inner_glow_colour 	= inner_glow_colour;
			this.text_colour 		= text_colour;
			this.text_size 			= text_size;
			
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			createTextFields();
			
			build();
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDownHandler);
		}
		
		private function createTextFields():void 
		{
			var textformat_input:TextFormat 	= new TextFormat();
			textformat_input.font 				= "HelveticaNeueLT57Cn";
			textformat_input.size 				= text_size;
			textformat_input.color 				= text_colour;
			textformat_input.letterSpacing 		= 0.5;
			textformat_input.kerning 			= true;
			textformat_input.leading 			= 3;
			
			input_textfield 					= new TextField();
			input_textfield.type 				= TextFieldType.INPUT;
			input_textfield.embedFonts 			= true;
			input_textfield.selectable 			= true;
			input_textfield.autoSize 			= TextFieldAutoSize.LEFT;
			//input_textfield.width 				= default_width - 10;
			input_textfield.width 				= default_width;
			input_textfield.height 				= input_textfield.getLineMetrics(0).height;
			input_textfield.multiline 			= multiline;
			input_textfield.wordWrap			= true;
			
			trace ("FormField ::: input_textfield.multiline = " + input_textfield.multiline);
			
			input_textfield.text 				= display_text;
			
			input_textfield.defaultTextFormat 	= textformat_input;
			
			input_textfield.addEventListener(FocusEvent.FOCUS_IN,  focusInHandler);
			input_textfield.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
		}
		
		private function build():void 
		{
			input_background = new PolygonQuad(default_width, default_height, bg_colour, border_radius, border_radius, border_thickness, border_colour);
			
			if (use_inner_glow) 
			{
				input_backgroundblur 		 = new PolygonQuad(default_width - 4, default_height - 4, bg_colour, border_radius, 3);
				input_backgroundblur.x 		 = 2;
				input_backgroundblur.y 		 = 2;
				input_backgroundblur.filters = [new GlowFilter(inner_glow_colour, 0.2, 6, 6, 4, BitmapFilterQuality.HIGH, true)];
				input_backgroundblur.alpha 	 = 0.5;
			}
			
			input_textfield.text 			= display_text;
			input_textfield.width 			= input_background.width - 24;
			
			addChild(input_background);
			if (use_inner_glow)  			{ addChild(input_backgroundblur); }
			
			if (multiline)
			{
				scrollpane 			= new SimpleScrollPane(input_textfield, default_width-8, default_height-8, 8, 0xffffff);
				scrollpane.x 		= 3;
				scrollpane.y 		= 3;
				
				addChild(scrollpane);
			}
			else
			{
				addChild(input_textfield);
				input_textfield.x = 5;
				input_textfield.y = 4;
			}
		}
		
		private function stageMouseDownHandler(e:MouseEvent):void 
		{
			if (has_focus == true) 
			{
				if (e.target != input_textfield) 
				{
					if (e.target is TextField) 
					{
						// nada
					}
					else
					{
						stage.focus = null;
					}
					
					has_focus  = false;
				}
			}
			else
			{
				if (use_inner_glow) 
				{
					if (e.target == this.input_backgroundblur) 
					{
						has_focus   = true;
						stage.focus = input_textfield;
					}
				}
				else
				{
					if (e.target == this.input_background) 
					{
						has_focus   = true;
						stage.focus = input_textfield;
					}
				}
				
				
			}
		}
		
		private function focusInHandler(e:FocusEvent):void 
		{
			has_focus = true;
			
			if (input_textfield.text == display_text || ABStringUtils.isOnlyWhiteSpace(input_textfield.text))
			{
				input_textfield.text = "";
			}
		}
		
		private function focusOutHandler(e:FocusEvent):void 
		{
			has_focus = false;
			
			if (input_textfield.text == display_text || ABStringUtils.isOnlyWhiteSpace(input_textfield.text))
			{
				resetLineColour();
				input_textfield.text = display_text;
				is_correct_entry = false;
			}
			else
			{
				if(email)
				{
					if(!emailValidator.isValidEmail(input_textfield.text))
					{
						changeLineColour(warning_colour);
						is_correct_entry = false;
					}
					else
					{
						resetLineColour();
						is_correct_entry = true;
					}
				}
				else
				{
					resetLineColour();
					is_correct_entry = true;
				}
			}
		}
		
		private function changeLineColour(val:uint):void
		{
			if(!val)
				return;
			input_background._line_colour = val;
			input_background.design();
		}
		
		private function resetLineColour():void 
		{
			input_background._line_colour = input_background.getOriginalValue("_line_colour");
			input_background.design();
		}
		
		public function reset():void
		{
			input_textfield.text = display_text;
			
			resetLineColour();
		}
		
		/// VALIDATION
		/// VALIDATION
		/// VALIDATION
		
		public function validate():Boolean
		{
			if (mandatory) 
			{
				if (input_textfield.text == display_text || ABStringUtils.isOnlyWhiteSpace(input_textfield.text) == true || input_textfield.text == "")
				{
					return false;
				}
				
				if (email) 
				{
					return validateEmail(input_textfield.text);
				}
			}
			
			return true;
		}
		
		public static function validateEmail(str:String):Boolean 
		{
			var emailExpression:RegExp = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			return emailExpression.test( str );
		}
	}
}