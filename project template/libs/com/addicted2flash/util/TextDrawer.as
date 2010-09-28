/**
 * Copyright (c) 2008 Tim Richter, www.addicted2flash.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
package com.addicted2flash.util 
{
	import com.addicted2flash.layout.util.Size;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;		

	/**
	 * This class enables multiple instances to retrieve bitmaps with text.
	 * <p>This can be necessary when the same type of text-style is used in 
	 * many objects. With this class you can avoid greedy instances of the
	 * <code>TextField</code> class.</p>
	 * 
	 * @author Tim Richter
	 */
	public class TextDrawer 
	{
		private var _tField: TextField;
		private var _clip: Size;
		private var _min: int;
		
		/**
		 * Creates a new <code>TextDrawer</code>.
		 * 
		 * @param textField the textField to copy
		 */
		public function TextDrawer( textField: TextField )
		{
			this.textField = textField;
		}
		
		/**
		 * Returns the <code>TextField</code> set to be drawn.
		 * 
		 * @return the <code>TextField</code> set to be drawn
		 */
		public function get textField(): TextField
		{
			return _tField;
		}
		
		/**
		 * Sets the <code>TextField</code> to copy pixels from.
		 * 
		 * @param textField the <code>TextField</code> to copy pixels from
		 */
		public function set textField( textField: TextField ): void
		{
			var str: String = textField.text;
			
			_tField = textField;
			
			_tField.htmlText = "...";
			
			_min = _tField.textWidth;
			
			_tField.text = str;
		}
		
		/**
		 * Returns the clipping <code>Size</code> of the copy region.
		 * 
		 * @return the clipping <code>Size</code> of the copy region
		 */
		public function get size(): Size
		{
			return _clip;
		}
		
		/**
		 * Sets the clipping <code>Size</code> of the copy region.
		 * 
		 * @param size size of the copy region
		 */
		public function set size( size: Size ): void
		{
			_clip = size;
		}
		
		/**
		 * Creates an returns a <code>Bitmap</code> with the copied text in it.
		 * 
		 * @param text text to be copied
		 * @param pixelSnapping pixel snapping
		 * @param smoothing smoothing
		 * 
		 * @return a <code>Bitmap</code> with the copied text in it
		 */
		public function createBitmap( text: String, pixelSnapping: String = "auto", smoothing: Boolean = false ): Bitmap
		{
			return new Bitmap( createBitmapData( text ), pixelSnapping, smoothing );
		}
		
		/**
		 * Creates an returns a <code>BitmapData</code> with the copied text in it.
		 * 
		 * @param text text to be copied
		 * 
		 * @return a <code>BitmapData</code> with the copied text in it
		 */
		public function createBitmapData( text: String ): BitmapData
		{
			_tField.htmlText = text;
			
			var data: BitmapData;
			
			if( _clip )
			{
				cut();
				
				data = new BitmapData( _clip.width, _clip.height, true, 0x00000000 );
			}
			else
			{
				data = new BitmapData( _tField.textWidth+2, _tField.textHeight+2, true, 0x00000000 );
			}
			
			data.draw( _tField );
			
			return data;
		}
		
		/**
		 * Draws the text in the given <code>Bitmap</code>.
		 * 
		 * @param bitmap <code>Bitmap</code>
		 * @param text text to be copied
		 */
		public function drawBitmap( bitmap: Bitmap, text: String ): void
		{
			if( bitmap.bitmapData ) bitmap.bitmapData.dispose();
			
			bitmap.bitmapData = createBitmapData( text );
		}
		
		/**
		 * Draws the text in the given <code>BitmapData</code>.
		 * 
		 * @param bitmap <code>BitmapData</code>
		 * @param text text to be copied
		 */
		public function drawBitmapData( data: BitmapData, text: String ): void
		{
			_tField.htmlText = text;
			
			if( _clip )
			{
				cut();
				
				data.draw( _tField );
			}
			else
			{
				data.draw( _tField );
			}
		}
		
		private function cut(): void
		{
			var w: int = _clip.width;
			var h: int = _clip.height;
			var tw: int, th: int;
			
			var text: String = _tField.text;
			var i: int = text.length;
			var m: int = i >> 1;
			
			while( true )
			{
				tw = _tField.textWidth;
				th = _tField.textHeight;
				
				if( tw + _min > w || th + _min > h )
				{
					_tField.text = text.substr( 0, i -= m );
				}
				else
				{
					if( tw + _min >= w || th + _min >= h )
					{
						_tField.appendText( "..." );
						
						break;
					}
					else
					{
						_tField.text = text.substr( 0, i += m );
					}
				}
				
				m >>= 1;
				
				if( m == 0 ) m = 1;
			}
		}
	}
}
