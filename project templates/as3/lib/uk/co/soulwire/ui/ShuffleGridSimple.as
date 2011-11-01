/**
 * 
 *Main v1.00
 *27/11/2008 10:01
 * 
 *© JUSTIN WINDLE | soulwire ltd
 *http://blog.soulwire.co.uk
 * Messed with a bit by Dale Sattler, http://www.blog.noponies.com
 **/

package uk.co.soulwire.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import gs.easing.Expo;
	import gs.TweenLite;
	import itemeditor.ItemEditorSlideShowFilesViewerItem;
	import org.casalib.display.CasaSprite;

	public class ShuffleGridSimple extends CasaSprite
	{
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		private static const ITEM_SPACING:int = 0;
		private static const MOVE_BUFFER:int = 15;//num pix for any drag to be considered a move
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		public var _draggedItem:Sprite;
		private var _cols:int = 4;
		private var _oldPos:Point = new Point();
		public var _items:Array = new Array();
		private var pressing_an_item:Boolean=false;
		private var current_sprite:Sprite;
		private var mouse_position_on_item_press:Point = new Point();
		
		private var _click_function:Function;
		private var _reflow_function:Function=null;
		
		private var _visible_height:Number = 300;
		
		public function set click_function(value:Function):void  	{ _click_function = value; }
		
		public function get visible_height():Number  				{ return _visible_height;  }
		public function set visible_height(value:Number):void  		{ _visible_height = value; }
		
		public function set reflow_function(value:Function):void 
		{
			_reflow_function = value;
		}
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function ShuffleGridSimple()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			stage.addEventListener( MouseEvent.MOUSE_UP, onItemRelease );
		}
		
		private function removedHandler(e:Event):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onItemRelease);
			
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}
		
		//--------------------------------------
		//
		// PRIVATE METHODS
		//
		//--------------------------------------
		
		//--------------------------------------
		//
		// PUBLIC METHODS
		//
		//--------------------------------------
		
		public function addItem(sprite:Sprite):void
		{
			createNewSprite(sprite);
			
			reflowGridWithCurrentIndex();
		}
		
		public function addMultipleItems(new_items_array:Array):void
		{
			for (var i:int = 0; i < new_items_array.length; i++) 
			{
				createNewSprite(new_items_array[i]);
				
				reflowGridWithCurrentIndex();
			}
		}
		
		private function createNewSprite(sprite:Sprite):void 
		{
			sprite.x 			= (sprite.width  + ITEM_SPACING) * ((_items.length) % _cols);
			sprite.y 			= (sprite.height + ITEM_SPACING) * Math.floor((_items.length) / _cols);
			sprite.buttonMode 	= true;
			
			sprite.addEventListener(MouseEvent.MOUSE_DOWN, onItemPress, 		false, 0, true);
			sprite.addEventListener(Event.REMOVED_FROM_STAGE, onItemRemoved,	false, 0, true);
			
			_items.push(sprite);
			
			addChild(sprite);
		}
		
		private function onItemRemoved(e:Event):void 
		{
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_DOWN, 		onItemRemoved);
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, 	onItemRemoved);
		}
		
		//--------------------------------------
		//  REFLOW GRID
		//--------------------------------------
		public function reflowGridByDrag():void 
		{
			var i:int;
			
			//calc the index of the dragged box
			//the addition of 1 and the removal of 1 from the below numbers affects how the boxes respond to each a drop on top of them.
			var dragIndex:int = (_draggedItem.y / (_draggedItem.height + ITEM_SPACING) * _cols)  + (_draggedItem.x / (_draggedItem.width + ITEM_SPACING));
			
			//adjust index if dragging upwards
			if (_oldPos.y > _draggedItem.y ) 
			{
				dragIndex +=1
			}
			//boundary test that index, incase it was dragged to a negative position, or a position far beyond the grids bounds
			if (dragIndex > _items.length) 
			{
				dragIndex = _items.length;
			} 
			else if ( dragIndex < 0) 
			{
				dragIndex = 0;
			}
			
			//store a temp array
			var spliced:Array;
			
			//here we remove the dragged box from the boxes array, we will later add it back in
			//at its new index position
			for (i = 0; i < _items.length; i++) 
			{
				if (_draggedItem == _items[i]) 
				{
					spliced = _items.splice(i,1);
				}
			}
			//add the box back into the boxes array
			_items.splice(dragIndex, 0, spliced[0]);
			//tween into position
			for (i = 0; i < _items.length; i++) 
			{
				TweenLite.to( _items[i], 0.5, { x:(_items[i].width + ITEM_SPACING)* (i % _cols), y:(_items[i].height + ITEM_SPACING) * int(i / _cols), ease:Expo.easeInOut } );
			}
			
			if (this.y < 0)
			{
				if (this.y + this.height < visible_height )
				{
					TweenLite.to( this, 0.5, { y:visible_height - this.height, ease:Expo.easeInOut } );
				}
			}
		}
		
		public function reflowGridWithCurrentIndex():void 
		{
			//tween into position
			for (var i:int = 0; i < _items.length; i++) 
			{
				TweenLite.to( _items[i], 0.5, { x:(_items[i].width + ITEM_SPACING)* (i % _cols), y:(_items[i].height + ITEM_SPACING) * int(i / _cols), ease:Expo.easeInOut } );
			}
			
			if (this.y < 0)
			{
				if (this.y + this.height < visible_height )
				{
					TweenLite.to( this, 0.5, { y:visible_height - this.height, ease:Expo.easeInOut } );
				}
			}
		}
		
		// resets clips alphas, called from mouseup event handler
		private function resetClipsAlpha():void 
		{
			for (var i:int = 0; i < _items.length; i++) 
			{
				_items[i].alpha = 1;
			}
		}
		
		//--------------------------------------
		//
		//  EVENT HANDLERS
		//
		//--------------------------------------
		
		private function onItemPress( event:MouseEvent ):void 
		{
			pressing_an_item = true;
			
			current_sprite = null;
			current_sprite = Sprite(event.currentTarget);
			
			mouse_position_on_item_press.x = stage.mouseX;
			mouse_position_on_item_press.y = stage.mouseY;
			
			setChildIndex(current_sprite as Sprite, numChildren - 1);
			
			/// ver posicao relativa
			
			var rectangle_origin_y:Number = 0;
			
			if (this.y < 0)  { rectangle_origin_y = this.y * -1; };
			
			if (this.y + Sprite(event.currentTarget).y < 0) 
			{
				rectangle_origin_y = rectangle_origin_y + this.y + Sprite(event.currentTarget).y;
			}
			
			//Sprite(event.currentTarget).startDrag(false, new Rectangle(0, rectangle_origin_y, 500 - Sprite(event.currentTarget).width, 10 + 266 - Sprite(event.currentTarget).height));
			Sprite(event.currentTarget).startDrag(false, new Rectangle(0, rectangle_origin_y, 500 - Sprite(event.currentTarget).width, 266));
			//store a reference to what box is being dragged
			_draggedItem = Sprite(event.currentTarget);
			
			//store boxes old pos values
			_oldPos.x = event.currentTarget.x;
			_oldPos.y = event.currentTarget.y;
			//the mouse move is used to fade boxes under the dragged box, it could be used to
			//move a box away from the mouse etc
			stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
		}
		
		private function onItemRelease(event:MouseEvent ):void 
		{
			if (pressing_an_item == true) 
			{
				pressing_an_item = false;
				
				if (mouse_position_on_item_press.x == stage.mouseX && mouse_position_on_item_press.y == stage.mouseY)
				{   
					// click case
					if (_click_function != null) 
					{
						_click_function(current_sprite);
					}
				}
				else
				{
					current_sprite.stopDrag();
					
					//calc how far an item  has moved
					var dx:Number 	= Math.abs(_oldPos.x - current_sprite.x);
					var dy:Number 	= Math.abs(_oldPos.y - current_sprite.y);
					var dist:Number = Math.sqrt(dx * dx + dy * dy);
					
					//if the movement is big enough, shuffle the clips
					//if not, reset the dragged clip
					if (dist > MOVE_BUFFER) 
					{
						reflowGridByDrag();
						
						if (_reflow_function != null) 
						{
							_reflow_function();
						}
					} 
					else 
					{
						TweenLite.to( current_sprite, 0.5, { x:_oldPos.x , y:_oldPos.y, ease:Expo.easeInOut } );
					}
				}
				
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
				//reset the alpha of any boxes
				resetClipsAlpha();
			}
		}
		
		//mouse move
		//here we just alpha fade an item which its under the dragged box.
		private function handleMouseMove(event:MouseEvent = null):void 
		{
			for (var i:int = 0; i < _items.length; i++) 
			{
				if (_draggedItem != _items[i] && _draggedItem.hitTestObject(_items[i])) 
				{
					_items[i].alpha = .2;
				} 
				else 
				{
					_items[i].alpha = 1;
				}
			}
		}
		//end methods
	}

}