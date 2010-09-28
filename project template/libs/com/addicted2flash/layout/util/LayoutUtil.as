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
package com.addicted2flash.layout.util 
{
	import com.addicted2flash.layout.core.IComponent;
	import com.addicted2flash.layout.core.IContainer;	

	/**
	 * Utility class for measuring and arranging components.
	 * 
	 * @author Tim Richter
	 */
	public class LayoutUtil 
	{
		/**
		 * Returns the calculated width of a component thats desired width is set to a percentaged value.
		 * 
		 * @param container container
		 * @param w total width for the components
		 * @param i index of the first component (including)
		 * @param n index of the last component (exluding)
		 * @return the calculated width of a component thats desired width is set to a percentaged value
		 */
		public static function getTileWidth( container: IContainer, w: Number, i: int, n: int ): Number
		{
			if( w == 0 ) return 0;
			
			i -= 1;
			
			var c: IComponent;
			var tw: Number = 0;
			var t: int = 0;
			
			while( --n > i )
			{
				c = container.getAt( n );
				
				if( !c.hasDesiredPercentWidth )
				{
					tw += c.desiredWidth;
				}
				else
				{
					++t;
				}
			}
			
			return !t ? 0 : ( w - tw ) / t;
		}

		/**
		 * Returns the calculated height of a component thats desired height is set to a percentaged value.
		 * 
		 * @param container container
		 * @param h total height for the components
		 * @param i index of the first component (including)
		 * @param n index of the last component (exluding)
		 * @return the calculated height of a component thats desired height is set to a percentaged value
		 */
		public static function getTileHeight( container: IContainer, h: Number, i: int, n: int ): Number
		{
			if( h == 0 ) return 0;
			
			i -= 1;
			
			var c: IComponent;
			var th: Number = 0;
			var t: int = 0;
			
			while( --n > i )
			{
				c = container.getAt( n );
				
				if( !c.hasDesiredPercentHeight )
				{
					th += c.desiredHeight;
				}
				else
				{
					++t;
				}
			}
			
			return !t ? 0 : ( h - th ) / t;
		}

		/**
		 * Measures the <code>measuredMinimumSize</code> and the <code>measuredDesiredSize</code>
		 * of a container in a horizontal oriented layout.
		 * 
		 * @param container container to measure
		 * @param overflow special overflow that needs to be calculated, too
		 */
		public static function measureHorizontalSizes( container: IContainer, overflow: Number = 0 ): void
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
			
			var p: Padding = container.padding;
			var hp: Number = p.horizontal;
			var vp: Number = p.vertical;
			var c: IComponent;
			
			var minw: Number = 0, minh: Number = 0, desw: Number = 0, desh: Number = 0;
			var mw: Number, mh: Number, dh: Number;
			var i: int = 0;
			
			for( ; i < n ; ++i )
			{
				c = container.getAt( i );
				
				mw = c.minimumWidth;
				
				minw += mw;
				desw += c.hasDesiredPercentWidth ? mw : c.desiredWidth;
				
				mh = c.minimumHeight;
				if( mh > minh ) minh = mh;
				
				dh = c.hasDesiredPercentHeight ? mh : c.desiredHeight;
				if( dh > desh ) desh = dh;
			}
			
			container.measuredMinimumWidth = minw + hp + overflow;
			container.measuredMinimumHeight = minh + vp + overflow;
			container.measuredDesiredWidth = desw + hp + overflow;
			container.measuredDesiredHeight = desh + vp + overflow;
		}

		/**
		 * Measures the <code>measuredMinimumSize</code> and the <code>measuredDesiredSize</code>
		 * of a container in a vertical oriented layout.
		 * 
		 * @param container container to measure
		 * @param overflow special overflow that needs to be calculated, too
		 */
		public static function measureVerticalSizes( container: IContainer, overflow: Number = 0 ): void
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
			
			var p: Padding = container.padding;
			var hp: Number = p.horizontal;
			var vp: Number = p.vertical;
			var c: IComponent;
			
			var minw: Number = 0, minh: Number = 0, desw: Number = 0, desh: Number = 0;
			var mw: Number, mh: Number, dw: Number;
			var i: int = 0;
			
			for( ; i < n ; ++i )
			{
				c = container.getAt( i );
				
				mh = c.minimumHeight;
				
				minh += mh;
				desh += c.hasDesiredPercentHeight ? mh : c.desiredHeight;
				
				mw = c.minimumWidth;
				if( mw > minw ) minw = mw;
				
				dw = c.hasDesiredPercentWidth ? mw : c.desiredWidth;
				if( dw > desw ) desw = dw;
			}
			
			container.measuredMinimumWidth = minw + hp + overflow;
			container.measuredMinimumHeight = minh + vp + overflow;
			container.measuredDesiredWidth = desw + hp + overflow;
			container.measuredDesiredHeight = desh + vp + overflow;
		}

		/**
		 * Arranges a component in a given rectangle.
		 * 
		 * @param c component
		 * @param w width
		 * @param h height
		 * @param x x-coordinate
		 * @param y y-coordinate
		 */
		public static function arrange( c: IComponent, w: Number, h: Number, x: Number, y: Number ): void
		{
			var cw: Number = getRequiredWidth( c, w );
			var ch: Number = getRequiredHeight( c, h );
			
			if( w > cw )
			{
				switch( c.horizontalAlignment )
				{
					case Alignment.CENTER:
						x += ( w - cw ) * 0.5;
						break;
					case Alignment.RIGHT:
						x += ( w - cw );
						break;
				}
			}
			
			if( h > ch )
			{
				switch( c.verticalAlignment )
				{
					case Alignment.CENTER:
						y += ( h - ch ) * 0.5;
						break;
					case Alignment.BOTTOM:
						x += ( h - ch );
						break;
				}
			}
			
			c.move( x, y );
			c.resize( cw, ch );
		}

		/**
		 * Returns the required width of the given component.
		 * 
		 * @param c component
		 * @param availableWidth available width
		 * @return required width of the component
		 */
		public static function getRequiredWidth( c: IComponent, availableWidth: Number ): Number
		{
			if( c.hasDesiredPercentWidth )
			{
				availableWidth *= c.desiredPercentWidth;
				
				return availableWidth < c.minimumWidth ? c.minimumWidth : availableWidth > c.maximumWidth ? c.maximumWidth : availableWidth;
			}
			else
			{
				return c.desiredWidth;
			}
		}

		/**
		 * Returns the required height of the given component.
		 * 
		 * @param c component
		 * @param availableHeight available height
		 * @return required height  of the component
		 */
		public static function getRequiredHeight( c: IComponent, availableHeight: Number ): Number
		{
			if( c.hasDesiredPercentHeight )
			{
				availableHeight *= c.desiredPercentHeight;
				
				return availableHeight < c.minimumHeight ? c.minimumHeight : availableHeight > c.maximumHeight ? c.maximumHeight : availableHeight;
			}
			else
			{
				return c.desiredHeight;
			}
		}
	}
}
