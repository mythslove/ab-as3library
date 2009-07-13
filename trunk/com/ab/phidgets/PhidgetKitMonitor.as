package com.ab.phidgets
{
	/**
	* @author ABº
	*/
	
	import com.ab.utils.Make;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class PhidgetKitMonitor extends Sprite
	{
		public static var __singleton:PhidgetKitMonitor;
		private var _totalwidth:Number=200;
		private var _totalheight:Number=160;
		private var _bg:Sprite;
		
		private var _tf_0:TextField;
		private var _tf_1:TextField;
		private var _tf_2:TextField;
		private var _tf_3:TextField;
		private var _tf_4:TextField;
		private var _tf_5:TextField;
		private var _tf_6:TextField;
		private var _tf_7:TextField;
		
		private var _tf_monitor_0:TextField;
		private var _tf_monitor_1:TextField;
		private var _tf_monitor_2:TextField;
		private var _tf_monitor_3:TextField;
		private var _tf_monitor_4:TextField;
		private var _tf_monitor_5:TextField;
		private var _tf_monitor_6:TextField;
		private var _tf_monitor_7:TextField;
		
		private var _style:TextFormat;
		private var _visible:Boolean=false;
		
		public function PhidgetKitMonitor() 
		{
			setSingleton();
			
			this.alpha   = 0;
			this.visible = _visible;
			this.x       = 100;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true)
		}
		
		/// GETTERS / SETTERS
		
		public function get totalheight():Number 			{ return _totalheight;  }
		public function set totalheight(value:Number):void  { _totalheight = value; }
		
		public function get totalwidth():Number 			{ return _totalwidth;   }
		public function set totalwidth(value:Number):void  	{ _totalwidth = value;  }
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler)
			
			initVars()
			
			buildVisuals()
			
			setInitText()
			
			addChildren()
		}
		
		private function initVars():void
		{
			this.mouseChildren = false;
			
			_style = new TextFormat();
			_style.bold  = true;
			_style.color = 0xFFFFFF;
			_style.font  = "Arial";
			
			_bg   = new Sprite()
			
			_tf_0 = new TextField(); _tf_monitor_0 = new TextField();
			_tf_1 = new TextField(); _tf_monitor_1 = new TextField();
			_tf_2 = new TextField(); _tf_monitor_2 = new TextField();
			_tf_3 = new TextField(); _tf_monitor_3 = new TextField();
			_tf_4 = new TextField(); _tf_monitor_4 = new TextField();
			_tf_5 = new TextField(); _tf_monitor_5 = new TextField();
			_tf_6 = new TextField(); _tf_monitor_6 = new TextField();
			_tf_7 = new TextField(); _tf_monitor_7 = new TextField();
			
			_tf_0.setTextFormat(_style);
			_tf_1.setTextFormat(_style);
			_tf_2.setTextFormat(_style);
			_tf_3.setTextFormat(_style);
			_tf_4.setTextFormat(_style);
			_tf_5.setTextFormat(_style);
			_tf_6.setTextFormat(_style);
			_tf_7.setTextFormat(_style);
			
			_tf_monitor_0.setTextFormat(_style);
			_tf_monitor_1.setTextFormat(_style);
			_tf_monitor_2.setTextFormat(_style);
			_tf_monitor_3.setTextFormat(_style);
			_tf_monitor_4.setTextFormat(_style);
			_tf_monitor_5.setTextFormat(_style);
			_tf_monitor_6.setTextFormat(_style);
			_tf_monitor_7.setTextFormat(_style);
			
			_tf_monitor_0.autoSize = "left";
			_tf_monitor_1.autoSize = "left";
			_tf_monitor_2.autoSize = "left";
			_tf_monitor_3.autoSize = "left";
			_tf_monitor_4.autoSize = "left";
			_tf_monitor_5.autoSize = "left";
			_tf_monitor_6.autoSize = "left";
			_tf_monitor_7.autoSize = "left";
			
			_tf_0.autoSize = "left";
			_tf_1.autoSize = "left";
			_tf_2.autoSize = "left";
			_tf_3.autoSize = "left";
			_tf_4.autoSize = "left";
			_tf_5.autoSize = "left";
			_tf_6.autoSize = "left";
			_tf_7.autoSize = "left";
			
			_tf_0.y = _tf_monitor_0.y = 5;
			_tf_1.y = _tf_monitor_1.y = 20;
			_tf_2.y = _tf_monitor_2.y = 35;
			_tf_3.y = _tf_monitor_3.y = 50;
			_tf_4.y = _tf_monitor_4.y = 65;
			_tf_5.y = _tf_monitor_5.y = 80;
			_tf_6.y = _tf_monitor_6.y = 95;
			_tf_7.y = _tf_monitor_7.y = 110;
			
			_tf_monitor_0.x = 70;
			_tf_monitor_1.x = 70;
			_tf_monitor_2.x = 70;
			_tf_monitor_3.x = 70;
			_tf_monitor_4.x = 70;
			_tf_monitor_5.x = 70;
			_tf_monitor_6.x = 70;
			_tf_monitor_7.x = 70;
		}
		
		private function buildVisuals():void
		{
			_bg.graphics.beginFill(0xFF0000)
			_bg.graphics.drawRect(0, 0, _totalwidth, _totalheight);
			_bg.graphics.endFill();
			_bg.alpha = 0.5;
		}
		
		private function setInitText():void
		{
			_tf_0.text = "SENSOR 0: ";
			_tf_1.text = "SENSOR 1: ";
			_tf_2.text = "SENSOR 2: ";
			_tf_3.text = "SENSOR 3: ";
			_tf_4.text = "SENSOR 4: ";
			_tf_5.text = "SENSOR 5: ";
			_tf_6.text = "SENSOR 6: ";
			_tf_7.text = "SENSOR 7: ";
			
			_tf_monitor_0.text = "";
			_tf_monitor_1.text = "";
			_tf_monitor_2.text = "";
			_tf_monitor_3.text = "";
			_tf_monitor_4.text = "";
			_tf_monitor_5.text = "";
			_tf_monitor_6.text = "";
			_tf_monitor_7.text = "";
		}   
		
		private function addChildren():void
		{
			this.addChild(_bg);
			
			this.addChild(_tf_0);
			this.addChild(_tf_1);
			this.addChild(_tf_2);
			this.addChild(_tf_3);
			this.addChild(_tf_4);
			this.addChild(_tf_5);
			this.addChild(_tf_6);
			this.addChild(_tf_7);
			
			this.addChild(_tf_monitor_0);
			this.addChild(_tf_monitor_1);
			this.addChild(_tf_monitor_2);
			this.addChild(_tf_monitor_3);
			this.addChild(_tf_monitor_4);
			this.addChild(_tf_monitor_5);
			this.addChild(_tf_monitor_6);
			this.addChild(_tf_monitor_7);
			
			_tf_0.setTextFormat(_style);
			_tf_1.setTextFormat(_style);
			_tf_2.setTextFormat(_style);
			_tf_3.setTextFormat(_style);
			_tf_4.setTextFormat(_style);
			_tf_5.setTextFormat(_style);
			_tf_6.setTextFormat(_style);
			_tf_7.setTextFormat(_style);
			
			_tf_monitor_0.setTextFormat(_style);
			_tf_monitor_1.setTextFormat(_style);
			_tf_monitor_2.setTextFormat(_style);
			_tf_monitor_3.setTextFormat(_style);
			_tf_monitor_4.setTextFormat(_style);
			_tf_monitor_5.setTextFormat(_style);
			_tf_monitor_6.setTextFormat(_style);
			_tf_monitor_7.setTextFormat(_style);
		}
		
		/// PUBLIC
		/// PUBLIC
		/// PUBLIC
		
		public function updateValue(_index:int, value:Number)
		{
			trace ("PhidgetKitMonitor ::: updateValue = " + value); 
			
			this["_tf_monitor_" + _index].text = value;
			this["_tf_monitor_" + _index].setTextFormat(_style);
		}
		
		public function show():void
		{
			Make.MCVisible(this)
		}
		
		public function hide():void
		{
			Make.MCInvisible(this)
		}
		
		public function toggleVisible():void
		{
			if (this._visible == true) 
			{
				this._visible = false;
				
				hide()
			}
			else
			{
				this._visible = true;
				
				show()
			}
			
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("PhidgetKitMonitor ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function getSingleton():PhidgetKitMonitor
		{
			if (__singleton == null)
			{
				throw new Error("PhidgetKitMonitor ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)")
			}
			
			return __singleton;
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}
	
}