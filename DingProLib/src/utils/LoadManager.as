package utils {
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class LoadManager {
		
		private var loadDic:Dictionary;
		
		private static var instance:LoadManager;
		public static function getInstance():LoadManager {
			instance ||= new LoadManager();
			return instance;
		}
		
		public function LoadManager() {
		}

		public function loadImg(url:String, con:DisplayObjectContainer = null, x:int = 0, y:int = 0):Bitmap {
			var bmp:Bitmap = new Bitmap();
			if(con){
				bmp.x = x;
				bmp.y = y;
				con.addChild(bmp);
			}
			loadDic ||= new Dictionary();
			if(loadDic[url]){
				loadDic[url].push([bmp, x, y]);
			} else {
				loadDic[url] = [];
				loadDic[url].push([bmp, x, y]);
			}
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
//			loader.load(new URLRequest("bg.jpg"));
			loader.load(new URLRequest(url));
			return bmp;
		}
		
		private function onComplete(e:Event):void {
			for(var str:String in loadDic){
				if((e.target as LoaderInfo).url.indexOf(str) != -1){
					var img:Bitmap = (e.target as LoaderInfo).content as Bitmap;
					var targetCons:Array = loadDic[str];
					for(var i:int = 0;i < targetCons.length;i++){
						var pic:Bitmap = targetCons[i][0] as Bitmap; 
						pic.bitmapData = img.bitmapData;
					}
				}
			}
		}
	}
}
