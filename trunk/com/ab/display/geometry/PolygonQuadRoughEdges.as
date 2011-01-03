package 
{
    /**
    * @author Slavomir Durej
    * 
    *  Creates a rough edges square
    *  
    *  usage example :
    *
	*  var sq:PolygonQuadRoughEdges = new PolygonQuadRoughEdges(500,250,0xFF00FF,3,100); 
	* 
	*  addChild(sq);
    */
	
    import flash.display.GraphicsPathCommand;
    import flash.display.Shape;
	
    public class PolygonQuadRoughEdges extends Shape 
    {
        private var w                     : int;        //shape height
        private var h                     : int;        //shape width
        private var col                    : Number;    //shape background color
        private var distortion             : int;        //amount of distortion ( 0 - 20 )
        private var density                : int;        //verticles density    ( 1 - 200 )
        
        private var nuVertsVertical        : int;
        private var nuVertsHorizontal    : int;
        
        /**
         * @param w: width
         * @param h: height
         * @param col: background color
         * @param distortion: amount of edges distortion (wawe-iness)
         * @param density : density of distored vertexes
         * 
         */
        public function PolygonQuadRoughEdges(w : int = 200, h : int = 40, col : Number = 0x000000, distortion : int = 2, density    : int = 12)
        {
            this.w                 = w;
            this.h                 = h;
            this.col             = col;
            this.distortion     = distortion;
            this.density        = density;
            
            init();
        }
        
        private function init():void
        {
            var hRatio            : Number     = density/w;
            var vRatio            : Number     = density/h;
            
            var ratio            : Number;
            
            if(hRatio>=vRatio) ratio = hRatio;
            else ratio     = vRatio;
            
            nuVertsVertical     = h*ratio;
            nuVertsHorizontal     = w*ratio;
            
            //round up to even number
            if (nuVertsVertical%2!=0)     nuVertsVertical++;
            if (nuVertsHorizontal%2!=0) nuVertsHorizontal++;
            
            draw();
        }
        
        private function draw():void
        {
            var commands     : Vector.<int>         = new Vector.<int>();
            var coord         : Vector.<Number>     = new Vector.<Number>();
            
            commands[0] = GraphicsPathCommand.MOVE_TO;
            
            //draw top side
            for (var i : Number = 0; i < nuVertsHorizontal; i++) 
            {
                if (i%2==0)
                {
                    commands.push(GraphicsPathCommand.LINE_TO);
                    coord.push(i/nuVertsHorizontal*w);
                }
                else
                {
                    coord.push(Math.random()*distortion);    
                }    
            }
            
            
            //draw right side
            for (i = 0; i < nuVertsVertical; i++) 
            {
                if (i%2==0)
                {
                    commands.push(GraphicsPathCommand.LINE_TO);
                    coord.push(-distortion/2 + w + Math.random()*distortion);    
                }
                else
                {
                    coord.push(i/nuVertsVertical*h);
                }    
            }
            
            
            //draw bottom side
            for (i = 0; i < nuVertsHorizontal; i++) 
            {
                if (i%2==0)
                {
                    commands.push(GraphicsPathCommand.LINE_TO);
                    coord.push(w - (i/nuVertsHorizontal*w));
                }
                else
                {
                    coord.push(-distortion/2 + h + Math.random()*distortion);    
                }    
            }
            
            //draw left side
            for (i = 0; i < nuVertsVertical; i++) 
            {
                if (i%2==0)
                {
                    commands.push(GraphicsPathCommand.LINE_TO);
                    coord.push(Math.random()*distortion);    
                }
                else
                {
                    coord.push(h - (i/nuVertsVertical*h));
                }    
            }
              graphics.beginFill(col);
            graphics.drawPath(commands, coord);
        }
    }
}