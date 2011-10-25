package com.ab.core 
{
	/**
	 * ...
	 * @author Antonio Brandao
	 */
	
	//import com.ab.core.COREApi;
	//import flash.events.Event;
	//import flash.events.FileListEvent;
	//import flash.filesystem.*;
	//import flash.utils.ByteArray;
	//import org.casalib.util.ArrayUtil;
	//import org.nochump.util.zip.*;
	
	public class ZipManager 
	{
		//private var zipOutput:File;
		//private var zipFile:ZipOutput;
		
		public function ZipManager() 
		{
			
		}
		
		//public function createZIP(_files:Array, _text:String="Important: Please include '.zip' in the end of the file name"):void
		//{
			//var files:Array = new Array();
			//var __files:Array = new Array();
			//
			//if (zipFile   != null) 	{ zipFile   = null; }
			//if (zipOutput != null) 	{ zipOutput = null; }
			//
			//zipFile 	= new ZipOutput();
			//zipOutput 	= new File();
			//
			//for (var j:int = 0; j < _files.length; j++) 
			//{
				//var file_exists:Boolean = false;
				//
				//for (var k:int = 0; k < __files.length; k++) 
				//{
					//if (File(__files[k]).name == File(_files[j]).name)
					//{
						//file_exists = true;
					//}
				//}
				//
				//if (file_exists == false) 
				//{
					//__files.push(_files[j]);
				//}
			//}
			//
			//for (var i:uint = 0; i < __files.length; i++)
			//{
				//var stream:FileStream 	= new FileStream();
				//var fileData:ByteArray 	= new ByteArray();
				//var file:Object 		= new Object();
				//
				//var f:File = __files[i] as File;
				//stream.open(f, FileMode.READ);
				//stream.readBytes(fileData);
				//
				//file.name = f.name;
				//file.data = fileData;
				//files.push(file);
			//}
			//
			//for(var w:uint = 0; w < files.length; w++)
			//{
				//var zipEntry:ZipEntry = new ZipEntry(files[w].name);
				//zipFile.putNextEntry(zipEntry);
				//zipFile.write(files[w].data);
				//zipFile.closeEntry();
			//}
			//
			//zipFile.finish();
			//
			//zipOutput.desktopDirectory.resolvePath('package.zip'); 
			//zipOutput.browseForSave();
			//zipOutput.browseForSave(_text);
			//zipOutput.addEventListener(Event.SELECT, onSave);
			//
			//COREApi.invokePleaseWaitMessage();
		//}
		//
		//private function onSave(e:Event):void
		//{
			//COREApi.closePleaseWaitMessage();
			//
			//var archiveFile:File = e.target as File;
			//
			//if(!archiveFile.exists)
			//{
				//var stream:FileStream = new FileStream();
				//
				//stream.open(archiveFile, FileMode.WRITE);
				//stream.writeBytes(zipFile.byteArray);
				//stream.close();
			//}
		//}
	}
}