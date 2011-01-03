package com.soundstep.ui.layouts.core {

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> 3.0.2<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a><br />
	 * You can use BaseUI in any flash site, except to include/distribute it in another framework, application, template, component or structure that is meant to build, scaffold or generate source files.<br />
	 * <br />
	 * <b>Date:</b> 08-2008<br />
	 * <b>Usage:</b><br />
	 * Padding is the type of the padding property used in some of the subclasses of CanvasUI, like TileUI. 
	 * @example
	 * <listing version="3.0">
	 * var tile:TileUI = new TileUI();
	 * tile.padding = new Padding(10, 10, 10, 10);
	 * </listing>
	 */
	 
	public class Padding {

		//------------------------------------
		// private properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public var top:Number;
		public var bottom:Number;
		public var left:Number;
		public var right:Number;

		//------------------------------------
		// constructor
		//------------------------------------
		
		/**
		 * Constructor
		 */
		public function Padding(top:Number = 0, right:Number = 0, bottom:Number = 0, left:Number = 0) {
			this.top = top;
			this.right = right;
			this.bottom = bottom;
			this.left = left;
		}
		
		//
		// PRIVATE, PROTECTED, INTERNAL
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		
	}
}