package com.ab.display.galleries.plane3dgallery 
{
	/**
	* @author ABº
	* 
	* new_gallery_var 				= new Plane3DGallery();
	* new_gallery_var.xml_file 		= __data.xmlfile;
	* new_gallery_var.title 		= __data.title;
	* new_gallery_var.texto 		= __data.text;
	* new_gallery_var.has_vid		= has_vid;
	* new_gallery_var.loadXML();
	* 
	* addChild(new_gallery_var);
	* 
	* this class is not ready for general purpose usage, still needs to be adapted to work easily with any project
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.events.CentralEventSystem;
	import com.ab.utils.Get;
	import com.ab.utils.Make;
	import com.edigma.ui.tapscroller.TapScroller;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import hype.extended.layout.GridLayout;
	import org.casalib.util.StageReference;
	import net.guttershark.managers.LayoutManager;
	
	public class Plane3DGallery extends Sprite
	{
		public var has_vid:Boolean
		
		private var _data:Array = new Array();
		//XML Loading
		private var XMLLoader:URLLoader;
		//XML
		private var _XML:XML;
		// how many image covers
		private var _itemsTotal:Number;
		
		private var _xml_file:String;
		private var _texto:String;
		private var _title:String;
		public var holder_mc:MovieClip;
		private var holder_inside_holder_mc:MovieClip;
		private var items:Array;
		
		/**
		 * An instance of a Guttershark layout manager.
		 */
		protected var lm:LayoutManager;
		
		public function Plane3DGallery() 
		{
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler, false, 0, true);
		}
		
		public function loadXML()
		{
			XMLLoader = new URLLoader();
			XMLLoader.load(new URLRequest(_xml_file));
			XMLLoader.addEventListener(Event.COMPLETE, XMLLoader_Complete);
			XMLLoader.addEventListener(IOErrorEvent.IO_ERROR, XMLLoader_IOError);
		}
		
		// parse the XML
		private function XMLLoader_Complete(e:Event):void 
		{
			_XML				= new XML(e.target.data);
			
			_itemsTotal			= _XML.item.length();
			
			for (var i = 0; i < _itemsTotal; i++) 
			{
				//Make An Object To Hold Values
				var _obj:Object = new Object();
				
				//Set Values To Object from XML for each CoverflowItem
				_obj.fullimage 	= (_XML.item[i].@fullimage.toString());
				_obj.image 		= (_XML.item[i].@thumbnail.toString());
				_obj.title 		= (_XML.item[i].@title.toString());
				_obj.text  		= (_XML.item[i].@text.toString());
				_data[i]   		= _obj;
				
				//trace ("Coverflow ::: _obj.image = " + _obj.image ); 
			}
			
			loadThumbnails();
		}
		
		private function loadThumbnails():void
		{
			items 	= new Array();
			var num_items:int 	= 0;
			
			for each (var s in _data)  { num_items++; };
			
			holder_mc 				= new MovieClip();
			holder_inside_holder_mc = new MovieClip();
			
			this.addChild(holder_mc);
			holder_mc.addChild(holder_inside_holder_mc);
			
			for (var i:int = 0; i < num_items; i++) 
			{
				var newitem 			= new Plane3DItem(); 	/// symbol for class GalleryMenuItem is in the FLA's library
				
				newitem.target 			= this;
				
				newitem.index 			= i;
				newitem.fullimage 		= _data[i].fullimage;
				newitem.image 			= _data[i].image;
				newitem.title 			= _data[i].title;
				newitem.text 			= _data[i].text;
				
				
				if (has_vid == false && i == 0) 
				{
					newitem.beVisibleOnLoadImage = true;
					newitem.z = -50;
				}
				
				items.push(newitem);
				
				//newitem.z = 500;
				newitem.alpha = 0;				
				
				Tweener.addTween(newitem, { alpha:1, time:0.8, delay:0.1 * i } );
				
				holder_inside_holder_mc.addChild(newitem);
			}
			
			var layout:GridLayout = new GridLayout(0, 0, 129, 86, 4); // using GridLayout by HYPE framework (joshua davis)
			
			for (var x = 0; x < num_items; ++x) { layout.applyLayout(items[x]); }
			
			for (var w = 0; w < num_items; ++w) 
			{ 
				items[w].init_y 	= items[w].y;
				items[w].y 			= items[w].init_y - 200 ;
				
				Tweener.addTween(items[w], { y:items[w].init_y, time:0.8, delay:0.1 * w } );
			}
			
			//this.y = 0;
			this.x = 420;
			
			holder_mc.x 				= 258;
			
			if (num_items > 8) 
			{
				holder_mc.y 				= holder_mc.height + (holder_mc.height / 4) + 130;
				
				holder_inside_holder_mc.x 	= -258;
			}
			else
			{
				if (num_items > 4) 
				{
					holder_mc.y 				= holder_mc.height + (holder_mc.height / 4) + 200;
					
					holder_inside_holder_mc.x 	= -258;
				}
				else
				{
					if (num_items == 1) 
					{
						holder_mc.y 				= holder_mc.height + (holder_mc.height / 4) + 220;
					}
					else
					{
						holder_mc.y 				= holder_mc.height + (holder_mc.height / 4) + 200;
					}
					
					holder_inside_holder_mc.x 	= -holder_inside_holder_mc.width/2;
				}
			}
			
			holder_inside_holder_mc.y 	= -holder_inside_holder_mc.height;
			
			/// add layout manager
			lm = new LayoutManager(holder_inside_holder_mc);
			
			if (num_items != 1) 
			{
				holder_mc.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true);
				
				Tweener.addTween(holder_mc, { rotationY:40, rotationX: -20, y:holder_mc.y - 40, transition:"EaseOutQuad", time:1, delay:1.5 } );
			}
			else
			{
				holder_inside_holder_mc.x -= 48;
				holder_inside_holder_mc.y += 50;
			}
			
			if (has_vid == false) 
			{
				lm.bringToFront(items[0]);
			}
		}
		
		public function closeAllItems():void
		{
			for (var i:int = 0; i < items.length; i++) 
			{
				items[i].startClose();
				
				/*
				if (i < items.length)
				{
					Tweener.addTween(items[i], { alpha:0, y:items[i].y - 30, z:20, time:0.3, delay:i * 0.05} );
				}
				else
				{
					Tweener.addTween(items[i], { alpha:0, y:items[i].y - 30, z:20, time:0.3, delay:i * 0.05, onComplete:recall_func } );
				}*/
			}
		}
		
		public function closeAndRecallFunction(recall_func:Function):void
		{
			//var allitems:Array = new Array();
			
			//allitems = Get.AllChildren(holder_inside_holder_mc);
			
			for (var i:int = 0; i < items.length; i++) 
			{
				items[i].startClose();
				/*
				if (i < items.length)
				{
					Tweener.addTween(items[i], { alpha:0, y:items[i].y - 30, z:20, time:0.3, delay:i * 0.05} );
				}
				else
				{
					Tweener.addTween(items[i], { alpha:0, y:items[i].y - 30, z:20, time:0.3, delay:i * 0.05, onComplete:recall_func } );
				}*/
			}
		}
		
		public function itemClickHandler(item:Plane3DItem):void 
		{
			lm.bringToFront(item);
		}
		
		private function rollOverHandler(e:MouseEvent):void 
		{
			holder_mc.removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			if (StageReference.getStage().mouseX < 1360 && StageReference.getStage().mouseY < 500)
			{
				var valueX:Number = (StageReference.getStage().mouseY - 284) / 5;
				var valueY:Number = (StageReference.getStage().mouseX - 800) / 10;
				
				if (valueX > 0)		{ valueX = 0; };
				
				if (valueX < -35)	{ valueX = -35; };
				
				if (holder_mc.rotationX != valueX) { Tweener.addTween(holder_mc, { rotationX:valueX, time:0.5 } ); }
				
				if (holder_mc.rotationY != valueY) { Tweener.addTween(holder_mc, { rotationY: valueY * ( -1), time:0.5 } ); }
			}
		}
		
		//private function coverflowSettingsLoader_IOError(event:IOErrorEvent):void  	{ trace("Plane 3D XML Load Error: "+ event); }
		private function XMLLoader_IOError(event:IOErrorEvent):void		{ trace("Plane3DGallery XML Load Error: "+ event); }
		
		public function get xml_file():String 				{ return _xml_file;  };
		public function set xml_file(value:String):void  	{ _xml_file = value; };
		
		public function get texto():String 					{ return _texto;  };
		public function set texto(value:String):void  		{ _texto = value; };
		
		public function get title():String 					{ return _title;  };
		public function set title(value:String):void  		{ _title = value; };
		
		private function removedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ENTER_FRAME, 		enterFrameHandler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, 	removedHandler);
		}
		
	}
	
}