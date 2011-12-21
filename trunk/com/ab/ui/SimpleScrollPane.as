package com.ab.ui 
{
	import com.ab.display.geometry.PolygonQuad;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	public class SimpleScrollPane extends Sprite
	{
		private var _active:Boolean = false;
		
		public var handle:PolygonQuad;
		public var track:PolygonQuad;
		
		private var total_width:Number;
		private var start_height:Number;
		
		private var visible_height:Number;
		private var visible_width:Number;
		
		private var content_mask:PolygonQuad;
		private var target:DisplayObject;
		
		private var handle_drag_start_point:Point;
		private var dragging_handle:Boolean=false;
		private var handle_drag_mouse_start_point:Point;
		private var handle_min_y:Number;
		private var handle_width:Number;
		private var track_height:Number;
		private var handle_ellipse_size:Number;
		private var target_final_y:Number=0;
		private var new_handle_y:Number;
		private var writing_in_a_textfield_target:Boolean=false;
		private var handle_final_y:Number=0;
		private var handle_final_height:Number=0;
		private var handle_colour:uint;
		private var handle_max_height:Number;
		
		public function SimpleScrollPane(	target:DisplayObject, 
											visible_width:Number, 
											visible_height:Number, 
											handle_width:Number 	= 6, 
											handle_colour:uint 		= 0x000000)
		{
			this.handle_width 			= handle_width;
			this.visible_width 			= visible_width;
			this.visible_height 		= visible_height;
			this.target 				= target;
			this.handle_colour 			= handle_colour;
			
			track_height 				= visible_height - 10;
			handle_ellipse_size			= handle_width / 3;
			
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, 		addedHandler);
			
			handle 				= new PolygonQuad(handle_width, track_height, handle_colour, handle_ellipse_size, handle_ellipse_size);
			track  				= new PolygonQuad(handle_width, track_height, 	handle_colour, handle_ellipse_size, handle_ellipse_size);
			
			content_mask 		= new PolygonQuad(visible_width, visible_height);
			
			target.mask			= content_mask;
			
			handle_final_height	= track_height;
			handle_max_height	= track_height;
			
			track.x 			= handle.x = (target.x + target.width) + ((visible_width - (target.x + target.width)) / 2);
			track.y 			= handle.y = (visible_height / 2 ) - (track.height / 2);
			
			handle_min_y		= track.y;
			
			this.addChild(target)
			this.addChild(content_mask)
			this.addChild(track)
			this.addChild(handle)
			
			handle.alpha 		= .6;
			track.alpha 		= .2;
			
			handle.visible 		= false;
			track.visible 		= false;
			
			handle.buttonMode 	= true;
			
			// for dragging
			handle.addEventListener(MouseEvent.MOUSE_DOWN, 	handleMouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, 	stageMouseupHandler);
			
			if (target is TextField) 
			{
				if (TextField(target).type == TextFieldType.INPUT && TextField(target).multiline == true)
				{
					TextField(target).mouseWheelEnabled = false;
					TextField(target).addEventListener(FocusEvent.FOCUS_IN,  	this.targetTextFocusInHandler);
					TextField(target).addEventListener(FocusEvent.FOCUS_OUT, 	this.targetTextFocusOutHandler);
					TextField(target).addEventListener(TextEvent.TEXT_INPUT, 	this.targetTextInputHandler);
				}
			}
		}
		
		private function targetTextInputHandler(e:TextEvent):void 
		{
			if (target.height > visible_height) 
			{
				if (!active) { active = true; };
			}
		}
		
		private function targetTextFocusInHandler(e:FocusEvent):void 
		{
			writing_in_a_textfield_target = true;
		}
		
		private function targetTextFocusOutHandler(e:FocusEvent):void 
		{
			writing_in_a_textfield_target = false;
			
			if (target.height < visible_height) 
			{
				if (active) { active = false; };
			}
		}
		
		private function stageMouseupHandler(e:MouseEvent):void 
		{
			dragging_handle = false;
		}
		
		private function handleMouseDownHandler(e:MouseEvent):void 
		{
			dragging_handle = true;
			
			handle_drag_start_point 		= new Point(handle.x, handle.y);
			handle_drag_mouse_start_point 	= new Point(stage.mouseX, stage.mouseY);
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			/// tasks: update scroller position and textfield position while writing
			
			if (active) 
			{
				if (target.height > visible_height) 
				{
					handle.visible 	= true;
					track.visible 	= true;
					
					// set size of handle relative to content size
					var percentage_of_visible_height_compared_to_content:Number = (content_mask.height * 100) / target.height
					handle_final_height = (percentage_of_visible_height_compared_to_content * visible_height) / 100;
					
					var handle_max_y:Number		= track_height - handle_final_height + track.y;
					var useful_height:Number	= handle_max_y - handle_min_y;
					
					var total_content_height_difference:Number = target.height - content_mask.height;
					
					if (dragging_handle) 
					{				
						new_handle_y = handle_drag_start_point.y + (stage.mouseY - handle_drag_mouse_start_point.y);
						
						if (new_handle_y < handle_min_y) { new_handle_y = handle_min_y; }
						if (new_handle_y > handle_max_y) { new_handle_y = handle_max_y; }
						
						
						handle_final_y = new_handle_y;
						
						var current_handle_percent:Number = Math.round((100 * (handle_final_y - handle_min_y)) / useful_height);
						
						target_final_y = -(current_handle_percent * total_content_height_difference) / 100;
					}
					else
					{
						if (writing_in_a_textfield_target) 
						{
							var is_above:Boolean = checkIfCaretIsAboveVisibleArea();
							
							if (!is_above)  { checkIfCaretIsBelowVisibleArea(); }
							
							verifyHandlePosition();
							
							verifyTextFieldPosition();
						}
					}
					
					
					if (new_handle_y < handle_min_y) { new_handle_y = handle_min_y; }
					if (new_handle_y > handle_max_y) { new_handle_y = handle_max_y; }
					if (handle_final_height > handle_max_height)  { handle_final_height = handle_max_height }
					
					handle.y 		+= (handle_final_y - handle.y) / 6;
					handle.height 	+= (handle_final_height - handle.height) / 6;
					
					target.y 		+= (target_final_y - target.y) / 6;
					
					if (handle.y > handle_max_y) { handle.y = handle_max_y; }
					if (handle.y < handle_min_y) { handle.y = handle_min_y; }
				}
				else
				{
					handle.visible 	= false;
					track.visible 	= false;
					target_final_y  = 0;
					target.y 		= 0;
					handle.y 		= handle_min_y;
				}
			}
		}
		
		private function verifyTextFieldPosition():void 
		{
			if (target.y < (content_mask.height - target.height))
			{
				target_final_y = (content_mask.height - target.height);
			}
		}
		
		private function verifyHandlePosition():void 
		{
			var total_content_height_difference:Number = target.height - content_mask.height;
			
			var actual_content_percent:Number;
			// set size of handle relative to content size
			var percentage_of_visible_height_compared_to_content:Number = (visible_height * 100) / target.height;
			
			handle_final_height = (percentage_of_visible_height_compared_to_content * visible_height) / 100;
			
			var current_caret_line:Number 	= TextField(target).getLineIndexOfChar(TextField(target).caretIndex);
			if (current_caret_line == -1)  	{  current_caret_line = TextField(target).numLines; } else { current_caret_line = current_caret_line + 1; }
			
			if (current_caret_line == TextField(target).numLines)
			{
				actual_content_percent = 100;
			}
			else
			{
				if (target_final_y < 0) 
				{
					actual_content_percent 	= Math.round((target_final_y * 100) / total_content_height_difference);
					actual_content_percent 	= actual_content_percent * -1;
				}
				else { actual_content_percent = 0; }
			}
			
			var handle_max_y:Number		= track_height - handle_final_height + track.y;
			var total_track_size:Number = handle_max_y - handle_min_y;
			new_handle_y 				= Math.ceil(handle_min_y + ((actual_content_percent * total_track_size) / 100));
			handle_final_y 				= new_handle_y;
		}
		
		private function checkIfCaretIsAboveVisibleArea():Boolean
		{
			var line_height:Number 			= TextField(target).getLineMetrics(0).height;
			var total_tf_lines:Number 	 	= TextField(target).numLines;
			var current_caret_line:Number 	= TextField(target).getLineIndexOfChar(TextField(target).caretIndex);
			// adjust caret line value
			if (current_caret_line == -1)  	{  current_caret_line = total_tf_lines; } else { current_caret_line = current_caret_line + 1; }
			var min_y_posible:Number		 = -(current_caret_line - 1) * line_height;
			
			if (target_final_y < min_y_posible) 
			{ 
				target_final_y = min_y_posible; 
				
				return true;
			}
			
			return false;
		}
		
		private function checkIfCaretIsBelowVisibleArea():void 
		{
			var line_height:Number 			 = TextField(target).getLineMetrics(0).height;
			var total_tf_lines:Number 	 	= TextField(target).numLines;
			var current_caret_line:Number 	 = TextField(target).getLineIndexOfChar(TextField(target).caretIndex);
			// adjust caret line value
			if (current_caret_line == -1)  	{  current_caret_line = total_tf_lines; } else { current_caret_line = current_caret_line + 1; }
			var caret_y:Number 				 = current_caret_line * line_height;
			var max_y_posible:Number		 = -caret_y + content_mask.height;
			
			if (target_final_y > max_y_posible) 
			{ 
				target_final_y = max_y_posible; 
			}
		}
		
		public function get active():Boolean 
		{
			return _active;
		}
		
		public function set active(value:Boolean):void 
		{
			_active = value;
			
			switch (value) 
			{
				case false: removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				break;
				
				case true:	addEventListener(Event.ENTER_FRAME, enterFrameHandler);
				break;
			}
		}
		
	}

}