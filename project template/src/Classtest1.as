package  
{
	/**
	* @author AB
	*/
	
	import com.ab.appobjects.ApplicationItem;
	import com.ab.display.geometry.Circle;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Classtest1 extends ApplicationItem
	{
		
		public function Classtest1() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedH);
		}
		
		private function addedH(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedH);
			
			var circle:Circle = new Circle(50, 0xff0000);
			
			this.addChild(circle);
		}
		
	}

}