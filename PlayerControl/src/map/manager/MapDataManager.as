package map.manager {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	import event.GameBus;
	
	import map.msg.MapMsg;

	/**
	 * 地图加载管理
	 * @author dingzhichao
	 *
	 */
	public class MapDataManager {

		/**地图宽度*/
		public var mapWidth:int = 1600;
		/**地图高度*/
		public var mapHeight:int = 1389;
		/**移动范围顶点数组*/
		public var zoneArr:Array = [new Point(670, 500), new Point(970, 500), new Point(1530, 745), new Point(750, 1100), new Point(430, 960), 
									new Point(70, 1300), new Point(20, 1150),new Point(215, 920), new Point(20, 700), 
									new Point(20, 550), new Point(200, 630), new Point(250, 570)];

		private var _map:Bitmap;

		public function MapDataManager() {
		}

		/**开始加载*/
		public function startLoad():void {
			var loader:Loader = new Loader();
			loader.load(new URLRequest("image/map/map.jpg"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadOver);
		}

		/**加载完成*/
		private function onLoadOver(e:Event):void {
			_map = (e.currentTarget as LoaderInfo).content as Bitmap;
			GameBus.sendMsg(MapMsg.LOAD_OVER);
		}

		/**地图*/
		public function get gameMap():Bitmap {
			return _map;
		}
	}
}
