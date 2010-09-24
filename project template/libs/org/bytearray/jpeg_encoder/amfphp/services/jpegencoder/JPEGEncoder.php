<?php

class JPEGEncoder 

{

	function JPEGEncoder ( )
	
	{
	
	}
	
	/**
	@desc save the JPEG on server
	*/
	function saveToServer ( $pInfos )
	
	{
		
		$bytearray = $pInfos["jpegstream"];
		// bytearray is in the ->data property
		$imageData = $bytearray->data;
		$idimage = "capture.jpg";
		
		return ( $success = file_put_contents("../../../pictures/".$idimage, $imageData) ) ? $idimage : $success;
	 
	}

}

?>