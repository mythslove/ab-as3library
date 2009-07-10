package com.ab.log
{
	/**
	* @author ABº
	*/
	
	import com.ab.utils.Get;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.ab.log.ABLoggerItem;
	import caurina.transitions.Tweener;
	
	public class ABLogger extends Sprite
	{
		public static var __singleton:ABLogger;
		private var _mask:Sprite;
		private var _content:Sprite;
		private var _bg:Sprite;
		//private var _PREVIOUS_ITEMS:Array;
		
		public function ABLogger() 
		{
			trace ("ABLogger ::: Constructor()" ); 
			
			setSingleton()
			
			initVars()
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true)
		}
		
		private function initVars():void
		{
			//_PREVIOUS_ITEMS = new Array()
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler)
			
			buildVisuals()
			//buildTF()
			//buildMASK()
			/// buildScroller() when the TF becomes higher than the mask
		}
		
		private function buildVisuals():void
		{
			_bg      = new Sprite()
			_mask    = new Sprite()
			_content = new Sprite()
			
			_mask.x = 5;
			_mask.y = 5;
			
			_content.x = 5;
			_content.y = 5;
			
			//_bg.graphics.beginFill(0x222222)
			_bg.graphics.beginFill(0x222222)
			_bg.graphics.drawRect(0, 0, 200, 400);
			_bg.graphics.endFill();
			
			_mask.graphics.beginFill(0xFF0000)
			_mask.graphics.drawRect(0, 0, 190, 390);
			_mask.graphics.endFill();
			
			this.addChild(_bg)
			this.addChild(_content)
			this.addChild(_mask)
			
			_content.mask = _mask;
		}
		
		public function tracex(_string:String)
		{
			trace ("ABLogger ::: _content.numChildren = " + _content.numChildren ); 
			
			var _previous_items:Array = new Array()
			var _need_to_move:Boolean = false;
			
			if (_content.numChildren != 0) 
			{
				_previous_items = Get.AllChildren(_content);
				
				_need_to_move = true;
			}
			
			var newitem = _content.addChild(new ABLoggerItem(_string))
			
			if (_need_to_move == true) 
			{
				for (var i:int = 0; i < _previous_items.length; i++) 
				{
					//Tweener.addTween(_previous_items[i], {y:_previous_items[i].y + newitem.height, time:0.2, transition:"EaseOutSine" } ); // _previous_items[i].y += newitem.height;
					//Tweener.addTween(_previous_items[i], { y:_previous_items[i].y + newitem.height, time:0.2, transition:"EaseOutSine" } ); // _previous_items[i].y += newitem.height;
					_previous_items[i].y = _previous_items[i].y + newitem.height;
				}
			}
			
			//newitem.addEventListener(Event.ADDED_TO_STAGE, itemAddedHandler, false, 0, true)
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("ABLogger ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function getSingleton():ABLogger
		{
			if (__singleton == null)
			{
				throw new Error("ABLogger ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)")
			}
			
			return __singleton;
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}
	
}