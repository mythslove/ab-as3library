package  
{
	/**
	* @author AB
	*/
	
	import com.ab.appobjects.ApplicationItem;
	import com.ab.display.geometry.Circle;
	import com.ab.events.AppEvent;
	import com.ab.events.CentralEventSystem;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Classtest1 extends ApplicationItem
	{
		
		public function Classtest1() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedH);
			
			addEventListener(MouseEvent.CLICK, clickhandler);
		}
		
		private function clickhandler(e:MouseEvent):void 
		{
			CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.ACTIVITY_RESUMED, "altamente posso passar dados"));
		}
		
		public function testListener(someString:String, someInt:int):void
		{
			trace("Classtest1 :: someInt : " + someInt);
			trace("Classtest1 :: someString : " + someString);
			
		}
		
		public function testListener2(someString:String, someInt:int):void
		{
			trace("Classtest1 :: list 2: ");
			
		}
		
		private function addedH(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedH);
			
			var circle:Circle = new Circle(50, 0xff0000);
			
			this.addChild(circle);
		}
		
	}

}