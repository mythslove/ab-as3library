package com.niarbtfel.remoting.cache
{	
	
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import com.niarbtfel.remoting.cache.IRemotingCacheStore;
	
	/**
	 * Utility class for memory caching.
	 */
	public class RemotingCache implements IRemotingCacheStore
	{
		/**
		 * The memory cache
		 */	
		private var cache:Dictionary;
		
		/**
		 * The interval pointer that is purging
		 * all cache.
		 */
		private var purgeAllInterval:Number;
		
		/**
		 * New CacheObject
		 * 
		 * @param		Number		An interval rate that purges all cached items. If not specified, or -1 is supplied,
		 * it will never purge all items. You can re-apply / re-set the interval by calling setPurgeAllInterval.
		 */
		public function RemotingCache(purgeAllTimeout:Number=-1)
		{
			if(purgeAllTimeout > -1)
				purgeAllInterval = flash.utils.setInterval(purgeAll, purgeAllTimeout);
			cache = new Dictionary(true);
		}
		
		/**
		 * Purges all cache.
		 * 
		 * @return 		void
		 */
		public function purgeAll():void
		{
			cache = new Dictionary(true);
		}
		
		/**
		 * Set/Re-set the purge all interval.
		 * 
		 * @param		Number		The time (in milliseconds) to purge the cache.
		 * @return 		void
		 */
		public function setPurgeAllInterval(interval:Number):void
		{
			clearInterval(purgeAllInterval);
			setInterval(purgeAll,interval);
		}
		
		/**
		 * Purge one item.
		 * 
		 * @param		*		The key used to store the object
		 * @return 		void
		 */
		public function purgeItem(key:*):void
		{
			if(!cache[key])
			{
				return;
			}
			else if(cache[key])
			{
				delete cache[key];
				cache[key] = null;
			}
		}
		
		/**
		 * Caches an object in the memory cache.
		 * 
		 * @param		*			The key to store the object by.
		 * @param		*			The object data.
		 * @param		Number		The timeout to expire this item after.
		 * @return		void
		 */
		public function cacheObject(key:*, obj:*, expiresTimeout:Number=-1):void
		{
			if(!cache[key])
			{
				var cacheItem:RemotingCacheItem = new RemotingCacheItem(key,obj,expiresTimeout,purgeItem);
				cache[key] = cacheItem;
			}
		}
		
		/**
		 * Test whether or not an object is cached.
		 * 
		 * @param		* 		The key used to register the object into cache.
		 * @return 		Boolean
		 */
		public function isCached(key:*):Boolean
		{
			if(!cache[key])
				return false;
			else
				return true;		
		}
		
		/**
		 * Get's a cached Object.
		 * 
		 * @param		* 		The key used to register the object into cache.
		 * @throws 		Error
		 * @return 		*
		 */
		public function getCachedObject(key:*):*
		{
			if(!cache[key])
				throw new Error("No cached item existed for " + key.toString() + " use the isCached() " +  "function before blindly calling getCachedItem");
			
			if(cache[key])
			{
				var item:RemotingCacheItem = cache[key] as RemotingCacheItem;
				return item.object;
			}
		}
	}
}