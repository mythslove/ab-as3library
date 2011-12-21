package com.ab.ui
{
	/**
	 * @author Antonio Brandao
	 * 
	 * @Requirements 
	 * 
	 * The host should provide a class to manage the change of states
	 * such as setState("some_state") followed, for example, by a switch to perform the necessary actions to invoke the new state
	 * 
	 * Strings must be used to name the states
	 * 
	 * This class must be initialized to recognize the root/start state.
	 * 
	 * example:  
	 * 
	 * new_breadcrumbs = new ShareFormsBreadcrumbs(setState);
	 * 
	 * new_breadcrumbs.setStartState("start_state");
	 * 
	 * To force moving to a new state, use new_breadcrumbs.moveTo("some_new_state");
	 * All the states ahead of the current position will be replaced with this new state
	 * 
	 */
	
	import com.ab.display.geometry.PolygonQuad;
	import com.ab.display.shapes.ArrowSoft;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	public class SimpleBreadcrumbs extends Sprite
	{
		public var states_array:Array = new Array();
		private var current_index:int = 0;
		public var button_forward:Sprite;
		public var button_back:Sprite;
		
		private var button_forward_bg:PolygonQuad;
		private var button_back_bg:PolygonQuad;
		private var arrow_forward:ArrowSoft;
		private var arrow_back:ArrowSoft;
		
		private var arrow_size:Number 		= 16;
		private var arrow_up_color:uint		= 0xFFFFFF;
		private var arrow_over_color:uint	= 0xFF0000;
		private var states_caller_function:Function;
		private var start_point_set:Boolean = false;
		
		public function SimpleBreadcrumbs(states_caller_function:Function)
		{
			this.states_caller_function = states_caller_function;
			
			button_forward			= new Sprite();
			button_back				= new Sprite();
			
			arrow_forward			= new ArrowSoft();
			arrow_back				= new ArrowSoft();
			
			arrow_forward.scaleX 	= arrow_forward.scaleY = arrow_back.scaleX = arrow_back.scaleY = 0.22;
			
			arrow_back.scaleX		= -arrow_back.scaleX;
			arrow_back.scaleY		= -arrow_back.scaleY;
			
			arrow_back.y 			= arrow_back.height + 2.5;
			arrow_back.x 			= arrow_back.width;
			
			button_forward_bg		= new PolygonQuad(arrow_back.width + 3, arrow_back.height, 0xff0000);
			button_back_bg			= new PolygonQuad(arrow_back.width + 3, arrow_back.height, 0xff0000);
			
			button_forward_bg.alpha	= 0;
			button_back_bg.alpha	= 0;
			
			var ct:ColorTransform 					= new ColorTransform();
			ct.color 								= arrow_up_color;
			arrow_forward.transform.colorTransform 	= ct;
			arrow_back.transform.colorTransform 	= ct;
			
			button_forward.x 						= arrow_size + 4;
			
			button_forward.addChild(button_forward_bg);
			button_forward.addChild(arrow_forward);
			
			button_back.addChild(button_back_bg);
			button_back.addChild(arrow_back);
			
			button_back.buttonMode  	= true;
			button_forward.buttonMode 	= true;
			
			button_back.addEventListener(MouseEvent.CLICK, 			backClickHandler, false, 0, true);
			button_forward.addEventListener(MouseEvent.CLICK, 		forwardClickHandler, false, 0, true);
			
			button_back.addEventListener(MouseEvent.ROLL_OVER, 		rollOverHandler, false, 0, true);
			button_back.addEventListener(MouseEvent.ROLL_OUT, 		rollOutHandler, false, 0, true);
			button_forward.addEventListener(MouseEvent.ROLL_OVER, 	rollOverHandler, false, 0, true);
			button_forward.addEventListener(MouseEvent.ROLL_OUT, 	rollOutHandler, false, 0, true);
			
			addChild(button_forward);
			addChild(button_back);
			
			this.visible = false;
		}
		
		public function reset():void
		{
			states_array 	= [];
			start_point_set = false;
			
			setEmptyDesign();
		}
		
		public function setStartState(start_state:String):void 
		{
			reset();
			start_point_set 	= true;
			current_index 		= 0;
			states_array.push(start_state);
		}
		
		public function moveTo(new_state:String):void
		{
			if (start_point_set) 
			{
				if (current_index != states_array.length-1) 
				{
					while ((current_index + 1) < states_array.length)	// if current position not the last, clear other states ahead to replace with only the new one
					{
						states_array.pop();
					}
				}
				
				states_array.push(new_state);
				
				current_index = states_array.length - 1;
				
				setBackOnlyDesign();
			}
			else 
			{
				trace ("SimpleBreadcrumbs ::: moveTo ::: START STATE NOT SET YET");
			}
		}
		
		private function backClickHandler(e:MouseEvent):void 
		{
			if (current_index != 0) 
			{
				current_index--;
				
				states_caller_function(states_array[current_index]);
				
				if (current_index != 0) // if not yet reached the first state
				{
					setBackAndForwardDesign();
				}
				else
				{
					setForwardOnlyDesign();
				}
			}
		}
		
		private function forwardClickHandler(e:MouseEvent):void 
		{
			if (current_index < states_array.length-1) 
			{
				current_index++;
				
				states_caller_function(states_array[current_index]);
				
				if ((current_index + 1) < states_array.length) // if not yet reached the last state
				{
					setBackAndForwardDesign();
				}
				else
				{
					setBackOnlyDesign();
				}
			}
		}
		
		private function setEmptyDesign():void 
		{
			button_forward.x = arrow_size + 4;
			button_back.x 	 = 0;
			
			this.visible 			= false;
			button_back.visible  	= false;
			button_forward.visible 	= false;
		}
		
		private function setBackOnlyDesign():void 
		{
			button_forward.x = arrow_size + 4;
			button_back.x 	 = arrow_size + 4;
			
			this.visible 			= true;
			button_back.visible  	= true;
			button_forward.visible 	= false;
		}
		
		private function setBackAndForwardDesign():void 
		{
			button_forward.x = arrow_size + 4;
			button_back.x 	 = 0;
			
			this.visible 			= true;
			button_back.visible  	= true;
			button_forward.visible 	= true;
		}
		
		private function setForwardOnlyDesign():void 
		{
			button_forward.x = arrow_size + 4;
			button_back.x 	 = 0;
			
			this.visible 			= true;
			button_back.visible  	= false;
			button_forward.visible 	= true;
		}
		
		private function rollOverHandler(e:MouseEvent):void 
		{
			var ct:ColorTransform 	 = new ColorTransform();
			ct.color 				 = arrow_over_color;
			e.currentTarget.transform.colorTransform = ct;
		}
		
		private function rollOutHandler(e:MouseEvent):void 
		{
			var ct:ColorTransform 	= new ColorTransform();
			ct.color 				= arrow_up_color;
			e.currentTarget.transform.colorTransform = ct;
		}
		
	}

}