package net.guttershark.control
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import net.guttershark.managers.AssetManager;
	import net.guttershark.support.preloading.Asset;
	import net.guttershark.support.preloading.events.AssetCompleteEvent;
	import net.guttershark.support.preloading.events.AssetErrorEvent;
	import net.guttershark.support.preloading.events.AssetOpenEvent;
	import net.guttershark.support.preloading.events.AssetProgressEvent;
	import net.guttershark.support.preloading.events.AssetStatusEvent;
	import net.guttershark.support.preloading.events.PreloadProgressEvent;
	import net.guttershark.support.preloading.workers.WorkerInstances;
	import net.guttershark.util.ArrayUtils;
	import net.guttershark.util.FrameDelay;	

	/**
	 * Dispatched for each asset that has completed downloading.
	 * 
	 * @eventType net.guttershark.preloading.events.AssetCompleteEvent
	 */
	[Event("assetComplete", type="net.guttershark.support.preloading.events.AssetCompleteEvent")]
	
	/**
	 * Dispatched for each asset that has started downloading.
	 * 
	 * @eventType net.guttershark.preloading.events.AssetOpenEvent
	 */
	[Event("assetOpen", type="net.guttershark.support.preloading.events.AssetOpenEvent")]
	
	/**
	 * Dispatched for each asset that has has stopped downloading because of an error.
	 * 
	 * @eventType net.guttershark.preloading.events.AssetErrorEvent
	 */
	[Event("assetError", type="net.guttershark.support.preloading.events.AssetErrorEvent")]
	
	/**
	 * Dispatched for each asset that is downloading.
	 * 
	 * @eventType net.guttershark.preloading.events.AssetProgressEvent
	 */
	[Event("assetProgress", type="net.guttershark.support.preloading.events.AssetProgressEvent")]
	
	/**
	 * Dispatched for each asset that generated an http status code other than 0 or 200.
	 * 
	 * @eventType net.guttershark.preloading.events.AssetStatusEvent
	 */
	[Event("assetStatus", type="net.guttershark.support.preloading.events.AssetStatusEvent")]
	
	/**
	 * Dispatched on progress of the entire PreloadController progress.
	 * 
	 * @eventType net.guttershark.preloading.events.PreloadProgressEvent
	 */
	[Event("preloadProgress", type="net.guttershark.support.preloading.events.PreloadProgressEvent")]
	
	/**
	 * Dispatched when the preload controller completes downloading all assets in the queue.
	 * 
	 * @eventType flash.events.Event
	 */
	[Event("complete", type="flash.events.Event")]

	/**
	 * The PreloadController class is a controller you use for loading Assets - it provides you
	 * with methods for starting, stopping, pausing, resuming and prioritizing of assets, 
	 * and registers all loaded assets with the AssetManager.
	 * 
	 * @example Using the preload controller:
	 * <listing>		
	 * import net.guttershark.control.PreloadController;
	 * import net.guttershark.managers.AssetManager;
	 * import net.guttershark.managers.EventManager;
	 * import net.guttershark.support.preloading.Asset;
	 * 
	 * public class PreloaderTest extends DocumentController 
	 * {
	 *    
	 *    public var preloader:MovieClip;
	 *    
	 *    public function PreloaderTest()
	 *    {
	 *        super();
	 *    }
	 *    
	 *    private function setupComplete():void
	 *    {
	 *        pc = new PreloadController(400);
	 *        var assets:Array = [
	 *           new Asset("assets/jpg1.jpg","jpg1"),
	 *           new Asset("assets/jpg2.jpg","jpg2"),	
	 *           new Asset("assets/png1.png","png1"),
	 *           new Asset("assets/png2.png","png2"),
	 *           new Asset("swfload_test.swf","swf1"),
	 *           new Asset("assets/sound1.mp3","snd1"),
	 *           new Asset("assets/Pizza_Song.flv","pizza")
	 *       ];
	 *       pc.addItems(assets);
	 *       em.handleEvents(pc,this,"onPC",true);
	 *       pc.prioritize(assets[4]); //prioritize the swf.
	 *       pc.start(); //start it;
	 *       pc.stop(); //pause it
	 *       setTimeout(pc.start,4000); //resume it
	 *    }
	 *    
	 *    private function onPCProgress(pe:PreloadProgressEvent):void
	 *    {
	 *        trace(pe.toString());
	 *        preloader.width = pe.pixels
	 *    }
	 *    
	 *    private function onPCAssetComplete(e:AssetCompleteEvent):void
	 *    {
	 *        trace(e.toString());
	 *    }
	 *    
	 *    private function onPCComplete(e:Event):void
	 *    {
	 *        addChild(am.getMovieClipFromSWFLibrary("swf1", "Test"));
	 *        addChild(am.getBitmap("jpg1"));
	 *    }
	 * }
	 * </listing>
	 */
	final public class PreloadController extends EventDispatcher
	{
		
		/**
		 * The number of loaded items in this instance of the PreloadController.
		 */
		private var loaded:int;
		
		/**
		 * Number of errors in this instance.
		 */
		private var loadErrors:int;

		/**
		 * An array of items to be loaded.
		 */
		private var loadItems:Array;
		
		/**
		 * A duplicate of the original load items. Used internally.
		 */
		private var loadItemsDuplicate:Array;
		
		/**
		 * The currently loading item.
		 */
		private var currentItem:Asset;
		
		/**
		 * A pool of total bytes from each item that is loading
		 * in this instance.
		 */
		private var bytesTotalPool:Array;
		
		/**
		 * A loading pool, each item that is loading has an 
		 * entry in this pool, the entry is it's bytesLoaded.
		 */
		private var bytesLoadedPool:Array;
		
		/**
		 * Stores loading item info (bl / bt)
		 */
		private var loadingItemsPool:Array;
		
		/**
		 * The total pixels to fill for this preloader.
		 */
		private var totalPixelsToFill:int;
		
		/**
		 * Flag used for pausing and resuming
		 */
		private var _working:Boolean;
		
		/**
		 * The last percent update that was dispatched.
		 */
		private var lastPercentUpdate:Number;
		
		/**
		 * The last pixel update that was dispatched.
		 */
		private var lastPixelUpdate:Number;
		
		/**
		 * The last asset that loaded.
		 */
		private var lastCompleteAsset:Asset;
		
		/**
		 * ArrayUtils singleton.
		 */
		private var art:ArrayUtils;

		/**
		 * Constructor for PreloadController instances.
		 * 
		 * @param  pixelsToFill The total number of pixels this preloader needs to fill - this is used in calculating both pixels and percent. 
		 * 
		 * @see net.guttershark.preloading.events.PreloadProgressEvent PreloadProgressEvent event
		 */
		public function PreloadController(pixelsToFill:int = 100)
		{
			if(pixelsToFill<=0) throw new ArgumentError("Pixels to fill must be greater than zero.");
			WorkerInstances.RegisterDefaultWorkers();
			art = ArrayUtils.gi();
			totalPixelsToFill = pixelsToFill;
			bytesTotalPool = [];
			bytesLoadedPool = [];
			loadingItemsPool = [];
			loadItems = [];
			loaded = 0;
			loadErrors = 0;
			_working = false;
		}
		
		/**
		 * Add items to the controller to load - if the preloader is currently working,
		 * these items will be appended to the items to load.
		 * 
		 * @param items An array of Asset instances.
		 * 
		 * @see net.guttershark.preloading.Asset Asset class
		 */
		public function addItems(items:Array):void
		{
			if(!this.loadItems[0]) this.loadItems = art.clone(items);
			else this.loadItems.concat(items);
			loadItemsDuplicate = art.clone(loadItems);
		}
		
		/**
		 * Add items to the controller to load, with top priority.
		 * 
		 * @param items An array of Asset instances.
		 * @see net.guttershark.preloading.Asset Asset class
		 */
		public function addPrioritizedItems(items:Array):void
		{
			if(!this.loadItems[0]) this.loadItems = art.clone(items);
			else
			{
				var l:int = items.length;
				var i:int = 0;
				for(i;i<l;i++)this.loadItems.unshift(items[i]);
			}
			loadItemsDuplicate = art.clone(loadItems);
		}

		/**
		 * Starts loading the assets, and resumes loading from a stopped state.
		 * 
		 * @see #stop() stop method
		 */
		public function start():void
		{
			if(!loadItems[0])
			{
				trace("WARNING: No assets are in the preloader, no preloading will start.");
				return;
			}
			_working = true;
			load();
		}
		
		/**
		 * Stops this preload controller from loading assets, if there is
		 * an asset currently loading, that asset will finish loading, but the
		 * controller will not continue after that.
		 * 
		 * @see #start() start method
		 */
		public function stop():void
		{
			_working = false;
		}

		/**
		 * Indicates whether or not this controller is doing any preloading.
		 */
		public function get working():Boolean
		{
			return _working;
		}
		
		/**
		 * The number of items left in the preload queue.
		 */
		public function get numLeft():int
		{
			return loadItems.length;
		}
		
		/**
		 * Set the number of pixels to fill, useful if
		 * the pixel calculations need to change.
		 */
		public function set pixelsToFill(px:int):void
		{
			totalPixelsToFill = px;
		}
		
		/**
		 * The last completed asset.
		 */
		public function get lastCompletedAsset():Asset
		{
			return lastCompleteAsset;
		}

		/**
		 * Prioritize an asset.
		 * 
		 * @param asset An asset instance that is in the queue to be loaded.
		 */
		public function prioritize(asset:Asset):void
		{
			if(!asset) return;
			if(!asset.source || !asset.libraryName) throw new Error("Both a source and an id must be provided on the Asset to prioritize.");
			var l:int = loadItems.length;
			var i:int = 0;
			for(i;i<l;i++)
			{
				var item:Asset = Asset(loadItems[i]);
				if(item.source == asset.source)
				{
					var litem:Asset = loadItems.splice(i,1)[0] as Asset;
					loadItems.unshift(litem);
					return;
				}
			}
		}
		
		/**
		 * Recursively called to load each item in the queue.
		 */
		private function load():void
		{
			if(!_working) return;
			var item:Asset = Asset(this.loadItems.shift());
			currentItem = item;
			loadingItemsPool[item.source] = item;
			item.load(this);
		}
		
		/**
		 * Internal method used to send out updates.
		 */
		private function updateStatus():void
		{
			var pixelPool:Number = 0;
			var pixelContributionPerItem:Number = Math.ceil(totalPixelsToFill/(loadItemsDuplicate.length-loadErrors));
			var pixelUpdate:Number;
			var percentUpdate:Number;
			for(var key:String in loadingItemsPool)
			{
				var bl:* = bytesLoadedPool[key];
				var bt:* = bytesTotalPool[key];
				if(bl == undefined || bt == undefined) continue;
				var pixelsForItem:Number = Math.ceil((bl/bt)*pixelContributionPerItem);
				//trace("update: key: " + key + " bl: " + bl.toString() + " bt: " + bt.toString() + " pixelsForItem: " + pixelsForItem);
				pixelPool += pixelsForItem;
			}
			pixelUpdate = pixelPool;
			percentUpdate = Math.ceil((pixelPool/totalPixelsToFill)*100);
			if(lastPixelUpdate>0&&lastPercentUpdate>0&&lastPixelUpdate==pixelUpdate&&lastPercentUpdate==percentUpdate) return;
			lastPixelUpdate = pixelUpdate;
			lastPercentUpdate = percentUpdate;
			dispatchEvent(new PreloadProgressEvent(PreloadProgressEvent.PROGRESS,pixelUpdate,percentUpdate));
		}
		
		/**
		 * This is used to check the status of this preloader.
		 */
		private function updateLoading():void
		{
			if(loadItems.length > 0) load();
			else if((loaded + loadErrors) >= (loadItems.length))
			{	
				_working = false;
				dispatchEvent(new PreloadProgressEvent(PreloadProgressEvent.PROGRESS,totalPixelsToFill,100));
				dispatchEvent(new Event(Event.COMPLETE));
				var fd:FrameDelay = new FrameDelay(reset,2);
			}
		}
		
		/**
		 * Resets internal state.
		 */
		public function reset():void
		{
			loadErrors = 0;
			loaded = 0;
			loadItems = [];
			loadItemsDuplicate = [];
			bytesTotalPool = [];
			bytesLoadedPool = [];
			if(currentItem) currentItem.dispose();
			currentItem = null;
			if(lastCompletedAsset) lastCompleteAsset.dispose();
			lastCompleteAsset = null;
		}
		
		/**
		 * Dispose of this preloadController.
		 */
		public function dispose():void
		{
			loadErrors = 0;
			loaded = 0;
			loadItems = null;
			loadItemsDuplicate = null;
			bytesTotalPool = null;
			bytesLoadedPool = null;
			if(currentItem) currentItem.dispose();
			currentItem = null;
			if(lastCompletedAsset) lastCompleteAsset.dispose();
			lastCompleteAsset = null;
		}

		/**
		 * @private
		 * 
		 * Every Asset in the queue calls this method on it's progress event.
		 * 
		 * @param pe AssetProgressEvent
		 */
		public function progress(pe:AssetProgressEvent):void
		{
			var item:Asset = Asset(pe.asset);
			var source:String = pe.asset.source;
			if(item.bytesTotal < 0 || isNaN(item.bytesTotal)) return;
			else if(item.bytesLoaded < 0 || isNaN(item.bytesLoaded)) return;
			if(!bytesTotalPool[source]) bytesTotalPool[source] = item.bytesTotal;
			bytesLoadedPool[source] = item.bytesLoaded;
			updateStatus();
		}
		
		/**
		 * @private
		 * 
		 * Each item calls this method on it's complete.
		 * 
		 * @param e AssetCompleteEvent
		 */
		public function complete(e:AssetCompleteEvent):void
		{
			loaded++;
			lastCompleteAsset = e.asset;
			AssetManager.gi().addAsset(e.asset.libraryName,e.asset.data,e.asset.source);
			dispatchEvent(new AssetCompleteEvent(AssetCompleteEvent.COMPLETE,e.asset));
			updateStatus();
			updateLoading();
		}
		
		/**
		 * @private
		 * 
		 * Each item calls this method on any load errors.
		 * 
		 * @param e AssetErrorEvent
		 */
		public function error(e:AssetErrorEvent):void
		{
			trace("Error loading: " + e.asset.source);
			loadErrors++;
			updateStatus();
			updateLoading();
			dispatchEvent(new AssetErrorEvent(AssetErrorEvent.ERROR,e.asset));
		}

		/**
		 * @private
		 * 
		 * Each item calls this method on an http status that is
		 * not 0 or 200.
		 * 
		 * @param e AssetStatusEvent
		 */
		public function httpStatus(e:AssetStatusEvent):void
		{
			trace("Error loading: " + e.asset.source);
			loadErrors++;
			updateStatus();
			updateLoading();
			dispatchEvent(new AssetStatusEvent(AssetStatusEvent.STATUS,e.asset,e.status));
		}

		/**
		 * @private
		 * 
		 * Each item calls this method when it starts downloading.
		 * 
		 * @param e AssetOpenEvent
		 */
		public function open(e:AssetOpenEvent):void
		{	
			dispatchEvent(new AssetOpenEvent(AssetOpenEvent.OPEN,e.asset));
		}
	}
}