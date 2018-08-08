package utils {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	/**
	 * 加载资源管理
	 * @author Administrator
	 *
	 */
	public class ResourceManager {
		/**散图资源池*/
		private var imgDic:Dictionary;
		/**散图加载池*/
		private var imgLoaderDic:Dictionary;
		
		/**swf资源池*/
		private var resPool:Dictionary;
		/**swf加载池*/
		private var loadPool:Dictionary;
		
		private var loader:Loader;
		private static const assetUrl:String = "assets/";

		private static var _instance:ResourceManager;

		public static function getInstance():ResourceManager {
			if (!_instance) {
				_instance = new ResourceManager();
			}
			return _instance;
		}

		public function ResourceManager() {
			imgDic = new Dictionary();
			imgLoaderDic = new Dictionary();
			resPool = new Dictionary();
			loadPool = new Dictionary();
		}

		/**是否已加载资源*/
		public function hasRes(path:String):Boolean {
			return resPool[path];
		}

		/**
		 * 加载资源
		 * @param path 		资源路径
		 * @param callBack	加载完成回调
		 *
		 */
		public function loadRes(path:String, callBack:Function = null):void {
			if (!hasRes(path)) {
				loader ||= new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadHandler);
				loadPool[path] = callBack;
				try {
					loader.load(new URLRequest(assetUrl + path + ".swf"));
				} catch (err:IOErrorEvent) {
					trace("err: " + err);
				}
			} else {
				trace(path + ".swf 已加载");
			}
		}

		private function onLoadHandler(e:Event):void {
			var aplDomain:ApplicationDomain = LoaderInfo(e.target).applicationDomain;
			var resName:String = getUrlName(LoaderInfo(e.target).url);
			resPool[resName] = aplDomain;
			/*执行加载回调*/
			if (loadPool[resName]) {
				loadPool[resName]();
			}
		}

		public function getRes(name:String):ApplicationDomain {
			if (resPool[name]) {
				return resPool[name] as ApplicationDomain;
			}
			return null;
		}

		/**获取资源名*/
		private function getUrlName(str:String):String {
			var arr:Array = str.split("/");
			var target:String = String(arr[arr.length - 1]);
			return target.substring(0, target.indexOf(".swf"));
		}
		
		public function getImage(url:String, con:Sprite = null, x:int = 0, y:int = 0):Bitmap {
			var bmp:Bitmap = new Bitmap;
			if(con){
				bmp.x = x;
				bmp.y = y;
				con.addChild(bmp);
			}
			if(url != ""){
				setImageData(url, bmp);
			}
			return bmp;
		}
		
		public function setImageData(url:String, bmp:Bitmap):void {
			if(imgDic[url]){
				bmp.bitmapData = imgDic[url];
			} else {
				imgLoaderDic[url] ||= [];
				imgLoaderDic[url].push(bmp);
				getOutImage(url);
			}
		}
		
		private function getOutImage(url:String):void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageComplete);
			loader.load(new URLRequest(url));
		}
		
		private function onImageComplete(e:Event):void {
			for(var str:String in imgLoaderDic){
				if((e.target).url.indexOf(str) != -1){
					imgDic[str] = (e.target.content).bitmapData;
					var arr:Array = imgLoaderDic[str] as Array;
					for(var i:int = 0; i < arr.length;i++){
						(arr[i] as Bitmap).bitmapData = imgDic[str];
					}
				}
			}
		}
		
	}
}
