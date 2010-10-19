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

	/**
	 * An object that maps keys to values. A map cannot contain duplicate keys; each key can map to at most one value. 
	 * 
	 * @author Tim Richter
	 */
	public interface IMap extends IDisposable
	{
		/**
		 * Removes all of the mappings from this map (optional operation). The map will be empty after this call returns.
		 */
		function clear(): void;
		
		/**
		 * Returns true if this map contains a mapping for the specified key.
		 * 
		 * @param key key whose presence in this map is to be tested 
		 * @return true if this map contains a mapping for the specified key
		 */
		function containsKey( key:* ): Boolean;
		
		/**
		 * Returns true if this map maps one or more keys to the specified value.
		 * 
		 * @param value value whose presence in this map is to be tested
		 * @return true if this map maps one or more keys to the specified value 
		 */
		function containsValue( value: * ): Boolean;
		
		/**
		 * Returns the value to which the specified key is mapped, or null if this map contains no mapping for the key.
		 * 
		 * @param key the key whose associated value is to be returned
		 * @return the value to which the specified key is mapped, or null if this map contains no mapping for the key 
		 */
		function getValue( key: * ): *;
		
		/**
		 * Returns true if this map contains no key-value mappings.
		 * 
		 * @return true if this map contains no key-value mappings
		 */
		function isEmpty(): Boolean;
		
		/**
		 * Associates the specified value with the specified key in this map (optional operation). 
		 * If the map previously contained a mapping for the key, the old value is replaced by the specified value
		 * 
		 * @param key key with which the specified value is to be associated
		 * @param value value to be associated with the specified key 
		 * @return the previous value associated with key, or null if there was no mapping for key
		 */
		function put( key: *, value: * ): *;
		
		/**
		 * Removes the mapping for a key from this map if it is present (optional operation).
		 * Returns the value to which this map previously associated the key, or null if the map contained no mapping for the key.
		 * 
		 * @param key key whose mapping is to be removed from the map 
		 * @return the previous value associated with key, or null if there was no mapping for key
		 */
		function remove( key: * ): *;
		
		/**
		 * Returns the number of key-value mappings in this map.
		 * 
		 * @return the number of key-value mappings in this map
		 */
		function size(): int;
		
		/**
		 * Returns a Collection view of the values contained in this map. The collection is backed by the map, so changes 
		 * to the map are reflected in the collection, and vice-versa.
		 * 
		 * <p>NOTE: values removed with an <code>IIterator</code> are not removed from the <code>IMap</code>.</p>
		 * 
		 * @return a collection view of the values contained in this map
		 */
		function values(): ICollection;
		
		/**
		 * Returns a Set view of the keys contained in this map. The set is backed by the map, so changes to the map are 
		 * reflected in the set, and vice-versa.
		 * 
		 * <p>NOTE: keys removed with an <code>IIterator</code> are not removed from the <code>IMap</code>.</p>
		 * 
		 * @return a set view of the keys contained in this map
		 */
		function keySet(): ISet;
		
		/**
		 * Returns a Set view of the mappings contained in this map. The set is backed by the map, so changes to the map are 
		 * reflected in the set, and vice-versa.
		 * 
		 * <p>NOTE: <code>Entry</code> objects removed with an <code>IIterator</code> are not removed from the <code>IMap</code>.</p>
		 * 
		 * @return a set view of the <code>Entry</code> objects contained in this map
		 */
		function entrySet(): ISet;
		
		/**
		 * Returns a copy of the <code>IMap</code>.
		 * 
		 * @return a copy of the <code>IMap</code>
		 */
		function clone(): IMap;
	}
}
