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
	import com.addicted2flash.layout.util.LayoutUtil;	
	import com.addicted2flash.layout.constraint.CanvasLayoutConstraint;
	import com.addicted2flash.layout.core.IComponent;
	import com.addicted2flash.layout.core.IContainer;
	import com.addicted2flash.layout.util.Padding;	

	/**
	 * Canvas layout arranges components to their desired size. It uses an absolute
	 * layout and moves its components according to their margin.
	 * 
	 * @author Tim Richter
	 */
	public class CanvasLayout implements ILayout 
	{
		/**
		 * Creates a new <code>CanvasLayout</code>.
		 */
		public function CanvasLayout()
		{
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
			
			var p: Padding = container.padding;
			var c: IComponent;
			var ph: Number = p.horizontal;
			var pv: Number = p.vertical;
			var minw: Number = 0, minh: Number = 0, desw: Number = 0, desh: Number = 0;
			var cs: Number, mw: Number, mh: Number;
			
			for( var i: int = 0; i < n ; ++i )
			{
				c = container.getAt( i );
				
				mw = c.minimumWidth;
				mh = c.minimumHeight;
				
				if( mw > minw ) minw = mw;
				if( mh > minh ) minh = mh;
				
				cs = c.hasDesiredPercentWidth ? mw : c.desiredWidth;
				
				if( cs > desw ) desw = cs;
				
				cs = c.hasDesiredPercentHeight ? mh : c.desiredHeight;
					
				if( cs > desh ) desh = cs;
			}
			
			container.measuredMinimumWidth = minw + ph;
			container.measuredMinimumHeight = minh + pv;
			
			container.measuredDesiredWidth = desw + ph;
			container.measuredDesiredHeight = desh + pv;
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
			
			if( w < 0 ) w = 0;
			if( h < 0 ) h = 0;
			
			var c: IComponent;
			var con: CanvasLayoutConstraint;
			
			var dx: Number = w + x;
			var dy: Number = h + y;
			var dw: Number, dh: Number, mw: Number, mh: Number, xw: Number, xh: Number, cx: Number, cy: Number;
			
			var i: int;
			
			for( i = 0; i < n ; ++i )
			{
				c = container.getAt( i );
				
				con = c.constraint as CanvasLayoutConstraint;
				
				dw = LayoutUtil.getRequiredWidth( c, w );
				dh = LayoutUtil.getRequiredHeight( c, h );
				
				if( con )
				{
					mw = c.minimumWidth;
					xw = c.maximumWidth;
					mh = c.minimumHeight;
					xh = c.maximumHeight;
					
					if( !isNaN( con.left ) && !isNaN( con.right ) )
					{
						cx = x + con.left;
						dw = w - cx - con.right;
						
						if( dw < mw ) dw = mw;
						else if( dw > xw ) dw = xw;
					}
					else if( !isNaN( con.right ) )
					{
						cx = dx - dw - con.right;
					}
					else if( !isNaN( con.left ) )
					{
						cx = x + con.left;
					}
					else
					{
						cx = x;
					}
					
					if( !isNaN( con.top ) && !isNaN( con.bottom ) )
					{
						cy = y + con.top;
						dh = h - cy - con.bottom;
						
						if( dh < mh ) dh = mh;
						else if( dh > xh ) dh = xh;
					}
					else if( !isNaN( con.bottom ) )
					{
						cy = dy - dh - con.bottom;
					}
					else if( !isNaN( con.top ) )
					{
						cy = y + con.top;
					}
					else
					{
						cy = y;
					}
					
					c.move( cx, cy );
					c.resize( dw, dh );
				}
				else
				{
					c.move( x, y );
					c.resize( dw, dh );
				}
			}
		}

		/**
		 * Returns the string representation of the <code>CanvasLayout</code>.
		 * 
		 * @return the string representation of the <code>CanvasLayout</code>
		 */
		public function toString(): String
		{
			return "[ CanvasLayout ]";
		}
	}
}
