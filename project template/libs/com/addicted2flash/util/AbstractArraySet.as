package com.addicted2flash.util 
{
	import com.addicted2flash.util.AbstractArrayCollection;	

	/**
	 * This class provides a skeletal implementation of the ISet interface for arrays to minimize 
	 * the effort required to implement this interface.
	 * 
	 * Concrete implementations of this interface represent collections that contain no duplicate 
	 * elements and at most one null element.
	 * 
	 * @author Tim Richter
	 */
	public class AbstractArraySet extends AbstractArrayCollection implements ISet
	{
		/**
		 * Create a new <code>AbstractArraySet</code>
		 * 
		 * @param field (optional) an existing Array
		 */
		public function AbstractArraySet( field: Array = null )
		{
			super( null );
			
			if( field != null )
			{
				internalAddList( field );
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function add( o: * ): void
		{
			if( !contains( o ) )
			{
				super.add( o );
			}
		}
		
				
		/**
		 * @private
		 */
		private function internalAddList( field: Array ): void
		{
			var i: int = 0;
			var n: int = field.length;
			
			for( ; i < n; ++i )
			{
				add( field[ i ] );
			}
		}
	}
}
