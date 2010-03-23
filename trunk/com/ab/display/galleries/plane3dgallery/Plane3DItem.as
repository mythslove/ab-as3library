package com.ab.display.galleries.plane3dgallery 
{
	/**
	* @author ABº
	*/
	
	//import com.ab.display.Image;
	import caurina.transitions.Tweener;
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.display.ABSprite;
	import com.ab.events.CentralEventSystem;
	import com.ab.ui.SimpleFrame;
	import com.ab.utils.Make;
	import com.ab.utils.Move;
	import com.bumpslide.ui.Image
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	//import sekati.ui.Image
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import org.casalib.util.RatioUtil;
	//import caurina.transitions.properties.TextShortcuts;
	//import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.properties.FilterShortcuts;
	
	public class Plane3DItem extends ABSprite
	{
		public var beVisibleOnLoadImage:Boolean=false;
		public var frame:SimpleFrame;
		public var init_y:Number;
		
		private var _index:Number;
		private var _title:String;
		private var _text:String;
		private var _image:String;
		private var _fullimage:String;
		private var _target:Plane3DGallery;
		
		private var _image_display_object:Image;
		
		private var _max_width:Number  = 129;
		private var _max_height:Number = 86;
		
		private var _selected_frame:MovieClip;
		private var _roll_over_frame:MovieClip;
		
		private var _selected:Boolean = false;
		
		public function Plane3DItem() 
		{
			CentralEventSystem.singleton.addEventListener(ItemEvent.OPEN_ITEM, openItemEventListener, false, 0, true);
			
			FilterShortcuts.init();
			
			this.addEventListener(Event.ADDED_TO_STAGE, 	addedHandler, 	false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler, false, 0, true);
			this.addEventListener(MouseEvent.CLICK, 		clickHandler, 	false, 0, true);
		}
		
		public function clickAction():void 
		{
			trace ("Plane3DItem ::: clickAction();"); 
			
			var open_object:Object = new Object();
			
			open_object.type 		= "IMAGE";
			open_object.instruction = "LOAD_MEDIA";
			open_object.url 		= _fullimage;
			
			_target.itemClickHandler(this);
			
			Tweener.addTween(this, { z:-50, time:0.5} );
			
			frame.alpha = 0;
			frame.visible = true;
			
			Tweener.addTween(frame, { alpha:1, _Glow_blurX:5, _Glow_blurY:5, _Glow_quality:15, time:2 } );
			
			_selected = true;
			
			CentralEventSystem.singleton.dispatchEvent(new ItemEvent(ItemEvent.OPEN_ITEM, open_object));
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			clickAction();
		}
		
		private function addedHandler(e:Event):void 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			_image_display_object = new Image(_image, "resize", _max_width, _max_height, imageLoadComplete);
			
			_image_display_object.fadeOnLoad = true;
			
			this.addChild(_image_display_object);
		}
		
		private function imageLoadComplete(e:Event):void
		{
			//trace ("Plane3DItem ::: imageLoadComplete = "); 
			
			this.width 		= _max_width;
			
			frame	 		= new SimpleFrame(this, 4);
			
			this.addChild(frame);
			
			if (beVisibleOnLoadImage == false) 
			{
				frame.alpha = 0;
			}
			else
			{
				litFrame();
				
				_selected = true;
				
				var open_object:Object = new Object();
				
				open_object.type 		= "IMAGE";
				open_object.instruction = "LOAD_MEDIA";
				open_object.url 		= _fullimage;
				
				CentralEventSystem.singleton.dispatchEvent(new ItemEvent(ItemEvent.OPEN_ITEM, open_object));
				
				_target.itemClickHandler(this);
			}
			
			
			Make.MCRollOverRollOut(this, rollOver, rollOut);
		}
		
		private function rollOver(o:*):void
		{
			if (_selected == false)   { litFrame(); }
		}
		
		private function unlitFrame():void 		{ Tweener.addTween(frame, { alpha:0, _Glow_blurX:0,  _Glow_blurY:0,  _Glow_quality:15, time:2 } ); }
		private function litFrame():void		{ frame.alpha = 0; frame.visible = true; Tweener.addTween(frame, { alpha:1, _Glow_blurX:15, _Glow_blurY:15, _Glow_quality:15, time:2 } ); }
		
		private function rollOut(o:*):void
		{
			if (_selected == false)   { unlitFrame(); }
			
			//else
			//{
				//Tweener.addTween(frame, { _Glow_blurX:5, _Glow_blurY:5, _Glow_quality:15, time:2 } );
			//}
		}
		
		private function openItemEventListener(e:ItemEvent):void 
		{
			if (e.data.instruction != null) 
			{
				if (e.data.instruction == "LOAD_MEDIA")
				{
					if (e.data.type == "IMAGE") 
					{ 
						if (e.data.url != _fullimage) 
						{ 
							_selected = false; 
							
							/// reset Z depth
							
							if (this.z != 0)   {  Tweener.addTween(this, { z:0, time:1 } ); };
							
							if (frame != null) { frame.visible = false; };
							
							//Tweener.addTween(frame, { alpha:0, time:0.5 } );
						}
					}
				}
			}
		}
		
		public function startClose():void
		{
			if (this.hasEventListener(MouseEvent.CLICK)) 
			{
				this.removeEventListener(MouseEvent.CLICK, 			clickHandler);
			}
			
			if (this.hasEventListener(Event.ADDED_TO_STAGE)) 
			{
				this.removeEventListener(Event.ADDED_TO_STAGE, 		addedHandler);
			}
			
			Tweener.addTween(this, { alpha:0, y:y - 30, z:20, time:0.3, delay:index * 0.05, onComplete:goodbye} );
		}
		
		public function get target():Plane3DGallery 			{ return _target;  };
		public function set target(value:Plane3DGallery):void  	{ _target = value; };
		
		public function get image():String 						{ return _image;  };
		public function set image(value:String):void  			{ _image = value; };
		
		public function get fullimage():String 					{ return _fullimage;  };
		public function set fullimage(value:String):void  		{ _fullimage = value; };
		
		public function get title():String 						{ return _title; 	};
		public function set title(value:String):void  			{ _title = value; 	};
		
		public function get text():String 						{ return _text;  };
		public function set text(value:String):void  			{ _text = value; };
		
		public function get index():Number 						{ return _index; }
		public function set index(value:Number):void  			{ _index = value; }
		
		private function removedHandler(e:Event):void 
		{
			//trace ("Plane3DItem ::: removedHandler()"); 
			
			CentralEventSystem.singleton.removeEventListener(ItemEvent.OPEN_ITEM, openItemEventListener);
			
			if (this.hasEventListener(MouseEvent.CLICK)) 
			{
				this.removeEventListener(MouseEvent.CLICK, 			clickHandler);
			}
			
			if (this.hasEventListener(Event.REMOVED_FROM_STAGE)) 
			{
				this.removeEventListener(Event.REMOVED_FROM_STAGE, 	removedHandler);
			}
		}
		
	}
	
}