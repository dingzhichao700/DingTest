package com {

	/**
	 * 地图数据管理 
	 * @author dingzhichao
	 * 
	 */	
	public class MapManager {

		public var MAP_NAME:String;
		public var MAP_WIDTH:int;
		public var MAP_HEIGHT:int;

		private static var _instance:MapManager;
		public static function getInstance():MapManager {
			_instance ||= new MapManager();
			return _instance;
		}

		public function MapManager() {
		}
		
		/**地图是否加载*/
		public function get isMapLoaded():Boolean {
			return Boolean(MAP_NAME && MAP_NAME != "");
		}
	}
}
