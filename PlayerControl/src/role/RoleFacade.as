package role {
	import role.controller.RoleController;
	import role.manager.RoleManager;

	/**
	 * 角色管理 入口
	 * @author dingzhichao
	 *
	 */
	public class RoleFacade {

		/**管理器*/
		public static var manager:RoleManager = new RoleManager();

		/**控制器*/
		private static var controller:RoleController = new RoleController();

		public static function init():void {
			controller.registMsg();
		}
	}
}
