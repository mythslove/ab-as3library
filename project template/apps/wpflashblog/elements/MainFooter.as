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
	import com.ab.services.FlashPressBridge;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
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
			trace("MainFooter.start");
			
			navigation_pad			= new PolygonQuad(stage.stageWidth, 500, 0x111111)
			main_bar 				= new PolygonQuad(stage.stageWidth, 120)
			
			main_bar_contents 		= new Sprite();
			navigation_pad_contents	= new Sprite();
			
			addChild(navigation_pad);
			addChild(main_bar);
			
			main_bar.addChild(main_bar_contents);
			navigation_pad.addChild(navigation_pad_contents);
			
			addListeners();
			
			localResizeHandler();
			
			FlashPressBridge.singleton.getPosts(postsResultFunc);
		}
		
		private function postsResultFunc(result:Object):void 
		{
			var comments:Sprite 		= new Sprite();
			var commentsholder:Sprite 	= new Sprite();
			var tf:TextFormat			= new TextFormat();
			tf.color					= 0xffffff;
			tf.font						= "Arial";
			var headline:TextField 		= new TextField();
			headline.autoSize			= TextFieldAutoSize.LEFT;
			
			headline.defaultTextFormat	= tf;
			
			commentsholder.y = 20;
			
			navigation_pad_contents.addChild(comments);
			navigation_pad_contents.addChild(commentsholder);
			
			headline.text 				= "RECENT";
			
			for (var i:int = 0; i < result.length; i++) 
			{
				var newcommentholder:Sprite 	= new Sprite();
				var title:TextField 			= new TextField();
				title.autoSize					= TextFieldAutoSize.LEFT;
				title.defaultTextFormat			= tf;
				title.multiline					= true;
				title.condenseWhite				= true;
				title.wordWrap					= true;
				title.width						= 200;
				title.text 						= result[i].post_title;
				
				newcommentholder.addChild(title);
				
				newcommentholder.y 				= commentsholder.height;
				
				commentsholder.addChild(newcommentholder);
			}
			
			navigation_pad_contents.addChild(headline);
			navigation_pad_contents.addChild(commentsholder);
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
			
			/// elastic resizes
			var main_bar_contents_final_x:Number = (stage.stageWidth / 2) - (main_bar_contents.width / 2);
			
			Tweener.addTween(main_bar_contents, { x:main_bar_contents_final_x, time:0.5, transition:"EaseOutSine" } );
		}
		
	}

}