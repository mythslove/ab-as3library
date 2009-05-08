package com.ab.utils 
{
	/**
	* ...
	* @author ABº
	* http://blog.antoniobrandao.com/
	*/
	
	import flash.display.MovieClip
	import flash.text.TextField;
	import flash.events.Event
	import flash.geom.Rectangle
	import flash.events.MouseEvent
	import com.ab.ui.MCYScroller
	import fl.motion.easing.*
	
	public class DebugTF extends MovieClip
	{
		public static var __singleton:DebugTF;
		public var t:TextField
		public var t2:TextField
		public var rectangle:Rectangle
		
		public var listscroller:MCYScroller
		
		public var title_mc:MovieClip;
		public var scrollholder_mc:MovieClip;
		public var holder_mc:MovieClip;
		public var dock_mc:MovieClip;
		public var mask_mc:MovieClip;
		
		private var dragTarget:MovieClip;
		private var itemsArray:Array;
		private var _COUNTER:Number=1;
		private var _SCROLL_ON:Boolean=false;
		
		public function DebugTF() 
		{
			setSingleton()
			
			setVars()
			
			setInteractions()
		}
		
		//////////////////////////////////////////////////////////////////////////////// SINGLETON START
		//////////////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("DebugTF ::: SINGLETON REPLICATION ATTEMPTED");
			}
			
			__singleton = this;
		}
		
		public static function getSingleton():DebugTF
		{
			if (__singleton == null)
			{
				throw new Error("DebugTF ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)");
			}
			
			return __singleton;
		}
		
		//////////////////////////////////////////////////////////////////////////////// SINGLETON END
		//////////////////////////////////////////////////////////////////////////////// SINGLETON END
		
		private function setVars():void
		{
			itemsArray = new Array()
			
			rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
		}
		
		private function setInteractions():void
		{
			dock_mc.addEventListener(MouseEvent.CLICK, dock);
			title_mc.addEventListener(MouseEvent.MOUSE_DOWN, drag);
			stage.addEventListener(MouseEvent.MOUSE_UP, drop);
			
			title_mc.buttonMode = true;
			title_mc.useHandCursor = true;
			dock_mc.buttonMode = true;
			dock_mc.useHandCursor = true;
		}
		
		private function dock(e:MouseEvent):void 
		{
			Move.ToPositionXY(this, stage.stageWidth-50, 20, 0.5, NaN, Elastic.easeOut)
		}
		
		private function drag(e:MouseEvent):void 
		{
			rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			dragTarget = e.currentTarget.parent as MovieClip;
			dragTarget.startDrag(false, rectangle);
		}
		
		private function drop(e:MouseEvent):void 
		{
			if (dragTarget != null) 
			{
				dragTarget.stopDrag();
			}
		}
		
		public function echo(input:String) 
		{
			if (_SCROLL_ON) 
			{
				listscroller.gotoZero()
			}
			
			if (itemsArray[0] != null) 
			{
				for (var i:int = 0; i < itemsArray.length; i++) 
				{
					itemsArray[i].y = itemsArray[i].y + 18
				}
			}
			
			var newitem = holder_mc.addChild(new DebugTF_item())
			
			
			newitem.num_tf.text = String(_COUNTER)
			newitem.input_tf.text = input
			
			itemsArray.push(newitem)
			
			_COUNTER ++
			
			checkScroll()
		}
		
		private function checkScroll():void
		{
			if (_SCROLL_ON != true && holder_mc.height > mask_mc.height)
			{
				listscroller = new MCYScroller(holder_mc, 135, 135)
				
				scrollholder_mc.addChild(listscroller)
				
				listscroller.init()
				
				_SCROLL_ON = true
			}
		}
	}
}