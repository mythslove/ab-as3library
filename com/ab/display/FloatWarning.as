package com.ab.display 
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.properties.FilterShortcuts;
	import caurina.transitions.Tweener;
	import com.ab.core.AppManager;
	import com.ab.display.geometry.PolygonQuad;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import org.casalib.display.CasaSprite;
	 
	
	public class FloatWarning extends CasaSprite
	{
		/// static
		public static var ORIGIN_TOP:String 	= "origin_top";
		public static var ORIGIN_BOTTOM:String 	= "origin_bottom";
		
		/// static
		public static var TYPE_NORMAL:String 	= "type_normal";
		public static var TYPE_WARNING:String 	= "type_warning";
		public static var TYPE_ERROR:String 	= "type_error";
		
		/// main
		private var _message:String;
		private var _warning_type:String = "normal";
		private var _time:Number;
		private var _origin:String;
		private var _bg_colour:uint;
		private var _text_colour:uint;
		
		/// sys
		public var aux_var:Number;
		
		public function FloatWarning(_message:String, _type:String="type_normal", _origin:String="origin_top", _time:Number=2, _bg_colour:uint=0x000000, _text_colour:uint=0x00FF00)
		{
			/// "normal" or "error" types may be used
			
			message 		= _message;
			warning_type	= _type;
			time			= _time;
			origin 			= _origin;
			bg_colour 		= _bg_colour;
			text_colour		= _text_colour;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			var tf:TextField 			= new TextField();
			var tf_format:TextFormat 	= new TextFormat("Arial");
			
			tf.autoSize 				= TextFieldAutoSize.LEFT;
			tf.condenseWhite			= true;
			tf.text 					= _message;
			
			tf_format.bold	 			= true;
			
			switch (_warning_type) 
			{
				case TYPE_NORMAL:	tf_format.color	= 0x00FF00; break;
				case TYPE_ERROR: 	tf_format.color	= 0xFF0000; break;
				case TYPE_WARNING: 	tf_format.color	= 0xFF6600; break;
				default:			tf_format.color	= 0x00FF00;
			}
			
			tf.setTextFormat(tf_format);
			
			var bg:Sprite 				= new Sprite();
			var bg_graph:PolygonQuad 	= new PolygonQuad(tf.width + 10, tf.height + 10, bg_colour)
			
			bg_graph.x 					= -5;
			bg_graph.y 					= -5;
			
			this.addChildAt(bg, 0);
			this.addChildAt(tf, 1);
			bg.addChild(bg_graph);
			
			this.alpha 	= 0;
			this.x 		= AppManager.stage.stageWidth / 2 - this.width / 2;
			
			switch (origin)
			{
				case "origin_top":
					
					this.y = -100;
					Tweener.addTween(this, { alpha:1, y:10, time:0.5 } );
					
				break;
				
				case "origin_bottom":
					
					this.y = stage.stageHeight;
					Tweener.addTween(this, { alpha:1, y:stage.stageHeight - this.height -10, time:0.5 } );
					
				break;
			}
			
			/// make time and go away
			
			aux_var = 0;
			
			Tweener.addTween(this, { aux_var:1, time:time, onComplete:startClose } );
		}
		
		private function startClose():void
		{
			Tweener.resumeTweens(this);
			
			switch (origin) 
			{
				case FloatWarning.ORIGIN_TOP:
					
					Tweener.addTween(this, { alpha:0, time:1, y:-100, transition:"EaseInSine", onComplete:endClose } );
					
				break;
				
				case FloatWarning.ORIGIN_BOTTOM:
					
					Tweener.addTween(this, { alpha:0, time:1, y:stage.stageHeight, transition:"EaseInSine", onComplete:endClose } );
					
				break;
			}
		}
		
		private function endClose():void { destroy(); }
		
		public function get origin():String 					{ return _origin; }
		public function get time():Number 						{ return _time; }
		public function get bg_colour():uint 					{ return _bg_colour; }
		public function get text_colour():uint 					{ return _text_colour; }
		
		public function set message(value:String):void 			{ _message 	 	= value; };
		public function set warning_type(value:String):void 	{ _warning_type = value; };
		public function set origin(value:String):void  			{ _origin 		= value; };
		public function set time(value:Number):void  			{ _time 		= value; };
		public function set bg_colour(value:uint):void  		{ _bg_colour 	= value; };
		public function set text_colour(value:uint):void  		{ _text_colour 	= value; };
	}
	
}