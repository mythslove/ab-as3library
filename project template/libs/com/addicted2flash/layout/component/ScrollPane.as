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
package com.addicted2flash.layout.component 
{
	import com.addicted2flash.event.ScrollBarEvent;
	import com.addicted2flash.layout.core.Container;
	import com.addicted2flash.layout.core.IComponent;
	import com.addicted2flash.layout.core.IComponentObserver;
	import com.addicted2flash.layout.util.LayoutUtil;
	import com.addicted2flash.layout.util.Padding;
	import com.addicted2flash.layout.util.ScrollPolicy;

	import flash.errors.IllegalOperationError;
	import flash.geom.Rectangle;

	/**
	 * The <code>ScrollPane</code> is a basic container with the ability to handle horizontal and/or vertical scrolling.
	 * <p>Use <code>horizontalScroller()</code> and/or <code>verticalScroller()</code> to set scrollers.</p>
	 * 
	 * @author Tim Richter
	 */
	public class ScrollPane extends Container implements IComponentObserver
	{
		private var _view: IComponent;
		private var _corner: IComponent;
		
		private var _hBar: ScrollBar;
		private var _vBar: ScrollBar;
		
		private var _hPolicy: int;
		private var _vPolicy: int;
		
		private var _scrollRect: Rectangle;
		
		private var _visibleWidth: int;
		private var _visibleHeight: int;

		/**
		 * Creates a new <code>ScrollPane</code>.
		 * 
		 * @param viewport viewport of the scroll pane
		 */
		public function ScrollPane( view: IComponent )
		{
			this.view = view;
			this.horizontalScrollPolicy = ScrollPolicy.AUTO;
			this.verticalScrollPolicy = ScrollPolicy.AUTO;
		}

		/**
		 * Returns the viewport of the scroll pane.
		 * 
		 * @return the viewport of the scroll pane
		 */
		public function get view(): IComponent
		{
			return _view;
		}
		
		/**
		 * Sets the viewport of the scroll pane.
		 * 
		 * @param the viewport of the scroll pane
		 */
		public function set view( view: IComponent ): void
		{
			if( _view == view ) return;
			
			if( _view ) remove( _view ).display.scrollRect = null;
			
			addAt( 0, _view = view ).display.scrollRect = _scrollRect = new Rectangle();
		}
		
		/**
		 * Returns the component in lower right corner. The corners size is determined by the width
		 * and the height of the horizontal and vertical scrollbar.
		 * 
		 * @return the component in the lower right corner
		 */
		public function get corner(): IComponent
		{
			return _corner;
		}
		
		/**
		 * Sets the component in lower right corner. The corners size is determined by the width
		 * and the height of the horizontal and vertical scrollbar.
		 * 
		 * @param corner corner component
		 */
		public function set corner( corner: IComponent ): void
		{
			if( _corner ) remove( _corner );
			
			add( _corner = corner );
		}
		
		/**
		 * Returns the policy type of the horizontal scrollbar.
		 * 
		 * @return the policy type of the horizontal scrollbar
		 * @see ScrollBarPolicy.HIDE
		 * @see ScrollBarPolicy.AUTO
		 * @see ScrollBarPolicy.SCROLL
		 */
		public function get horizontalScrollPolicy(): int
		{
			return _hPolicy;
		}
		
		/**
		 * Sets the policy type of the horizontal scrollbar.
		 * 
		 * @param policy the policy type of the horizontal scrollbar
		 * @throws IllegalOperationError if policy is not supported
		 * @see ScrollBarPolicy.HIDE
		 * @see ScrollBarPolicy.AUTO
		 * @see ScrollBarPolicy.SCROLL
		 */
		public function set horizontalScrollPolicy( policy: int ): void
		{
			if( _hPolicy == policy ) return;
			
			if( policy != ScrollPolicy.HIDE && policy != ScrollPolicy.AUTO && policy != ScrollPolicy.SCROLL )
			{
				throw new IllegalOperationError( "unsupported policy!" );
			}
			
			_hPolicy = policy;
			
			invalidate();
		}
		
		/**
		 * Returns the policy type of the vertical scrollbar.
		 * 
		 * @return the policy type of the vertical scrollbar
		 * @see ScrollBarPolicy.HIDE
		 * @see ScrollBarPolicy.AUTO
		 * @see ScrollBarPolicy.SCROLL
		 */
		public function get verticalScrollPolicy(): int
		{
			return _hPolicy;
		}
		
		/**
		 * Sets the policy type of the vertical scrollbar.
		 * 
		 * @param policy the policy type of the vertical scrollbar
		 * @throws IllegalOperationError if policy is not supported
		 * @see ScrollBarPolicy.HIDE
		 * @see ScrollBarPolicy.AUTO
		 * @see ScrollBarPolicy.SCROLL
		 */
		public function set verticalScrollPolicy( policy: int ): void
		{
			if( _vPolicy == policy ) return;
			
			if( policy != ScrollPolicy.HIDE && policy != ScrollPolicy.AUTO && policy != ScrollPolicy.SCROLL )
			{
				throw new IllegalOperationError( "unsupported policy!" );
			}
			
			_vPolicy = policy;
			
			invalidate();
		}
		
		/**
		 * Returns the horizontal scrollbar.
		 * 
		 * @return the horizontal scrollbar
		 */
		public function get horizontalScrollBar( ): ScrollBar
		{
			return _hBar;
		}

		/**
		 * Sets the horizontal scrollbar.
		 * 
		 * @param scrollBar the horizontal scrollbar
		 */
		public function set horizontalScrollBar( scrollBar: ScrollBar ): void
		{
			if( _hBar ) remove( _hBar ).removeComponentObserver( this );
			
			add( _hBar = scrollBar ).addComponentObserver( this, ScrollBarEvent.POSITION );
		}
		
		/**
		 * Returns the vertical scrollbar.
		 * 
		 * @return the vertical scrollbar
		 */
		public function get verticalScrollBar( ): ScrollBar
		{
			return _vBar;
		}

		/**
		 * Sets the vertical scrollbar.
		 * 
		 * @param scrollBar the vertical scrollbar
		 */
		public function set verticalScrollBar( scrollBar: ScrollBar ): void
		{
			if( _vBar ) remove( _vBar ).removeComponentObserver( this );
			
			add( _vBar = scrollBar ).addComponentObserver( this, ScrollBarEvent.POSITION );
		}

		/**
		 * @inheritDoc
		 */
		override public function arrange(): void
		{
			var p: Padding = padding;
			var w: Number = width - p.horizontal;
			var h: Number = height - p.vertical;
			var x: Number = p.left;
			var y: Number = p.top;
			
			var dw: Number = w;
			var dh: Number = h;
			
			var vw: Number = LayoutUtil.getRequiredWidth( _view, w );
			var vh: Number = LayoutUtil.getRequiredHeight( _view, h );
			
			var vsw: Number = 0;
			var hsh: Number = 0;
			
			//-- first check for scrollbars
			if( _hBar && ( _hPolicy == ScrollPolicy.SCROLL || ( _hPolicy == ScrollPolicy.AUTO && w < vw ) ) )
			{
				dh -= hsh = LayoutUtil.getRequiredHeight( _hBar, h );
			}
			
			if( _vBar && ( _vPolicy == ScrollPolicy.SCROLL || ( _vPolicy == ScrollPolicy.AUTO && h < vh ) ) )
			{
				dw -= vsw = LayoutUtil.getRequiredWidth( _vBar, w );
			}
			
			//-- second check for scrollbars (if needed)
			if( _hBar && !hsh && _hPolicy != ScrollPolicy.SCROLL )
			{
				if( _hPolicy == ScrollPolicy.AUTO && dw < vw )
				{
					dh -= hsh = LayoutUtil.getRequiredHeight( _hBar, h );
				}
			}
			
			if( _vBar && !vsw && _vPolicy != ScrollPolicy.SCROLL )
			{
				if( _vPolicy == ScrollPolicy.AUTO && dh < vh )
				{
					dw -= vsw = LayoutUtil.getRequiredWidth( _vBar, w );
				}
			}
			
			if( _hBar )
			{
				_hBar.display.visible = hsh > 0;
				_hBar.move( x, dh + p.top );
				_hBar.resize( dw, hsh );
				_hBar.scrollSize = dw / vw;
			}
			
			if( _vBar )
			{
				_vBar.display.visible = vsw > 0;
				_vBar.move( dw + p.left, y );
				_vBar.resize( vsw, dh );
				_vBar.scrollSize = dh / vh;
			}
			
			if( _corner )
			{
				_corner.move( dw, dh );
				_corner.resize( vsw, hsh );
			}
			
			_view.move( x, y );
			_view.resize( vw, vh );
			
			_visibleWidth = Math.round( dw );
			_visibleHeight = Math.round( dh );
			
			_scrollRect.x = scrollRectX;
			_scrollRect.y = scrollRectY;
			_scrollRect.width = _visibleWidth;
			_scrollRect.height = _visibleHeight;
			_view.display.scrollRect = _scrollRect;
		}

		/**
		 * @private
		 */
		public function processEvent( type: int, c: IComponent ): void
		{
			if( c == _hBar )
			{
				_scrollRect.x = scrollRectX;
			}
			else
			{
				_scrollRect.y = scrollRectY;
			}
			
			_view.display.scrollRect = _scrollRect;
		}
		
		private function get scrollRectX(): Number
		{
			if( !_hBar ) return 0;
			
			var x: Number = -( _visibleWidth - _view.width ) * _hBar.scrollPosition;
			
			return x < 0 ? 0 : Math.round( x );
		}
		
		private function get scrollRectY(): Number
		{
			if( !_vBar ) return 0;
			
			var x: Number = -( _visibleHeight - _view.height ) * _vBar.scrollPosition;
			
			return x < 0 ? 0 : Math.round( x );
		}
	}
}
