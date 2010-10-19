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
	import com.addicted2flash.layout.core.IComponent;
	import com.addicted2flash.layout.strategy.ILayout;
	
	import flash.display.DisplayObject;		

	/**
	 * @author Tim Richter
	 */
	public interface IContainer extends IComponent 
	{
		/**
		 * Returns the layout.
		 * 
		 * @return the layout
		 */
		function get layout(): ILayout;
		
		/**
		 * Sets the layout.
		 * 
		 * @param layout the layout
		 */
		function set layout( layout: ILayout ): void;
		
		/**
		 * Adds a component.
		 * 
		 * @param c component to be added
		 * @param constraint constraint
		 * @return added component
		 */
		function add( c: IComponent, constraint: Object = null ): IComponent;
		
		/**
		 * Adds a component at a given index.
		 * 
		 * @param i index
		 * @param c component to be added
		 * @param constraint constraint
		 * @return added component
		 */
		function addAt( i: int, c: IComponent, constraint: Object = null ): IComponent;
		
		/**
		 * Removes a given component.
		 * 
		 * @param c component to be removed
		 * @return removed component
		 */
		function remove( c: IComponent ): IComponent;
		
		/**
		 * Removes a given component at a given index.
		 * 
		 * @param i index of the component
		 * @return removed component
		 */
		function removeAt( i: int ): IComponent;
		
		/**
		 * Removes all components.
		 */
		function removeAll(): void;
		
		/**
		 * Returns the component at the given index.
		 * 
		 * @param i index of the component
		 * @return the component at the given index
		 */
		function getAt( i: int ): IComponent;
		
		/**
		 * Returns the corresponding component to the given display object.
		 * 
		 * @param display display object
		 * @return the corresponding component to the given display object (<code>null</code>
		 * if it does not exist)
		 */
		function getBy( display: DisplayObject ): IComponent;
		
		/**
		 * Sets a component at a given index.
		 * <p>NOTE: if a component exists at the given index, it will be removed.</p>
		 * 
		 * @param c component to be added
		 * @param constraint constraint
		 * @return added component
		 */
		function setAt( i: int, c: IComponent, constraint: Object = null ): IComponent;
		
		/**
		 * Sorts all children on the given arguments.
		 * <p>NOTE:container will rearrange its children afterwards.</p>
		 * 
		 * @see Array#sortOn
		 */
		function sortComponents( fieldName: Object, options: Object = null ): void;
		
		/**
		 * Returns true if given component is within the containers component list.
		 * 
		 * @param c component
		 * @return true if given component is within the containers component list
		 */
		function containsComponent( c: IComponent ): Boolean;
		
		/**
		 * Returns the index of the given component (-1 if it does not exist).
		 * 
		 * @param c component
		 * @return the index of the given component (-1 if it does not exist) 
		 */
		function indexOfComponent( c: IComponent ): int;
		
		/**
		 * Returns the total amount of components within the containers list.
		 * 
		 * @return the total amount of components within the containers list
		 */
		function get componentCount(): int;
	}
}
