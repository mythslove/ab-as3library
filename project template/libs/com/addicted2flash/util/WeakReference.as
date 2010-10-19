package com.addicted2flash.util 
{
	import flash.utils.Dictionary;	
	
	/**
	 * Flash based interpretation of an weak referenced object 
	 * (influenced by http://www.bigroom.co.uk/blog/create-your-own-weak-references-in-actionscript-3).
	 * 
	 * A weak reference is a reference that does not protect the referent object 
	 * from collection by a garbage collector. An object referenced only by weak 
	 * references is considered unreachable (or "weakly reachable") and so may 
	 * be collected at any time. Weak references are used to prevent circular 
	 * references and to avoid keeping in memory referenced by unneeded objects.
	 *  
	 * @author Tim Richter
	 */
	public class WeakReference implements IDisposable
	{
		private var _dict: Dictionary;
		
		/**
		 * Create a new <code>WeakReference</code>.
		 * 
		 * @param value referenced object
		 */
		public function WeakReference( value: * )
		{
			_dict = new Dictionary( true );
			
			_dict[ value ] = 1;
		}
		
		/**
		 * return the referenced object.
		 * 
		 * @return referenced object
		 */
		public function get reference(): *
		{
			for( var value: * in _dict )
			{
				return value;
			}
			
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose(): void
		{
			_dict = null;
		}
		
		/**
		 * String representation of <code>WeakReference</code>.
		 * 
		 * @return String representation of <code>WeakReference</code>
		 */
		public function toString(): String
		{
			return "[ WeakReference reference=" + reference + " ]";
		}
	}
}
