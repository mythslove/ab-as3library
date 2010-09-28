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
package com.addicted2flash.layout.strategy 
{
	import com.addicted2flash.layout.core.IComponent;
	import com.addicted2flash.layout.core.IContainer;
	import com.addicted2flash.layout.util.Flow;
	import com.addicted2flash.layout.util.Padding;
	
	import flash.errors.IllegalOperationError;	

	/**
	 * Arranges a containers components in a fixed amount of rows and columns.
	 * The components will be arranged according to the calculated space. Their desired/minimum/maximum
	 * size will not be considered.
	 * 
	 * @author Tim Richter
	 */
	public class GridLayout implements ILayout 
	{
		private var _rows: int;
		private var _cols: int;
		
		private var _hgap: Number;
		private var _vgap: Number;
		
		private var _flow: int;
		
		/**
		 * Creates a new <code>GridLayout</code>.
		 * 
		 * @param rows rows
		 * @param cols columns
		 * @param hgap horizontal gap between columns
		 * @param vgap vertical gap between rows
		 */
		public function GridLayout( rows: int, cols: int, hgap: Number = 0, vgap: Number = 0 )
		{
			if( rows == 0 && cols == 0 )
			{
				throw new IllegalOperationError( "rows and cols cannot be zero!" );
			}
			
			_hgap = hgap;
			_vgap = vgap;
			_rows = rows;
			_cols = cols;
			_flow = Flow.LEFT_TO_RIGHT;
		}
		
		/**
		 * Returns the horizontal gap between the grid cells.
		 * 
		 * @return the horizontal gap between the grid cells
		 */
		public function get hGap(): Number
		{
			return _hgap;
		}
		
		/**
		 * Sets the horizontal gap between the grid cells.
		 * 
		 * @param gap the horizontal gap between the grid cells
		 */
		public function set hGap( gap: Number ): void
		{
			_hgap = gap;
		}
		
		/**
		 * Returns the vertical gap between the grid cells.
		 * 
		 * @return the vertical gap between the grid cells
		 */
		public function get vGap(): Number
		{
			return _vgap;
		}
		
		/**
		 * Sets the vertical gap between the grid cells.
		 * 
		 * @param gap the vertical gap between the grid cells
		 */
		public function set vGap( gap: Number ): void
		{
			_vgap = gap;
		}
		
		/**
		 * Returns the flow of the layout.
		 * 
		 * @return the flow of the layout
		 * @see Flow
		 */
		public function get flow(): int
		{
			return _flow;
		}
		
		/**
		 * Sets the flow of the layout.
		 * 
		 * @param flow the flow of the layout
		 * @throws IllegalOperationError if flow is not supported
		 * @see Flow
		 */
		public function set flow( flow: int ): void
		{
			if( !( _flow & ( Flow.BOTTOM_TO_TOP | Flow.LEFT_TO_RIGHT | Flow.RIGHT_TO_LEFT | Flow.TOP_TO_BOTTOM ) ) )
			{
				throw new IllegalOperationError( "unsupported flow!" ); 
			}
			
			_flow = flow;
		}
		
		/**
		 * @inheritDoc
		 */
		public function measure( container: IContainer ): void
		{
			var n: int = container.componentCount;
			
			if( n == 0 )
			{
				container.measuredMinimumWidth = 0;
				container.measuredMinimumHeight = 0;
				container.measuredDesiredWidth = 0;
				container.measuredDesiredHeight = 0;
				
				return;
			}
			
			var c: IComponent;
			var p: Padding = container.padding;
			var ph: Number = p.horizontal + ( _cols - 1 ) * _hgap;
			var pv: Number = p.vertical + ( _rows - 1 ) * _vgap;
			var dw: Number = 0;
			var dh: Number = 0;
			var mw: Number = 0;
			var mh: Number = 0;
			var ds: Number;
			var ms: Number;
			
			for( var i: int = 0; i < n; ++i )
			{
				c = container.getAt( i );
				
				ms = c.minimumWidth;
				if( ms > mw ) mw = ms;
				
				ds = c.hasDesiredPercentWidth ? ms : c.desiredWidth;
				if( ds > dw ) dw = ds;
				
				ms = c.minimumHeight;
				if( ms > mh ) mh = ms;
				
				ds = c.hasDesiredPercentHeight ? ms : c.desiredHeight;
				if( ds > dh ) dh = ds;
			}
			
			
			container.measuredMinimumWidth = mw * _cols + ph;
			container.measuredMinimumHeight = mh * _rows + pv;
			container.measuredDesiredWidth = dw * _cols + ph;
			container.measuredDesiredHeight = dh * _rows + pv;
		}

		/**
		 * @inheritDoc
		 */
		public function arrange( container: IContainer ): void
		{
			var n: int = container.componentCount;
			
			if( n == 0 ) return;
			
			var p: Padding = container.padding;
			var w: Number = container.width - p.horizontal;
			var h: Number = container.height - p.vertical;
			var x: Number = p.left;
			var y: Number = p.top;
			
			var cw: Number = ( w - ( _cols - 1 ) * _hgap ) / _cols;
			var ch: Number = ( h - ( _rows - 1 ) * _vgap ) / _rows;
			
			if( cw < 0 ) cw = 0;
			if( ch < 0 ) ch = 0;
			
			var c: IComponent;
			
			var i: int, j: int, k: int;
			var t: int = _rows * _cols;
			
			if( _flow & Flow.LEFT_TO_RIGHT && _flow & Flow.BOTTOM_TO_TOP )
			{
				for( i = 1; i <= _rows; ++i, y+= ch + _vgap, x = p.left )
				{
					for( j = t - i * _cols, k = j + _cols; j < k && j < n; ++j )
					{
						c = container.getAt( j );
						c.move( x, y );
						c.resize( cw, ch );
						
						x += cw + _hgap;
					}
				}
			}
			else if( _flow & Flow.RIGHT_TO_LEFT && _flow & Flow.BOTTOM_TO_TOP )
			{
				for( i = 0; i < _rows ; ++i, y += ch + _vgap, x = p.left )
				{
					for( j = t - i * _cols - 1, k = j - _cols; j > k && j < n; --j )
					{
						c = container.getAt( j );
						c.move( x, y );
						c.resize( cw, ch );
						
						x += cw + _hgap;
					}
				}
			}
			else if( _flow & Flow.RIGHT_TO_LEFT )
			{
				for( i = 1; i <= _rows; ++i, y += ch + _vgap, x = p.left )
				{
					for( j = i * _cols - 1, k = j - _cols; j > k && j < n; --j )
					{
						c = container.getAt( j );
						c.move( x, y );
						c.resize( cw, ch );
						
						x += cw + _hgap;
					}
				}
			}
			else
			{
				for( i = 0; i < _rows; ++i, y += ch + _vgap, x = p.left )
				{
					for( k = j + _cols; j < k && j < n; ++j )
					{
						c = container.getAt( j );
						c.move( x, y );
						c.resize( cw, ch );
						
						x += cw + _hgap;
					}
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function toString() : String
		{
			return "[ GridLayout ]";
		}
	}
}
