package com.bumpslide.data {
	import com.bumpslide.util.ObjectUtil;
	
	import flash.events.EventDispatcher;		

	/**
	 * An abstract value object with reusable clone and comparison methods 
	 * 
	 * @author David Knape
	 */
	public class ValueObject extends EventDispatcher implements IValueObject {
		
		/**
		 * Returns a new VO exactly like this one
		 */
		public function clone() : Object {
			return ObjectUtil.clone( this );
		}
		
		/**
		 * Compares this VO to another
		 */
		public function equals( o:Object ) : Boolean {
			return ObjectUtil.equals( this, o );
		}
		
		/**
		 * Merge properties found in the object into this VO instance
		 */
		public function merge( o:Object ) : void {
			ObjectUtil.mergeProperties( o, this);
		}
		
		
	}
}