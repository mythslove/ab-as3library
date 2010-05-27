package com.ab.display 
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.properties.FilterShortcuts;
	import caurina.transitions.Tweener;
	import com.ab.display.geometry.PolygonQuad;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import org.casalib.display.CasaSprite;
	import org.casalib.util.StageReference;
	
	public class FloatWarning extends CasaSprite
	{
		/// main
		private var _message:String;
		private var _warning_type:String = "normal";
		private var _time:Number;
		/// sys
		public var aux_var:Number;
		
		public function FloatWarning(_message:String, _type:String="normal", _time:Number=2)
		{
			/// "normal" or "error" types may be used
			
			message 		= _message;
			warning_type	= _type;
			time			= _time;
			
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
				
				case "normal":
					tf_format.color	 			= 0x00FF00;
				break;
				
				case "error":
					tf_format.color	 			= 0xFF0000;
				break;
				
				default:
					tf_format.color	 			= 0x00FF00;
			}
			
			tf.setTextFormat(tf_format);
			
			var bg:Sprite 				= new Sprite();
			var bg_graph:PolygonQuad 	= new PolygonQuad(tf.width + 10, tf.height + 10)
			
			bg_graph.x 					= -5;
			bg_graph.y 					= -5;
			
			this.addChildAt(bg, 0);
			this.addChildAt(tf, 1);
			bg.addChild(bg_graph);
			
			this.alpha 	= 0;
			this.x 		= StageReference.getStage().stageWidth / 2 - this.width / 2;
			this.y 		= StageReference.getStage().stageHeight;
			
			/// make time and go away
			
			aux_var = 0;
			
			Tweener.addTween(this, { alpha:1, y:StageReference.getStage().stageHeight - (this.height * 2), time:0.5} );
			
			Tweener.addTween(this, { aux_var:1, time:2, onComplete:startClose } );
		}
		
		private function startClose():void
		{
			Tweener.addTween(this, { alpha:0, time:1, y:StageReference.getStage().stageHeight, transition:"EaseInOutExpo", onComplete:endClose } );
		}
		
		private function endClose():void
		{
			destroy();
		}
		
		public function set message(value:String):void 			{ _message 	 	= value; };
		public function set warning_type(value:String):void 	{ _warning_type = value; };
		public function set time(value:Number):void  			{ _time 		= value; }
		
	}
	
}