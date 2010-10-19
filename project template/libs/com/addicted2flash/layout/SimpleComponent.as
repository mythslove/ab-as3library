package com.addicted2flash.layout
{
	import com.addicted2flash.layout.core.Component;
 
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;	
 
	/**
	 * @author Tim Richter
	 */
	public class SimpleComponent extends Component
	{
		private static var _id: int = 0;
		private var _tField: TextField;
 
		public function SimpleComponent( w: Number, h: Number )
		{
			desiredWidth = w;
			desiredHeight = h;
 
			_tField = new TextField( );
			_tField.autoSize = TextFieldAutoSize.CENTER;
			_tField.selectable = false;
			_tField.textColor = 0x999999;
			_tField.text = ( _id++ ).toString();
 
			display.addChild( _tField );
		}
 
		override public function arrange(): void
		{
			var g: Graphics = display.graphics;
			g.clear();
			g.beginFill( 0xccff00 );
			g.drawRect( 0, 0, width, height );
			g.endFill();
 
			_tField.x = ( width - _tField.textWidth ) * 0.5;
			_tField.y = ( height - _tField.textHeight ) * 0.5;
		}
	}
}