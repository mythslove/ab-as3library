package com.ab.display 
{
	/**
	* @author ABº
	* 
	* http://www.antoniobrandao.com/
	* http://blog.antoniobrandao.com/
	*/
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	///  _icon_data example : ["   ", " * ", "   " ]
	
	public class PatternFill extends Sprite
	{
		public function PatternFill(_target:Object, _width:Number, _height:Number, _icon_data:Array, _color:Number = 0x000000, _transparency:Number = 1):void
		{
			var num_rows:int = _icon_data.length;
			
			var mybitmapdata:BitmapData = new BitmapData(num_rows, num_rows, true, _color);
			var pattern_sprite:Sprite 	= new Sprite();
			
			pattern_sprite.graphics.beginFill(_color, 1);
			
			for ( var row:int = 0; row < num_rows; ++row)
			{
				var num_columns:int = _icon_data[row].length;
				
				for (var col:int = 0; col < num_columns; ++col)
				{
					if ((_icon_data[row] as String).charAt(col) != " ") pattern_sprite.graphics.drawRect(col, row, 1, 1);
				}
			}
			
			pattern_sprite.graphics.endFill();
			pattern_sprite.cacheAsBitmap = true;
			
			mybitmapdata.draw( pattern_sprite );
			
			var bmd:BitmapData = mybitmapdata;
			//var sp:Sprite 	   = new Sprite();
			
			//sp.graphics.beginBitmapFill(bmd);
			//sp.graphics.drawRect(0, 0, _width, _height);
			//sp.graphics.endFill();
			
			this.graphics.beginBitmapFill(bmd);
			this.graphics.drawRect(0, 0, _width, _height);
			this.graphics.endFill();
			
			this.alpha = _transparency;
			//return sp;
			
			//_target.addChild(sp);
		}
	}
	
}