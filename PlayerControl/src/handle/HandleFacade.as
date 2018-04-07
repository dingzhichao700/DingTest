package handle {
	import handle.controller.HandleController;
	import handle.manager.HandleManager;

	/**
	 * 游戏控制 入口
	 * @author dingzhichao
	 *
	 */
	public class HandleFacade {

		/**管理器*/
		public static var manager:HandleManager = new HandleManager();
		/**管理器*/
		private static var controller:HandleController= new HandleController();

		public function HandleFacade() {
		}
		
		public static function init():void {
			controller.registMsg();
		}
	}
}
