package com.ab.display.effects
{
	import com.ab.display.geometry.Circle;
    import flash.display.Graphics;
    import flash.display.Sprite;
    import flash.events.Event;
	import org.casalib.display.CasaSprite;

    public class Orbiter extends CasaSprite
    {
		public var colour:uint;
        public var size :int;
        public var radius :int;
        public var speed :Number;
        
        protected var origin :Object;
        protected var angle :int;
        protected var reverse :Boolean;
        
        /**
         * Constructor method
         * 
         * @param {Sprite} o the object which to orbit
         * @param {int} size the diameter of this object
         * @param {int} radius the radius of this object's orbit
         * @param {Number} speed the speed at which this object moves along its orbit (in degrees)
         * @param {int} the angle at which to start. use a value over 360 to generate a random value
         * @param {Boolean} reverse whether or not to switch to counter-clockwise
         * @return Orbiter
         */
        public function Orbiter(o:Object, size:int=10, radius:int=30, speed:Number=6, start_angle:int=400, reverse:Boolean=false, colour:uint=0x000000)
        {
            super();
			
            this.origin 	= o;
            this.size 		= size;
            this.radius 	= radius;
            this.colour 	= colour;
            this.speed 		= speed;
            this.reverse 	= reverse;
            
			if (start_angle > 360) 
			{
				this.angle  = Math.random() * 360;
			}
			else
			{
				this.angle  = start_angle;
			}
			
            this.draw();
			
            this.addEventListener(Event.ENTER_FRAME, move, false, 0, true);
            
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
        }
		
		private function removedHandler(e:Event):void 
		{
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
			
			if (this.hasEventListener(Event.ENTER_FRAME))
			{
				this.removeEventListener(Event.ENTER_FRAME, move);
			}
		}
		
		public function stop():void
		{
			this.removeEventListener(Event.ENTER_FRAME, move);
		}
        
        /**
         * Draw the orbiter object
         * 
         * @return void
         */
        protected function draw() :void
        {
			this.addChild(new Circle(this.size, this.colour));
            //var g :Graphics = this.graphics;
            //g.lineStyle(1, 0xffffff);
            //g.beginFill(0xaaaaaa);
            //g.drawCircle(0, 0, this.size / 2);
            //g.endFill();
        }
        
        /**
         * Move the orbiter object
         * 
         * @param {Event} e the ENTER_FRAME event
         * @return void
         */
        protected function move(e :Event) :void
        {
            var rad :Number = this.angle * (Math.PI / 180);
			//trace(this.name + " angle : " + angle);
            this.x = this.origin.x + this.radius * Math.cos(rad);
            this.y = this.origin.y + this.radius * Math.sin(rad);
            
            if (this.reverse == false)
            {
                this.angle += this.speed;
            }
            else
            {
                this.angle -= this.speed;
            }
			
            this.angle %= 360;
        }
    }
}