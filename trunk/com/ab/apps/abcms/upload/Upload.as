package 
{
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	
	import com.ab.server.ServiceProxy
	import flash.display.MovieClip;
	import flash.events.MouseEvent
	import flash.net.FileReference
	import com.ab.server.ServerCommunication
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.events.DataEvent
	import flash.events.IOErrorEvent
	import flash.events.ProgressEvent
	
	public class Upload extends MovieClip
	{
		
		public var asd:ServerCommunication
		private var fr:FileReference;
		
		public function Upload()
		{
			asd = new ServerCommunication()
			mc.addEventListener(MouseEvent.CLICK, clickHandler)
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			trace("click")
			
			fr = new FileReference();
			fr.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadDataComplete);
			fr.addEventListener(Event.COMPLETE, uploadComplete);
			fr.addEventListener(IOErrorEvent.IO_ERROR, handleError);            
			fr.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			
			fr.browse();
			fr.addEventListener(Event.SELECT, doUpload);
		}
		
		private function uploadDataComplete(event:DataEvent)
		{
			
			var result:XML = new XML(event.data);
			
			trace("uploadDataComplete")
			trace('Upload Data Complete')
		 	trace('RESULT: ' + result.toString())
			trace('STATUS: ' + result.status)
		 	trace('MESSAGE: '+ result.message)
		}        
		
		private function progressHandler(event:ProgressEvent):void 
		{
            var file:FileReference = FileReference(event.target);
            trace("progressHandler: name=" + file.name + " bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }
		
		private function uploadComplete(e:Event)
		{
			trace("uploadComplete")
		}
		
		private function handleError(event:IOErrorEvent)
		{
			trace("handleError" + 'ERROR: ' + event.text);
		}
		
		private function doUpload(e:Event):void 
		{
			trace('upload file: '+ fr.name);
			
			fr.upload(new URLRequest("http://www.antoniobrandao.com/amfphp/services/upload.php"));	
		}
		
		private function callService():void
		{
			trace("callService")
			
			//ServerCommunication.getSingleton().listSectionItemsRequest("listSectionItems", "section", "1", resultHandler)
			
			//ServerCommunication.getSingleton().uploadRequest("filepath", resultHandler)
		}
		
		private function resultHandler(re:Object):void
		{
			//
		}
	}
	
}




// ServerCommunication.getSingleton().listSectionItemsRequest("listSectionItems", "section", "1", resultHandler)