package wpflashblog.elements
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.appobjects.ApplicationItem;
	import com.ab.display.geometry.PolygonQuad;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MainFooter extends ApplicationItem
	{
		private var main_bar:PolygonQuad;
		private var main_bar_contents:Sprite;
		
		private var navigation_pad:PolygonQuad;
		private var navigation_pad_contents:Sprite;
		
		public function MainFooter() 
		{
			/// logo & brief description
			/// ab on linkedin
			
			/// - recent posts
			/// - recent comments
			/// - about me
		}
		
		override public function start():void
		{
			navigation_pad			= new PolygonQuad(stage.stageWidth, 500, 0x111111)
			main_bar 				= new PolygonQuad(stage.stageWidth, 120)
			main_bar_contents 		= new Sprite();
			navigation_pad_contents	= new Sprite();
			
			this.addChildAt(navigation_pad, 0);
			this.addChildAt(main_bar, 1);
			
			//main_bar.addChild(main_bar_contents);
			//navigation_pad.addChild(navigation_pad_contents);
			
			addListeners();
			
			localResizeHandler();
		}
		
		private function addListeners():void 
		{
			stage.addEventListener(Event.RESIZE, localResizeHandler);
			
			this.addEventListener(MouseEvent.ROLL_OUT,  rollOutHandler);
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
		}
		
		private function rollOverHandler(e:MouseEvent):void 
		{
			var np_new_y:Number = stage.stageHeight - navigation_pad.height;
			
			Tweener.addTween(navigation_pad, { y:np_new_y, time:0.5, transition:"EaseOutExpo" } );
		}
		
		private function rollOutHandler(e:MouseEvent):void 
		{
			Tweener.addTween(navigation_pad, { y:stage.stageHeight, time:0.8, transition:"EaseOutExpo" } );
		}
		
		private function localResizeHandler(e:Event=null):void 
		{
			/// instant resizes
			main_bar.width 			= stage.stageWidth;
			navigation_pad.width	= stage.stageWidth;
			
			main_bar.y 				= stage.stageHeight - main_bar.height;
			navigation_pad.y 		= stage.stageHeight;
			
			/*
			/// elastic resizes
			var main_bar_contents_final_x:Number = (stage.stageWidth / 2) - (main_bar_contents.width / 2);
			
			Tweener.addTween(main_bar_contents, { x:main_bar_contents_final_x, time:0.5, transition:"EaseOutSine" } );*/
		}
		
		
	}

}