package metaballs
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class MetaballsMain extends Sprite
	{
		private var screen:Bitmap;
		private var bd:BitmapData;
		private var balls:Array;
		private var goo:Number;
		private var threshold:Number;
		private var maxBalls:Number;
		private var smallest:Number;
		
		public function MetaballsMain():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			initscreen(stage.stageWidth,stage.stageHeight);
			maxBalls = 5;
			generateBalls(maxBalls,1,3);
			goo = 2;
			threshold = 0.0005;
			stage.addEventListener(Event.ENTER_FRAME,update);
			stage.addEventListener(MouseEvent.CLICK,mcl);
			stage.frameRate = 60;
		}
		
		private function mcl(e:MouseEvent):void
		{
			generateBalls(maxBalls,1,3);
		}
		
		private function initscreen(w:Number, h:Number):void
		{
			bd = new BitmapData(w,h);
			screen = new Bitmap(bd);
			addChild(screen);
		}
		
		private function generateBalls(num:Number, minSize:Number, maxSize:Number):void
		{
			balls = new Array(num);
			smallest = 100000;
			
			for (var i:int = 0; i < num; i++)
			{
				var bs:Number = minSize+Math.round(Math.random()*(maxSize-minSize));
				if(bs<smallest)
					smallest = bs;
				balls[i] = new Ball(bs, //size
									Math.round(maxSize + (Math.random() * (bd.width-maxSize))), //posX;
									Math.round(maxSize + (Math.random() * (bd.height-maxSize)))); //posY;
			}			
		}
		
		private function update(e:Event):void
		{
			bd.fillRect(bd.rect,0xff000000);
			balls[0].pos.x = mouseX;
			balls[0].pos.y = mouseY;
			drawBalls(rungeKutta2,10); // (method, step);
		}
		
		private function drawBalls(differentialMethod:Function, step:Number):void 
		{
			var curBall:Ball;
			
			for (var i:int = 0; i < maxBalls; i++)
			{
				curBall 			= balls[i];				
				curBall.pos0 		= trackTheBorder(curBall.pos.add(new Point(0,1)));
				curBall.edgePos 	= curBall.pos0;
				curBall.tracking 	= true;
				bd.fillRect(new Rectangle(curBall.pos.x,curBall.pos.y,5,5),0xffff0000);
			}
			
			balls[0].size = 1;
			
			var loopindex:Number = 0;
			var oldPos:Point;
			var tmp:Number;
			var tracking:Number;
			
			while (loopindex < 200)
			{
				loopindex += 1;
				
				for (var iii:int = 0; iii < maxBalls; iii++)
				{
					curBall = balls[iii];
					
					if (curBall.tracking != true)
					{
						continue;
					}
					
					oldPos = curBall.edgePos;
					bd.fillRect(new Rectangle(oldPos.x,oldPos.y,2,2),0xffffffff);
					
					curBall.edgePos = differentialMethod(curBall.edgePos,step,calcTangent);
					curBall.edgePos = stepOnceTowardsBorder(curBall.edgePos);
					
					for (var ii:int = 0; ii < maxBalls; ii++)
					{
						if (((balls[ii] != curBall) || (loopindex > 3)) && (pabs(balls[ii].pos0.subtract(curBall.edgePos)) < step))
						{
							curBall.tracking = false;
						}
					}
				}
				
				tracking = 0;
				
				for (var ij:int = 0; ij < maxBalls; ij++)
				{
					if(balls[ij].tracking)
						tracking += 1;
				}
				
				if(tracking==0)
					break;
			}
		}
		
		private function pabs(p:Point):Number
		{
			return Math.sqrt(p.x*p.x + p.y*p.y);
		}
		
		private function calcForce(pos:Point):Number
		{
			var force:Number = 0;
			
			for (var i:int = 0; i < maxBalls; i++)
			{
				var div:Number = Math.pow(pabs(balls[i].pos.subtract(pos)), goo);
				
				if (div != 0)
				{
					force += (balls[i].size / div);
				}
				else
				{
					force += 10000;
				}
			}
			return force;
		}
		
		private function calcNormal(pos:Point):Point
		{
			var np:Point = new Point(0, 0);
			
			for (var i:int = 0; i < maxBalls; i++)
			{
				var div:Number = Math.pow(pabs(balls[i].pos.subtract(pos)),2+goo);
				np = np.add(new Point(balls[i].pos.subtract(pos).x*(-goo*balls[i].size/div),balls[i].pos.subtract(pos).y*(-goo*balls[i].size/div)));
			}
			
			return new Point(np.x/pabs(np),np.y/pabs(np));
		}
		
		private function pmul(v:Point, n:Number):Point
		{
			return new Point(v.x*n,v.y*n);
		}
		
		private function calcTangent(pos:Point):Point 
		{
			
			var np:Point = calcNormal(pos);
			return new Point(-np.y,np.x);
		}
		
		private function rungeKutta2(pos:Point, h:Number, func:Function):Point
		{
			return pos.add(new Point(func(pos.add(new Point(func(pos).x*h/2,func(pos).y*h/2))).x*h,func(pos.add(new Point(func(pos).x*h/2,func(pos).y*h/2))).y*h));
		}
		
		private function stepOnceTowardsBorder(pos:Point):Point
		{
			var force:Number 	= calcForce(pos);
			var np:Point 		= calcNormal(pos);
			var stepsize:Number = Math.pow(smallest/threshold,1/goo) - Math.pow(smallest/force,1/goo) + 0.01;
			return pos.add(new Point(np.x*stepsize,np.y*stepsize));
		}
		
		private function trackTheBorder(posi:Point):Point
		{
			var force:Number = 9999999;
			var pos:Point = posi;
			var tries:Number = 0;
			
			while (force > threshold)
			{
				tries += 1;
				force = calcForce(pos);
				pos = stepOnceTowardsBorder(pos);
				bd.fillRect(new Rectangle(pos.x, pos.y, 2, 2), 0xff00ffff);
				
				if(tries>200)
							force = 0;
			}
			
			return pos;
		}
		
		private function euler(pos:Point, h:Number, func:Function):Point
		{
			return pos.add(pmul(func(pos),h));
		}
	}
}