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
package com.addicted2flash.layout.core
{
	import flash.utils.Dictionary;	
	import flash.display.Sprite;	
	
	import com.addicted2flash.layout.strategy.ILayout;
	import com.addicted2flash.util.IDisposable;
	
	import flash.errors.IllegalOperationError;
	import flash.display.DisplayObject;	

	/**
	 * The <code>Container</code> class is able to add and layout components.
	 * 
	 * @author Tim Richter
	 */
	public class Container extends Component implements IContainer
	{
		private var _layout: ILayout;
		private var _children: Array;
		private var _displayMap: Dictionary;

		/**
		 * Creates a new <code>Container</code>.
		 * 
		 * @param layout layout
		 * @param display corresponding display object
		 */
		public function Container( layout: ILayout = null, display: Sprite = null )
		{
			super( display );
			
			_layout = layout;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get layout(): ILayout
		{
			return _layout;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set layout( layout: ILayout ): void
		{
			if( _layout == layout ) return;
			
			_layout = layout;
			
			invalidate();
		}
		
		/**
		 * @inheritDoc
		 */
		public function add( c: IComponent, constraint: Object = null ): IComponent
		{
			return addAt( componentCount, c, constraint );
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAt( i: int, c: IComponent, constraint: Object = null ): IComponent
		{
			if( i > componentCount ) throw new IllegalOperationError();
			
			if( !_children )
			{
				_children = [];
				_displayMap = new Dictionary( true );
			}
			else if( _children.indexOf( c ) > -1 )
			{
				_children.splice( _children.indexOf( c ), 1 ); 
				
				display.removeChild( c.display );
			}
			
			_children.splice( i, 0, c );
			
			_displayMap[ c.display ] = c;
			
			if( c.parent ) c.parent.remove( c );
			
			c.parent = this;
			
			display.addChild( c.display );
			
			c.constraint = constraint;
			
			invalidateTree();
			
			return c;
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove( c: IComponent ): IComponent
		{
			return removeAt( indexOfComponent( c ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAt( i: int ): IComponent
		{
			if( i > componentCount || !_children ) throw new IllegalOperationError();
			
			var c: Component = Component( _children.splice( i, 1 )[ 0 ] );
			
			delete _displayMap[ c.display ];
			
			if( !_children.length )
			{
				_children = null;
				_displayMap = null;
			}
			
			display.removeChild( c.display );
			
			c.parent = null;
			
			invalidateTree();
			
			return c;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAll(): void
		{
			var n: int = componentCount;
			
			while( --n > -1 ) removeAt( n );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getAt( i: int ): IComponent
		{
			return _children ? _children[ i ] : null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getBy( display: DisplayObject ): IComponent
		{
			return _displayMap ? _displayMap[ display ] : null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setAt( i: int, c: IComponent, constraint: Object = null ): IComponent
		{
			removeAt( i );
			
			return addAt( i, c, constraint );
		}
		
		/**
		 * @inheritDoc
		 */
		public function containsComponent( c: IComponent ): Boolean
		{
			return _children ? _children.indexOf( c ) > -1 : false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function indexOfComponent( c: IComponent ): int
		{
			return _children ? _children.indexOf( c ) : -1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function sortComponents( fieldName: Object, options: Object = null ): void
		{
			if( !_children ) return;
			
			var list: Array = _children.sortOn( fieldName, options );
			
			if( list ) _children = list;
			
			var n: int = componentCount;
			
			for( var i: int = 0; i < n; ++i )
			{
				display.addChild( getAt( i ).display );
			}
			
			invalidate();
		}

		/**
		 * @inheritDoc
		 */
		public function get componentCount(): int
		{
			return _children ? _children.length : 0;
		}
		
		/**
		 * @inheriDoc
		 */
		override public function measure(): void
		{
			super.measure( );
			
			if( _layout ) _layout.measure( this );
		}

		/**
		 * @inheriDoc
		 */
		override public function arrange(): void
		{
			if( _layout ) _layout.arrange( this );
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose(): void
		{
			super.dispose( );
			
			if( !_children ) return;
			
			var a: Array = _children.slice( );
			var n: int = a.length;
			
			while( --n > -1 ) IDisposable( a[ n ] ).dispose( );
			
			a = null;
			_children = null;
			_displayMap = null;
		}
		
		/**
		 * @inheriDoc
		 */
		override public function toString(): String
		{
			return "[ Container ]";
		}
	}
}
