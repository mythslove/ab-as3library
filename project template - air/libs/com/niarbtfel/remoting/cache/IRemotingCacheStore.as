package com.niarbtfel.remoting.cache
{
	
	/**
	 * Interface for any class that stores objects in memory through a Cache object.
	 */
	public interface IRemotingCacheStore
	{
		
		/**
		 * Purges all cached items in a RemotingCache instance.
		 * 
		 * @return		void
		 */
		function purgeAll():void
		
		/**
		 * Purge purge one item in the cache.
		 * 
		 * @return		void
		 */
		function purgeItem(key:*):void;
		
		/**
		 * Cache an object in the cache.
		 * 
		 * @param		*			The key used to store the object with.
		 * @param		*			The object to cache.
		 * @param		Number		A number to use as the expiration.
		 * @return		void
		 */
		function cacheObject(key:*, item:*, purgeTimeout:Number=-1):void;
		
		/**
		 * Test to see if something  by "key" is cached.
		 * 
		 * @return		Boolean
		 */
		function isCached(key:*):Boolean;
		
		/**
		 * Get an object from the cache.
		 * 
		 * @param		*		The key used to store the object.
		 * @return		*
		 */
		function getCachedObject(key:*):*;
	}
}