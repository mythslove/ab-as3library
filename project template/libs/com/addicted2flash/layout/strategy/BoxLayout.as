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
	import com.addicted2flash.layout.util.Orientation;
	import com.addicted2flash.layout.util.Padding;
	import com.addicted2flash.layout.util.LayoutUtil;
	
	import flash.errors.IllegalOperationError;	

	/**
	 * Instances of this class arrange and measure components of a given container
	 * in vertical or horizontal orientation.
	 * 
	 * @author Tim Richter
	 */
	public class BoxLayout implements ILayout 
	{
		private var _orientation: int;
		private var _gap: Number;

		/**
		 * Creates a new <code>BoxLayout</code>.
		 * 
		 * @see #orientation
		 * @param gap the gap between the components
		 */
		public function BoxLayout( orientation: int, gap: Number = 0 )
		{
			this.orientation = orientation;
			this.gap = gap;
		}
		
		/**
		 * Returns the orientation of the layout.
		 * 
		 * @return the orientation of the layout
		 */
		public function get orientation(): int
		{
			return _orientation;
		}
		
		/**
		 * Sets the orientation of the layout.
		 * 
		 * @param orientation the orientation of the layout
		 * @throws IllegalOperationError if orientation is not supported
		 * @see Orientation.HORIZONTAL
		 * @see Orientation.VERTICAL
		 */
		public function set orientation( orientation: int ): void
		{
			if( orientation != Orientation.HORIZONTAL && orientation != Orientation.VERTICAL )
			{
				throw new IllegalOperationError( "unsupported orientation!" );
			}
			
			_orientation = orientation;
		}
		
		/**
		 * Returns the gap between the components.
		 * 
		 * @return the gap between the components
		 */
		public function get gap( ):Number
		{
			return _gap;
		}
		
		/**
		 * Sets the gap between the components.
		 * 
		 * @param value the gap between the components
		 */
		public function set gap( value: Number ): void
		{
			_gap = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function measure( container: IContainer ): void
		{
			var n: int = container.componentCount;
			
			if( _orientation == Orientation.HORIZONTAL )
			{
				LayoutUtil.measureHorizontalSizes( container, !n ? 0 : ( n - 1 ) * _gap );
			}
			else
			{
				LayoutUtil.measureVerticalSizes( container, !n ? 0 : ( n - 1 ) * _gap );
			}
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
			
			var c: IComponent;
			var xx: Number;
			
			var i: int = 0;
			
			if( _orientation == Orientation.HORIZONTAL )
			{
				w -=  ( n - 1 ) * _gap;
				xx = LayoutUtil.getTileWidth( container, w, 0, n );
				
				for( ; i < n; ++i, x += c.width + _gap )
				{
					LayoutUtil.arrange( c = container.getAt( i ), xx, h, x, y );
				}
			}
			else
			{
				h -=  ( n - 1 ) * _gap;
				xx = LayoutUtil.getTileHeight( container, h, 0, n );
				
				for( ; i < n; ++i, y += c.height + _gap )
				{
					LayoutUtil.arrange( c = container.getAt( i ), w, xx, x, y );
				}
			}
		}
		
		/**
		 * Returns the string representation of the <code>BoxLayout</code>.
		 * 
		 * @return the string representation of the <code>BoxLayout</code>
		 */
		public function toString(): String
		{
			return "[ BoxLayout orientation='" + orientation + "' ]";
		}
	}
}
