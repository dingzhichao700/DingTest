package scene {
	import scene.controller.SceneController;
	import scene.manager.SceneManager;

	/**
	 * 场景 入口
	 * @author dingzhichao
	 *
	 */
	public class SceneFacade {

		/**控制器*/
		private static var controller:SceneController = new SceneController();
		/**管理器*/
		public static var manager:SceneManager = new SceneManager();

		public static function init():void {
			controller.registMsg();
		}
	}
}
