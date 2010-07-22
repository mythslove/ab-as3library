package nl.stroep.experiments
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.display.Shape;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class MenuItem extends Sprite
	{
		private var textformat:TextFormat = new TextFormat("Arial", 9, 0xFFFFFF, true, null, null, null, null, TextFormatAlign.CENTER);
		public var label:TextField = new TextField();
		private var _text:String;
		private var _backgroundWidth:Number;
		public var background:Shape = new Shape();
		
		public function MenuItem( text:String, backgroundWidth:Number ):void 
		{ 
			this.addChild(background);
			this.addChild(label);
			
			label.selectable = false;
			label.defaultTextFormat = textformat;
			
			_backgroundWidth = backgroundWidth;
			_text = text;
			
			label.text = text.toUpperCase();
			label.width = _backgroundWidth;
			label.y = 12;
			
			draw();
		}

		public function get text():String { return _text; }

		public function set text( value:String ):void
		{
			_text = value;
			
			label.text = _text.toUpperCase();
			label.width = _backgroundWidth;
		}
		
		public function get backgroundWidth():Number { return _backgroundWidth; }

		public function set backgroundWidth( value:Number ):void
		{
			_backgroundWidth = value;
			
			draw();
			label.width = _backgroundWidth;
		}
		
		public function draw():void
		{			
			background.graphics.clear();
			
			background.graphics.beginFill(0xE5254E, 1);
			background.graphics.drawRect( 0, 0, _backgroundWidth, 40);
			background.graphics.endFill();
		}

	}
}