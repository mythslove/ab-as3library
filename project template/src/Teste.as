package  
{
	import com.ab.display.ABSprite;
	import com.ab.display.geometry.Circle;
	import com.addicted2flash.layout.core.Component;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Teste extends Component
	{
		
		public function Teste() 
		{
			display.addEventListener(Event.ADDED_TO_STAGE, add);
		}
		
		private function add(e:Event):void 
		{
			display.removeEventListener(Event.ADDED_TO_STAGE, add);
			
			var bola:Circle = new Circle(20, Math.round(Math.random() * 0xFFFFFF), 0.8);
			
			//display.x = Math.random() * stage.stageWidth;
			//display.y = Math.random() * stage.stageHeight;
			
			display.addChild(bola);
			
			display.addEventListener(MouseEvent.CLICK, clkHanld)
		}
		
		private function clkHanld(e:MouseEvent):void 
		{
			//dieWithBlurOutElastic(1);
		}
		
	}

}