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
	import com.addicted2flash.layout.util.Alignment;
	import com.addicted2flash.layout.util.Flow;
	import com.addicted2flash.layout.util.Padding;
	import com.addicted2flash.layout.util.LayoutUtil;
	
	import flash.errors.IllegalOperationError;	

	/**
	 * A <code>WrapLayout</code> arranges <code>IUIComponent</code>s in a row/column until no 
	 * more <code>IUIComponent</code>s fit in that row/column. The <code>IUIComponent</code>s 
	 * will be arranged to their desired size.
	 * 
	 * <p>In addition it is possible to choose different alignment and flow settings for the layout.</p>
	 * <p>These are the possible aligment values:</p>
	 * 	<li><code>Alignment.LEFT</code> (default)</li>
	 * 	<li><code>Alignment.TOP</code></li>
	 * 	<li><code>Alignment.BOTTOM</code></li>
	 * 	<li><code>Alignment.RIGHT</code></li>
	 * 	<li><code>Alignment.TOP_LEFT</code></li>
	 * 	<li><code>Alignment.TOP_RIGHT</code></li>
	 * 	<li><code>Alignment.BOTTOM_LEFT</code></li>
	 * 	<li><code>Alignment.BOTTOM_RIGHT</code></li>
	 * 
	 * <p>These are the possbile flow values:</p>
	 *  <li><code>Flow.LEFT_TO_RIGHT</code> (default)</li>
	 *  <li><code>Flow.RIGHT_TO_LEFT</code></li>
	 *  <li><code>Flow.TOP_TO_BOTTOM</code></li>
	 *  <li><code>Flow.BOTTOM_TO_TOP</code></li>
	 * 
	 * @author Tim Richter
	 */
	public class FlowLayout implements ILayout
	{
		private var _flow: int;
		private var _align: int;

		/**
		 * Creates a new <code>WrapLayout</code>.
		 * 
		 * @param flow flow of the layout
		 * @param alignment alignment of the layout
		 * @see #flow
		 * @see #alignment
		 */
		public function FlowLayout( flow: int, alignment: int )
		{
			this.flow = flow;
			this.alignment = alignment;
		}
		
		/**
		 * Returns the flow of the layout.
		 * 
		 * @return the flow of the layout
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
		 * @see Flow.BOTTOM_TO_TOP
		 * @see Flow.TOP_TO_BOTTOM
		 * @see Flow.LEFT_TO_RIGHT
		 * @see Flow.RIGHT_TO_LEFT
		 */
		public function set flow( flow: int ): void
		{
			if( !( flow & ( Flow.BOTTOM_TO_TOP | Flow.LEFT_TO_RIGHT | Flow.RIGHT_TO_LEFT | Flow.TOP_TO_BOTTOM ) ) )
			{
				throw new IllegalOperationError( "unsupported flow!" );
			}
			
			_flow = flow;
		}
		
		/**
		 * Returns the alignment of the layout.
		 * 
		 * @return the alignment of the layout
		 */
		public function get alignment(): int
		{
			return _align;
		}
		
		/**
		 * Sets the alignment of the layout.
		 * 
		 * @param align the alignment of the layout
		 * @throws IllegalOperationError if align is not supported
		 * @see Alignment.TOP
		 * @see Alignment.RIGHT
		 * @see Alignment.BOTTOM
		 * @see Alignment.LEFT
		 * @see Alignment.CENTER
		 */
		public function set alignment( align: int ): void
		{
			if( !( align & ( Alignment.BOTTOM | Alignment.CENTER | Alignment.LEFT | Alignment.RIGHT | Alignment.TOP ) ) )
			{
				throw new IllegalOperationError( "unsupported alignment!" );
			}
			
			_align = align;
		}
		
		/**
		 * @inheritDoc
		 */
		public function measure( container: IContainer ): void
		{
			//-- if horizontal orientation
			if( !( _flow & ( Flow.BOTTOM_TO_TOP | Flow.TOP_TO_BOTTOM ) ) )
			{
				LayoutUtil.measureHorizontalSizes( container );
			}
			else
			{
				LayoutUtil.measureVerticalSizes( container );
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
			
			if( w < 0 ) w = 0;
			if( h < 0 ) h = 0;
			
			var c: IComponent;
			
			var dw: Number, dh: Number;
			
			var tw: Number = 0, th: Number = 0, max: Number = 0;
			
			var f: int = 0;
			var i: int = 0;
			
			//-- horizontal orientation
			if( !( _flow & ( Flow.BOTTOM_TO_TOP | Flow.TOP_TO_BOTTOM ) ) )
			{
				for( ; i < n; ++i )
				{
					c = container.getAt( i );
					
					dw = LayoutUtil.getRequiredWidth( c, w );
					dh = LayoutUtil.getRequiredHeight( c, h );
					
					c.resize( dw, dh );
					
					if( tw + dw > w )
					{
						horizontalAlign( container, f, i, x, y, w, h, tw, th, max );
						
						th += max;
						
						f = i;
						tw = max = 0;
					}
					
					if( dh > max ) max = dh;
					
					tw += dw;
				}
				
				horizontalAlign( container, f, i, x, y, w, h, tw, th, max );
			}
			else
			{
				for( ; i < n; ++i )
				{
					c = container.getAt( i );
					
					dw = LayoutUtil.getRequiredWidth( c, w );
					dh = LayoutUtil.getRequiredHeight( c, h );
					
					c.resize( dw, dh );
					
					if( th + dh > h )
					{
						verticalAlign( container, f, i, x, y, w, h, tw, th, max );
						
						tw += max;
						
						f = i;
						th = max = 0;
					}
					
					if( dw > max ) max = dw;
					
					th += dh;
				}
				
				verticalAlign( container, f, i, x, y, w, h, tw, th, max );
			}
		}
		
		/**
		 * Returns the string representation of the <code>FlowLayout</code>.
		 * 
		 * @return the string representation of the <code>FlowLayout</code>
		 */
		public function toString(): String
		{
			return "[ FlowLayout flow='" + Flow.toString( flow ) +
					"' align='" + Alignment.toString( alignment ) + "' ]";
		}
		
		private function horizontalAlign( container: IContainer, from: int, to: int, x: Number, y: Number, w: Number, h: Number, dW: Number, dH: Number, max: Number ): void
		{
			var c: IComponent;
			
			if( _flow & Flow.RIGHT_TO_LEFT )
			{
				if( _align & Alignment.RIGHT && _align & Alignment.BOTTOM )
				{
					x += w - dW;
					y += h - dH - max;
				}
				else if( _align & Alignment.CENTER && _align & Alignment.BOTTOM )
				{
					x += ( w - dW ) * 0.5;
					y += h - dH - max;
				}
				else if( _align & Alignment.RIGHT )
				{
					x += w - dW;
					y += dH;
				}
				else if( _align & Alignment.CENTER )
				{
					x += ( w - dW ) * 0.5;
					y += dH;
				}
				else if( _align & Alignment.BOTTOM )
				{
					y += h - dH - max;
				}
				else
				{
					y += dH;
				}
					
				for( to -= 1; to >= from; --to )
				{
					c = container.getAt( to );
					
					switch( c.verticalAlignment )
					{
						case Alignment.TOP:
							c.move( x, y );
							break;
						case Alignment.BOTTOM:
							c.move( x, y + ( max - c.height ) );
							break;
						case Alignment.CENTER:
							c.move( x, y + ( max - c.height ) * 0.5 );
							break;
					}
					
					x += c.width;
				}
			}
			else
			{
				if( _align & Alignment.RIGHT && _align & Alignment.BOTTOM )
				{
					x += w - dW;
					y += h - dH - max;
				}
				else if( _align & Alignment.CENTER && _align & Alignment.BOTTOM )
				{
					x += ( w - dW ) * 0.5;
					y += h - dH - max;
				}
				else if( _align & Alignment.BOTTOM )
				{
					y += h - dH - max;
				}
				else if( _align & Alignment.RIGHT )
				{
					x += w - dW;
					y += dH;
				}
				else if( _align & Alignment.CENTER )
				{
					x += ( w - dW ) * 0.5;
					y += dH;
				}
				else
				{
					y += dH;
				}
				
				for( ; from < to; ++from )
				{
					c = container.getAt( from );
					
					switch( c.verticalAlignment )
					{
						case Alignment.TOP:
							c.move( x, y );
							break;
						case Alignment.BOTTOM:
							c.move( x, y + ( max - c.height ) );
							break;
						case Alignment.CENTER:
							c.move( x, y + ( max - c.height ) * 0.5 );
							break;
					}
					
					x += c.width;
				}
			}
		}
		
		private function verticalAlign( container: IContainer, from: int, to: int, x: Number, y: Number, w: Number, h: Number, dW: Number, dH: Number, max: Number ): void
		{
			var c: IComponent;
			
			if( _flow & Flow.TOP_TO_BOTTOM )
			{
				if( _align & Alignment.RIGHT && _align & Alignment.BOTTOM )
				{
					x += w - dW - max;
					y += h - dH;
				}
				else if( _align & Alignment.RIGHT && _align & Alignment.CENTER )
				{
					x += w - dW - max;
					y += ( h - dH ) * 0.5;
				}
				else if( _align & Alignment.RIGHT )
				{
					x += w - dW - max;
				}
				else if( _align & Alignment.CENTER )
				{
					x += dW;
					y += ( h - dH ) * 0.5;
				}
				else if( _align & Alignment.BOTTOM )
				{
					x += dW;
					y += h - dH;
				}
				else
				{
					x += dW;
				}
				
				for( ; from < to; ++from )
				{
					c = container.getAt( from );
					
					switch( c.horizontalAlignment )
					{
						case Alignment.LEFT:
							c.move( x, y );
							break;
						case Alignment.RIGHT:
							c.move( x + ( max - c.width ), y );
							break;
						case Alignment.CENTER:
							c.move( x + ( max - c.width ) * 0.5, y );
							break;
					}
					
					y += c.height;
				}
			}
			else
			{
				if( _align & Alignment.RIGHT && _align & Alignment.BOTTOM )
				{
					x += w - dW - max;
					y += h - dH;
				}
				else if( _align & Alignment.RIGHT && _align & Alignment.CENTER )
				{
					x += w - dW - max;
					y += ( h - dH ) * 0.5;
				}
				else if( _align & Alignment.BOTTOM )
				{
					x += dW;
					y += h - dH;
				}
				else if( _align & Alignment.CENTER )
				{
					x += dW;
					y += ( h - dH ) * 0.5;
				}
				else if( _align & Alignment.RIGHT )
				{
					x += w - dW - max;
				}
				else
				{
					x += dW;
				}
				
				for( to -= 1; to >= from; --to )
				{
					c = container.getAt( to );
					
					switch( c.horizontalAlignment )
					{
						case Alignment.LEFT:
							c.move( x, y );
							break;
						case Alignment.RIGHT:
							c.move( x + ( max - c.width ), y );
							break;
						case Alignment.CENTER:
							c.move( x + ( max - c.width ) * 0.5, y );
							break;
					}
					
					y += c.height;
				}
			}
		}
	}
}
