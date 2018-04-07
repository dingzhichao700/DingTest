package res {
	import res.controller.ResController;
	import res.manager.ResDataManager;

	/**
	 * 资源 入口
	 * @author dingzhichao
	 *
	 */
	public class ResFacade {

		/**数据管理*/
		public static var dataManager:ResDataManager = new ResDataManager();
		/**控制器*/
		private static var controller:ResController = new ResController();

		public static function init():void {
			controller.registMsg();
		}
	}
}
