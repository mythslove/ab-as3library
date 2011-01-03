package com.niarbtfel.remoting.cache
{
	import flash.utils.setTimeout;
	
	/**
	 * A generic cache item that can be stored in an ICacheStore.
	 */
	public class RemotingCacheItem
	{
		
		/**
		 * The callback to call when this item expires.
		 */
		private var purgeCallback:Function;
		
		/**
		 * The timeout to expire.
		 */
		public var timeout:Number;
		
		/**
		 * The stored data.
		 */
		public var object:*;
		
		/**
		 * The key that was used in the actual cache.
		 */
		public var cacheKey:String;
		
		/**
		 * Creates a new RemotingCacheItem. This shouldn't be used directly, composition of RemotingCacheItems is used in
		 * a RemotingCache object.
		 * 
		 * @param		String			The key to store the object by.
		 * @param		*				The object you want stored by key.
		 * @param		Number			The expiration timeout for this item.
		 * @param		Function		The callback to call when this item expires.
		 * @return		void
		 */
		public function RemotingCacheItem(key:String, object:*, timeout:Number, purgeCallback:Function):void
		{
			this.purgeCallback = purgeCallback;
			this.cacheKey = key;
			this.timeout = timeout;
			this.object = object;
			
			if(timeout > -1)
				flash.utils.setTimeout(purgeItem, timeout);
		}
		
		/**
		 * On timeout, the item is expired.
		 * 
		 * @return		void
		 */
		private function purgeItem():void
		{
			this.purgeCallback(cacheKey);
		}
	}
}