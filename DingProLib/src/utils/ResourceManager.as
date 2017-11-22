package utils {
	import flash.display.Loader;
	import flash.display.LoaderInfo;
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
		/**资源池*/
		private var resPool:Dictionary;
		/**加载池*/
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
				loader = new Loader();
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
	}
}
