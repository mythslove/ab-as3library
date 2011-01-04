package  
{
	/**
	* @author AB
	*/
	
	import com.ab.appobjects.ApplicationItem;
	import com.ab.display.geometry.Circle;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Classtest2 extends ApplicationItem
	{
		
		public function Classtest2()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedH);
		}
		
		private function addedH(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedH);
			
			var circle:Circle = new Circle(50, 0x00ff00);
			
			circle.x = 100;
			
			this.addChild(circle);
		}
		
	}

}