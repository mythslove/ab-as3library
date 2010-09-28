package com.edigma.ui 
{
	/**
	* @author ...
	*/
	
	import com.edigma.display.EdigmaSprite;
	import com.edigma.display.Image
	
	import org.casalib.util.StageReference
	
	import flash.geom.Point
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener
	import com.gaiaframework.api.Gaia
	import flash.events.Event
	
	public class AlertWindow extends EdigmaSprite
	{
		private var bg_mc:EdigmaSprite
		private var assetholder_mc:EdigmaSprite
		private var _instance:*
		private var _animPhase1_activated:Boolean=false;
		
		public function AlertWindow(_title:String = "", _message:String = "")
		{
			this.x = 0;
			this.y = 0;
			this.alpha = 0;
			
			if (_title == "") { _title = "Azulaico" };
			
			bg_mc = new EdigmaSprite();
			assetholder_mc =  new EdigmaSprite();
			
			bg_mc.alpha = 0.6;
			
			this.addChildAt(bg_mc, 0);
			this.addChildAt(assetholder_mc, 1);
			
			_instance = assetholder_mc.addChild(new ALERT_WINDOW_ASSET());
			_instance.window_mc.title_tf.text = _title;
			_instance.window_mc.text_tf.text = _message.toUpperCase();
			
			_instance.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			bg_mc.setAlign("stretch")
			assetholder_mc.setAlign("center", true)
			
			bg_mc.graphics.beginFill(0x000000);
			bg_mc.graphics.drawRoundRect(0, 0, StageReference.getStage().stageWidth, StageReference.getStage().stageHeight, 0, 0);
			bg_mc.graphics.endFill();
			
			assetholder_mc.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			bg_mc.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			assetholder_mc.useHandCursor = true;
			assetholder_mc.buttonMode = true;
			bg_mc.useHandCursor = true;
			bg_mc.buttonMode = true;
			
			_instance.window_mc.close_mc.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			_instance.window_mc.close_mc.useHandCursor = true;
			_instance.window_mc.close_mc.buttonMode = true;
			
			GoVisible();
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			//trace("ALERT WINDOW ADDED TO STAGE")
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			if (_animPhase1_activated != true) 
			{
				_instance.window_mc.close_mc.removeEventListener(MouseEvent.CLICK, clickHandler);
				assetholder_mc.removeEventListener(MouseEvent.CLICK, clickHandler);
				bg_mc.removeEventListener(MouseEvent.CLICK, clickHandler);
				_animPhase1_activated = true;
				
				GoInvisibleWithOnComplete(0.5, endClose);
			}
		}
		
		private function endClose():void
		{
			bg_mc.removeAlign();
			assetholder_mc.removeAlign();
			
			bg_mc.destroy();
			assetholder_mc.destroy();
			
			destroy();
		}
		
		//public static function invoke(target:Object):AlertWindow
		public static function invoke(_target:Object, _title:String, _message:String):AlertWindow
		{
			var _instance:* = new AlertWindow(_title, _message);
			_target.addChild(_instance);
			return _instance;
		}
		
	}
	
}