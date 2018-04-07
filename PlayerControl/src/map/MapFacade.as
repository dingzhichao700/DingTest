package map {
	import map.controller.MapController;
	import map.manager.MapDataManager;

	/**
	 * 地图管理 入口
	 * @author dingzhichao
	 *
	 */
	public class MapFacade {

		/**数据管理*/
		public static var dataManager:MapDataManager = new MapDataManager();
		/**控制器*/
		private static var controller:MapController = new MapController();

		public static function init():void {
			controller.registMsg();
		}
	}
}