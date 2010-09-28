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
	import com.addicted2flash.layout.util.Padding;
	import com.addicted2flash.util.IDisposable;
	
	import flash.display.Sprite;		

	/**
	 * Base interface for all objects that want to be included in layout lifecycle.
	 * 
	 * @author Tim Richter
	 */
	public interface IComponent extends IDisposable
	{
		/**
		 * Returns the corresponding sprite to the component.
		 * 
		 * @return the corresponding sprite to the component
		 */
		function get display(): Sprite;

		/**
		 * Returns the parent container.
		 * 
		 * @return the parent container
		 */
		function get parent(): IContainer;
		
		/**
		 * Sets the parent container.
		 * 
		 * @param parent the parent container
		 */
		function set parent( parent: IContainer ): void;
		
		/**
		 * Returns the tool tip text this component want to show (<code>null</code>
		 * if it is not set)
		 * 
		 * @return the tool tip text this component want to show (<code>null</code>
		 * if it is not set)
		 */
		function get toolTipText(): String;
		
		/**
		 * Sets the tool tip text this component want to show.
		 * 
		 * @param text tool tip text
		 */
		function set toolTipText( text: String ): void;
		
		/**
		 * Returns the state of the component.
		 * 
		 * @return the state of the component
		 */
		function get state(): int;

		/**
		 * Sets the state of the component.
		 * <p>Notifies all registered component observers.</p>
		 * 
		 * @param state the state of the component
		 */
		function set state( state: int ): void;
		
		/**
		 * Returns the depth of the component in the tree (0 = not in tree).
		 * 
		 * @return the depth of the component in the tree
		 */
		function get depth(): int;
		
		/**
		 * Returns the horizontal alignment.
		 * 
		 * @return the horizontal alignment
		 */
		function get horizontalAlignment(): int;

		/**
		 * Sets the horizontal alignment.
		 * 
		 * @param alignment the horizontal alignment
		 * @throws IllegalOperationError if alignment is not supported
		 * @see Alignment#LEFT
		 * @see Alignment#RIGHT
		 * @see Alignment#CENTER
		 */
		function set horizontalAlignment( alignment: int ): void;

		/**
		 * Returns the vertical alignment.
		 * 
		 * @return the vertical alignment
		 */
		function get verticalAlignment(): int;

		/**
		 * Sets the vertical alignment.
		 * 
		 * @param alignment the vertical alignment
		 * @throws IllegalOperationError if alignment is not supported
		 * @see Alignment#TOP
		 * @see Alignment#BOTTOM
		 * @see Alignment#CENTER
		 */
		function set verticalAlignment( alignment: int ): void;
		
		/**
		 * Returns the padding of the component.
		 * 
		 * @return the padding of the component
		 */
		function get padding(): Padding;

		/**
		 * Sets the padding of the component.
		 * 
		 * @param padding the padding of the component
		 */
		function set padding( padding: Padding ): void;
		
		/**
		 * Returns the constraint of the component.
		 * <p>This constraint can be used by specific layouts.</p>.
		 * 
		 * @return the constraint of the component
		 */
		function get constraint(): Object;
		
		/**
		 * Sets the constraint of the component.
		 * 
		 * @param constraint the constraint of the component
		 */
		function set constraint( constraint: Object ): void;
		
		/**
		 * Returns the x-position of the component.
		 * 
		 * @return the x-position of the component
		 */
		function get x(): Number;

		/**
		 * Sets the x-position of the component.
		 * 
		 * @param value the x-position of the component
		 */
		function set x( value: Number ): void;
		
		/**
		 * Returns the y-position of the component.
		 * 
		 * @return the y-position of the component
		 */
		function get y(): Number;
		
		/**
		 * Sets the y-position of the component.
		 * 
		 * @param value the y-position of the component
		 */
		function set y( value: Number ): void;
		
		/**
		 * Returns the width of the component.
		 * 
		 * @return the width of the component
		 */
		function get width(): Number;
		
		/**
		 * Sets the width of the component.
		 * 
		 * @param value the width of the component
		 */
		function set width( value: Number ): void;
		
		/**
		 * Returns the height of the component.
		 * 
		 * @return the height of the component
		 */
		function get height(): Number;
		
		/**
		 * Sets the height of the component.
		 * 
		 * @param value the height of the component
		 */
		function set height( value: Number ): void;
		
		/**
		 * Returns true if component uses percentaged width.
		 * 
		 * @return true if component uses percentaged width
		 */
		function get hasDesiredPercentWidth(): Boolean;
		
		/**
		 * Returns true if component uses percentaged height.
		 * 
		 * @return true if component uses percentaged height
		 */
		function get hasDesiredPercentHeight(): Boolean;
		
		/**
		 * Returns the desired percentaged width.
		 * 
		 * @return the desired percentaged width
		 */
		function get desiredPercentWidth(): Number;
		
		/**
		 * Sets the desired percentaged width.
		 * 
		 * @param value the desired percentaged width
		 */
		function set desiredPercentWidth( value: Number ): void;
		
		/**
		 * Returns the desired percentaged height.
		 * 
		 * @return the desired percentaged height
		 */
		function get desiredPercentHeight(): Number;
				
		/**
		 * Sets the desired percentaged height.
		 * 
		 * @param value the desired percentaged height
		 */
		function set desiredPercentHeight( value: Number ): void;
		
		/**
		 * Returns the desired width.
		 * <p>NOTE: if desiredWidth was set explicitly, desiredWidth
		 * is returned, otherwise the biggest value of measuredDesiredWidth
		 * and measuredMinimumWidth will be returned.</p>.
		 * 
		 * @return the desired width
		 */
		function get desiredWidth(): Number;
		
		/**
		 * Sets the desired width.
		 * 
		 * @param value the desired width
		 */
		function set desiredWidth( value: Number ): void;
		
		/**
		 * Returns the desired height.
		 * <p>NOTE: if desiredHeight was set explicitly, desiredHeight
		 * is returned, otherwise the biggest value of measuredDesiredHeight
		 * and measuredMinimumHeight.</p>.
		 * 
		 * @return the desired height
		 */
		function get desiredHeight(): Number;
		
		/**
		 * Sets the desired height.
		 * 
		 * @param value the desired height
		 */
		function set desiredHeight( value: Number ): void;
		
		/**
		 * Returns the minimum width.
		 * 
		 * @return the minimum width
		 */
		function get minimumWidth(): Number;

		/**
		 * Sets the minimum width.
		 * 
		 * @param value the minimum width
		 */
		function set minimumWidth( value: Number ): void;

		/**
		 * Returns the minimum height.
		 * 
		 * @return the minimum height
		 */
		function get minimumHeight(): Number;

		/**
		 * Returns the minimum height.
		 * 
		 * @return the minimum height
		 */
		function set minimumHeight( value: Number ): void;
		
		/**
		 * Returns the maximum width.
		 * 
		 * @return the maximum width
		 */
		function get maximumWidth(): Number;

		/**
		 * Sets the maximum width.
		 * 
		 * @param value the maximum width
		 */
		function set maximumWidth( value: Number ): void;
		
		/**
		 * Returns the maximum height.
		 * 
		 * @return the maximum height
		 */
		function get maximumHeight(): Number;
		
		/**
		 * Sets the maximum height.
		 * 
		 * @param value the maximum height
		 */
		function set maximumHeight( value: Number ): void;
		
		/**
		 * Returns the measured minimum width.
		 * 
		 * @return the measured minimum width
		 */
		function get measuredMinimumWidth(): Number;
		
		/**
		 * Sets the measured minimum width.
		 * 
		 * @param value the measured minimum width
		 */
		function set measuredMinimumWidth( value: Number ): void;

		/**
		 * Returns the measured minimum height.
		 * 
		 * @return the measured minimum height
		 */
		function get measuredMinimumHeight(): Number;

		/**
		 * Sets the measured minimum height.
		 * 
		 * @param value the measured minimum height
		 */
		function set measuredMinimumHeight( value: Number ): void;

		/**
		 * Returns the measured desired width.
		 * 
		 * @return the measured desired width
		 */
		function get measuredDesiredWidth(): Number;

		/**
		 * Sets the measured desired width.
		 * 
		 * @param value the measured desired width
		 */
		function set measuredDesiredWidth( value: Number ): void;

		/**
		 * Returns the measured desired height.
		 * 
		 * @return the measured desired height
		 */
		function get measuredDesiredHeight(): Number;

		/**
		 * Sets the measured desired height.
		 * 
		 * @param value the measured desired height
		 */
		function set measuredDesiredHeight( value: Number ): void;
		
		/**
		 * Moves the component to the given coordinates.
		 * 
		 * @param x x-position
		 * @param y y-position
		 * @return true if coordiantes have changed
		 */
		function move( x: Number, y: Number ): void;
		
		/**
		 * Resizes the component.
		 * 
		 * @param width width
		 * @param height height
		 * @return true if size has changed
		 */
		function resize( width: Number, height: Number ): void;
		
		/**
		 * Invalidates the component.
		 * <p>Component will be measured and arranged
		 * during the next render phase.</p>
		 * <p>NOTE: use this method when changes in the component does <b>not</b> affect
		 * parent components.</p>
		 */
		function invalidate(): void;
		
		/**
		 * Invalidates the component.
		 * <p>Component and all parent components (tree up to the root)
		 * will be measured and arranged during the next render phase.</p>
		 * <p>NOTE: use this method when changes in the component does affect
		 * parent components.</p>
		 */
		function invalidateTree(): void;
		
		/**
		 * Adds a componenent observer.
		 * 
		 * @param o observer to be added
		 * @param events interested events
		 */
		function addComponentObserver( o: IComponentObserver, events: int ): void;
		
		/**
		 * Removes a component observer.
		 * 
		 * @param o observer to be removed
		 */
		function removeComponentObserver( o: IComponentObserver ): void;
		
		/**
		 * Adds the given events to the given observers registered events (if it exists).
		 * 
		 * @param o observer
		 * @param events events to be added
		 */
		function addToRegisteredEvents( o: IComponentObserver, events: int ): void;
		
		/**
		 * Removes the given events from the given observers registered events (if it exists).
		 * 
		 * @param o observer
		 * @param events events to be removed
		 */
		function removeFromRegisteredEvents( o: IComponentObserver, events: int ): void;

		/**
		 * Returrns the registered events of a registered observer (if observer is not registered,
		 * this method returns 0).
		 * 
		 * @param o observer
		 * @return the registered events of a registered observer
		 */
		function getRegisteredEvents( o: IComponentObserver ): int;
		
		/**
		 * Notifies all registered observers.
		 * 
		 * @param event event
		 */
		function notifyComponentObservers( event: int ): void;
		
		/**
		 * Measures a component.
		 * <p>Within a validation cycle this method is called to let 
		 * the component measure its sizes (measuredMinimumWidth, measuredMinimumHeight,
		 * measuredDesiredWidth, measuredDesiredHeight).</p>
		 * <p>NOTE: this method is called internally!</p>
		 */
		function measure(): void;
		
		/**
		 * Arranges a component.
		 * <p>NOTE: this method is called internally!</p>
		 */
		function arrange(): void;
	}
}
