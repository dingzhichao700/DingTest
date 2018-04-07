package res.tools {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import res.ResFacade;

	/**
	 * 资源加载器
	 * 以某动作某方向的一套图片为单位进行加载，如man_stand1_2，加载角色man的stand1动作的方向2的一套图片001至012，计数加载
	 * @author dingzhichao
	 *
	 */
	public class ResGroupLoader {
		
		private var loader:ResLoader;
		/**总共的加载数*/
		private var loadTotal:uint;
		/**已完成的加载数*/
		private var loadDone:uint;
		/**已失败的加载数*/
		private var loadFail:uint;
		/**裁剪外框起始范围*/
		private const CutGap:int = 200;

		public function ResGroupLoader() {
			loadTotal = 0;
			loadDone = 0;
			loadFail = 0;
		}

		/**
		 * 加载资源
		 * @param chara 角色名（角色文件夹名）
		 * @param act1  动作类型1（动作分类名）
		 * @param act2  动作类型2（具体动作名）
		 *
		 */
		public function loadRes(chara:String, act1:String, act2:String):void {
			for (var i:int = 1; i < 6; i++) {
				for (var j:int = 1; j < 13; j++) {
					var path:String = "image/" + chara + "/" + act1 + "/" + act2 + "/" + i + "/0" + (j < 10 ? "0" + j : j) + ".png";
					loadTotal++;
					loader = new ResLoader();
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadOver);
					loader.chara = chara;
					loader.act = act2;
					loader.direction = i + "";
					loader.num = "00" + (j < 100 ? "0" + j : j);
					loader.load(new URLRequest(path));
				}
			}
		}

		/**加载异常*/
		private function loadError(event:IOErrorEvent):void {
//			trace("加载出错：" + event.text);
			loadFail++;
			checkOver();
		}

		/**单张图片加载完成*/
		private function loadOver(e:Event):void {
			var resLoader:ResLoader = (e.currentTarget as LoaderInfo).loader as ResLoader;
			var bitmap:Bitmap = (e.currentTarget as LoaderInfo).loader.content as Bitmap;
			/*保存图片*/
			ResFacade.dataManager.saveData(resLoader.chara, resLoader.act, resLoader.direction, resLoader.num, setCutArea(bitmap), bitmap);
			loadDone++;
			checkOver();
//			trace("加载完成:" +　resLoader.chara + "_" + resLoader.act + "_" + resLoader.direction + "_" + resLoader.num);
		}

		/**检测裁剪范围*/
		private function setCutArea(bitmap:Bitmap):Array {
			var data:BitmapData = new BitmapData(bitmap.width, bitmap.height, true, 0);
			data.draw(bitmap);
			var arr:Array = [0, 0, 0, 0];
			for (var startX:int = CutGap; startX < data.width; startX++) {
				if (arr[0] != 0) {
					break;
				}
				for (var j:int = CutGap; j < data.height; j++) {
					if (data.getPixel32(startX, j) != 0) {
						arr[0] = startX;
						break;
					}
				}
			}
			for (var startY:int = CutGap; startY < data.height; startY++) {
				if (arr[1] != 0) {
					break;
				}
				for (var i:int = CutGap; i < data.width; i++) {
					if (data.getPixel32(i, startY) != 0) {
						arr[1] = startY;
						break;
					}
				}
			}
			for (var endX:int = data.width - CutGap; endX > 0; endX--) {
				if (arr[2] != 0) {
					break;
				}
				for (var k:int = CutGap; k < data.height; k++) {
					if (data.getPixel32(endX, k) != 0) {
						arr[2] = endX;
						break;
					}
				}
			}
			for (var endY:int = data.height - CutGap; endY > 0; endY--) {
				if (arr[3] != 0) {
					break;
				}
				for (var l:int = CutGap; l < data.width; l++) {
					if (data.getPixel32(l, endY) != 0) {
						arr[3] = endY;
						break;
					}
				}
			}
			return arr;
		}

		/**检测某动作（整套图片）加载是否结束*/
		private function checkOver():void {
			/**加载完成，通知数据管理器*/
			if (loadDone + loadFail == loadTotal) {
//				trace(loader.chara + "_" + loader.act + " 加载结束， 成功加载 " + loadDone + "张");
				if (loadDone != 0) {
					ResFacade.dataManager.actLoaded(loader.chara, loader.act);
				}
			}
		}
	}
}