//AS3/////////////////////////////////////////////////////////////////////////// 
// FLASHPRESS DEMO METHOD CALLS 2010
////////////////////////////////////////////////////////////////////////////////

package {

	import com.ab.apps.appgenerics.settings.XMLSettings;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;

	//noponies imports
	import com.noponies.net.NpDbConnection;
	import com.noponies.events.NpAmfEvent;
	
	//import vo classes
	import com.noponies.flashpress.vo.WpPostVO;
	import com.noponies.flashpress.vo.WpAttachmentVO;
	import com.noponies.flashpress.vo.WpBlogInfoVO;
	import com.noponies.flashpress.vo.WpBlogRollVO;
	import com.noponies.flashpress.vo.WpTermVO;
	import com.noponies.flashpress.vo.WpMetaVO;
	import com.noponies.flashpress.vo.WpCommentVO;
	import com.noponies.flashpress.vo.WpPostCountVO;
	import com.noponies.flashpress.vo.WpSearchVO;

	public class FlashPressBridge extends Object 
	{
		/// singleton
		private static var __singleton:FlashPressBridge;
		//--------------------------------------
		// STATIC VARS
		//--------------------------------------
		private static var DB_CONNECTION:NpDbConnection;
		private static var SERVICE:String = "flashpress.";//This is for AMFPHP ONLY
		//--------------------------------------
		// PRIVATE VARS
		//--------------------------------------
		private var _loader:URLLoader;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function FlashPressBridge() 
		{
			setSingleton();
			
			///set up flash press environment
			init();
		}
		
		//--------------------------------------
		//  SET UP FLASHPRESS ENVIRONMENT
		//--------------------------------------
		//here we register class aliases, and connect to database
		private function init():void 
		{
			//register class aliases for strong typing
			registerClassAlias("flashpress.vo.WpPostVO", WpPostVO);
			registerClassAlias("flashpress.vo.WpAttachmentVO", WpAttachmentVO);
			registerClassAlias("flashpress.vo.WpBlogInfoVO", WpBlogInfoVO);
			registerClassAlias("flashpress.vo.WpBlogRollVO", WpBlogRollVO);
			registerClassAlias("flashpress.vo.WpTermVO", WpTermVO);
			registerClassAlias("flashpress.vo.WpMetaVO", WpMetaVO);
			registerClassAlias("flashpress.vo.WpCommentVO", WpCommentVO);
			registerClassAlias("flashpress.vo.WpPostCountVO", WpPostCountVO);
			registerClassAlias("flashpress.vo.WpSearchVO", WpSearchVO);
			
			//security - you will prob need to have a cross domain policy
			//Security.loadPolicyFile("http://www.yourdomain.com/crossdomain.xml");
			//Security.allowDomain("*.yourdomain.com")
			
			//connect to database
			//zend
			//DB_CONNECTION = new NpDbConnection("http://localhost:80/FlashPressZend/wp_gateway.php");
			
			///amfphp
			DB_CONNECTION = new NpDbConnection("http://www.antoniobrandao.com/amfwordpress/gateway.php");
		}
		
		public function getCustomMethod(result_function:Function, method:String="wp_get_single_post"):void
		{
			///call arbitrary wordpress methods, by default it is getting a single post
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.callWpMethod", result_function, onFault, method, '2', 'OBJECT');
		}
		
		public function getPostsCount(result_function:Function, post_id:*):void
		{
			///count the posts in your wordpress install
			NpDbConnection.queryAMF("SERVICE + WpMethodsService.countPosts", result_function, onFault);
		}
		
		public function getPostByID(result_function:Function, post_id:*):void
		{
			///get a post, via its ID
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getPost", result_function,onFault, post_id);
		}
		
		public function getPosts(result_function:Function, limit:int=5):void
		{
			///get posts, with the number returned limited to 3
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getPosts", result_function, onFault, 'numberposts=' + limit);
		}
		
		public function getPageOrPostByTitle(result_function:Function, title:String):void
		{
			///get a post or page by its title
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getPostOrPageByTitle", result_function, onFault, title);
		}
		
		public function getBlogroll(result_function:Function, orderby:String="name"):void
		{
			///get the wordpress installs blogroll
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getBlogroll", result_function, onFault, 'orderby=' + orderby);
		}
		
		public function getBookmarks(result_function:Function, orderby:String="name"):void
		{
			///get the wordpress installs bookmarks
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getBookmarks", result_function, onFault, 'orderby=' + orderby);
		}
		
		public function getMedia(result_function:Function, type:String="video/mp4"):void
		{
			///get attachments from the wordpress blog
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getMedia", result_function, onFault, 'post_type=attachment&post_mime_type=' + type);
		}
		
		public function getCategories(result_function:Function):void
		{
			///get categories for wordprss install
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getCategories", result_function, onFault, 'orderby=name');
		}
		
		public function getTagCloud(result_function:Function):void
		{
			///Generate a wordpress tag cloud
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getTagCloud", result_function, onFault);
		}
		
		public function getWPTagCloudMethod(result_function:Function):void
		{
			///call the internal Wp tag cloud method
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.callWpMethod", result_function, onFault, 'wp_tag_cloud', 'format=array');
		}
		
		public function getPostMetadata(result_function:Function, post:*):void
		{
			///Get metadata associated with a post
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getPostMeta", result_function, onFault, post);
			//or
			//NpDbConnection.queryAMF("WpMethodsService.getPostMeta", result_function,onFault, 344, 'demo field');
		}
		
		public function getPostsTags(result_function:Function, posts:*):void
		{
			///get the tags associated with a post(s)
			/// may send a String or an Array
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getTagsByPostId", result_function, onFault, posts);
		}
		
		public function getPostCategories(result_function:Function, posts:*):void
		{
			///get categories a post(s) belongs to
			/// may send a String or an Array
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getCategoriesByPostId", result_function, onFault, posts);
		}
		
		public function getPostComments(result_function:Function, post_id:*):void
		{
			///get comments for post by posts id
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getComments", result_function, onFault, 'status=approve&post_id='+ post_id);
		}
		
		public function getUserByID(result_function:Function, user_id:*):void
		{
			///get user by their ID
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getUserById", result_function, onFault, user_id);
		}
		
		public function getUserByLoginName(result_function:Function, login_name:String):void
		{
			///get user by their log in name
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getUserByLoginName", result_function, onFault, login_name);
		}
		
		public function getUserMetadata(result_function:Function, last_name:String):void
		{
			///get user metadata
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getUserMetadata", result_function, onFault, 1, last_name);
		}
		
		public function getJPEGMedia(result_function:Function):void
		{
			///get media
			NpDbConnection.queryAMF(SERVICE+"WpMethodsService.getMedia", result_function, onFault, 'post_type=attachment&post_mime_type=image/jpeg');
		}
		
		public function getPostAttachments(result_function:Function, post_id:*):void
		{
			///get post attachments
			NpDbConnection.queryAMF(SERVICE+"WpMethodsService.getPostAttachments", result_function, onFault, post_id);
		}
		
		public function insertPost(result_function:Function, myPostOb:Object):void
		{
			///save a post to wp
			///var myPostOb:Object = {post_title:'New Post Title',post_content:'Lorem Ipsum, demo post, oh yeah',post_status:'draft',post_author:1,post_category:new Array(3,15),tags_input:new Array('ActionScript 3')};
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.insertPost", result_function, onFault, myPostOb);
		}
		
		public function insertTextAttachment(result_function:Function, myAttachAr:Object, text_url:String):void
		{
			///var myAttachAr:Object = {post_title:"Some text", post_content:"Text", post_status:"publish", post_author:1, post_excerpt:'some text'};
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.insertAttachment", result_function, onFault, text_url,  myAttachAr );
		}
		
		public function insertImageAttachment(result_function:Function, fileOptions:Object, image_url:String):void
		{
			///var fileOptions:Object = {post_title:"SNOW", post_content:"An image", post_status:"publish", post_author:1, post_excerpt:'some text about this snow'};
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.insertAttachment", result_function, onFault, image_url, fileOptions );
		}
		
		public function search(result_function:Function, string:String):void
		{
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.search", result_function, onFault, string);
		}
		
		public function getFeaturedImageFromPost(result_function:Function, post_id:int):void
		{
			NpDbConnection.queryAMF(SERVICE + "WpMethodsService.getPostFeatured", result_function, onFault, post_id);
		}
		
		public function uploadImagePost(result_function:Function, file_name:String, bytes:ByteArray, fileOptions:Object):void
		{
			//var fileOptions:Object = {post_title:"Demo Image", post_content:"An image", post_status:"publish", post_author:1, post_excerpt:'some text about this image'};
			NpDbConnection.queryAMF("WpMethodsService.insertAttachmentAsByteArray", result_function, onFault, file_name, bytes, fileOptions );
		}
		
		///--------------------------------------
		/// AMF HANDLERS
		///--------------------------------------
		//result handler for intially getting tag cloud
		private function handleAmfResult(result:Object):void 
		{
			for (var prop:* in result) 
			{
				trace("myObject."+prop+" = "+result[prop]);
			}
			
			trace(result, result as Array);
		}
		
		//fault handler
		private function onFault(fault:Object):void 
		{
			trace("AMFPhp Fault");
			
			for (var p:String in fault) 
			{
				trace(p, fault[p]);
			}
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null)  { return; }; //throw new Error("AppManager ::: SINGLETON REPLICATION ATTEMPTED")
			__singleton = this;
		}
		public static function get singleton():FlashPressBridge
		{
			if (__singleton == null) { __singleton = new FlashPressBridge(); } //throw new Error("AppManager ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)"
			return __singleton;
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
	}
}