package
{
	/**
	*   AS3 CORE System
	* 
	*   @author ABº
	*                              .::::.                   
	*                            .::::::::.                 
	*                            :::::::::::                
	*                            ':::::::::::..             
	*                             :::::::::::::::'          
	*                              ':::::::::::.            
	*                                .::::::::::::::'       
	*                              .:::::::::::...          
	*                             ::::::::::::::''          
	*                 .:::.       '::::::::''::::           
	*               .::::::::.      ':::::'  '::::          
	*              .::::':::::::.    :::::    '::::.        
	*            .:::::' ':::::::::. :::::      ':::.       
	*          .:::::'     ':::::::::.:::::       '::.      
	*        .::::''         '::::::::::::::       '::.     
	*       .::''              '::::::::::::         :::... 
	*    ..::::                  ':::::::::'        .:' ''''
	* ..''''':'                    ':::::.'                 
	*/
	
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import org.casalib.util.StageReference;
	
	import com.ab.log.ABLogger;
	import com.ab.events.CentralEventSystem;
	
	import net.hires.debug.Stats;
	import com.edigma.web.EdigmaCore;
	
	import AppManager;
	import DataManager;
	import InactivityManager;
	
	/// IMPORT APPLICATION CLASS
	import NokiaQuiz;
	/// /// /// /// /// /// ////
	
	public class CORE extends Sprite
	{
		/// private
		private var _appInfo:EdigmaCore;
		private var _loadedSettings:Boolean=false;
		private var _loadedData:Boolean=false;
		private var _CentralEventSystem:CentralEventSystem;
		private var _appLogger:ABLogger;
		
		/// public
		public var appManager:AppManager;
		public var dataManager:DataManager;
		public var inactivityManager:InactivityManager;
		public var _appLevel:Sprite;
		
		
		public function CORE()
		{
			stage.displayState = StageDisplayState.FULL_SCREEN;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void  { init(); }
		
		private function init():void
		{ 
			StageReference.setStage(this.stage); 
			
			_appLevel  		= new Sprite();
			_appLogger 		= new ABLogger();
			_appInfo   		= new EdigmaCore(this);
			
			stage.addChild(_appLevel);
			stage.addChild(_appLogger);
			
			_appLogger.x += 300;
		}
		
		public function get loadedSettings():Boolean 				{ return _loadedSettings; }
		public function set loadedSettings(value:Boolean):void
		{ 
			/// this setter is called after EdigmaCore finishes loading settings XML
			
			_loadedSettings = value; 
			
			initMainVars();
		}
		
		private function initMainVars():void
		{
			trace ("CORE ::: initMainVars()"); 
			
			inactivityManager 	= new InactivityManager(_appInfo.INACTIVITY_TIME);
			appManager 			= new AppManager(_appLevel, NokiaQuiz);
			dataManager 		= new DataManager(this);
			
			dataManager.getData();
		}
		
		public function get loadedData():Boolean 			{ return _loadedData; }
		public function set loadedData(value:Boolean):void
		{
			/// this setter is called after DataManager finishes loading "anos.xml"
			
			trace ("CORE ::: loadedData()"); 
			
			_loadedData = value;
			
			/// here the visual application actually starts
			appManager.start();
			
			/// add stats analyser
			//var _stats = stage.addChild(new Stats())
		    //_stats.y = -100;
		}
	} 
}

/**
 * @NOTES
 * 
 * tirar o video
 * 
 * * procurar nao passar referencias aos filhos
 * 
 * 
 * mudar a cena das cartas:
 * - usar um tweenzinho no inicio para as mexer: rotation e random +/-x  |||  +/-y
 * - nenhuma deve ter enterFrame no inicio
 * 
 * 
 **/

 /// last night a clichaved my life
 //aufgang baroque
 //run it duke dumont
 
//ambivalent creeps EP
//woody woodpecker
//hobo from A to B
//lessizmore
//tolga fidan violente
//minilogue animals remixes
//robag wruhme abusus adde
//dowski roulette
//booty loops
// minimize to maximize
 
 
 




