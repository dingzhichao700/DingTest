package role.controller {
	import basic.BaseController;
	import basic.GameMsg;
	
	import event.GameBus;
	import event.GameEvent;
	
	import map.msg.MapMsg;
	
	import pathing.PathingMsg;
	
	import role.RoleFacade;
	import role.msg.RoleMsg;

	/**
	 * 角色Controller
	 * @author dingzhichao
	 *
	 */
	public class RoleController extends BaseController {

		public function RoleController() {

		}

		override public function registMsg():void {
			GameBus.registMsg(MapMsg.LOAD_OVER, viewHandler);
			GameBus.registMsg(RoleMsg.MOVE_OVER, viewHandler);
			GameBus.registMsg(PathingMsg.PATH_FIGURE_OUT, viewHandler);
		}

		override protected function viewHandler(e:GameEvent):void {
			switch (e.type) {
				case MapMsg.LOAD_OVER:
					RoleFacade.manager.init();
					break;
				case PathingMsg.PATH_FIGURE_OUT:
				case RoleMsg.MOVE_OVER:
					RoleFacade.manager.moveByRoute(e.data);
					break;
			}
		}
	}
}
