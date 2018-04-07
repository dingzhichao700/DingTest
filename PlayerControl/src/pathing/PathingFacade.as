package pathing {

	/**
	 * 寻路外接口
	 * @author dingzhichao
	 *
	 */
	public class PathingFacade {

		/**管理器*/
		public static var manager:PathingManager = new PathingManager();
		/**控制器*/
		private static var controller:PathController = new PathController();

		public static function init():void {
			controller.registMsg();
		}
	}
}
