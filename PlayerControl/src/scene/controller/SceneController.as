package scene.controller {
	import basic.BaseController;
	
	import event.GameBus;
	import event.GameEvent;
	
	import role.msg.RoleMsg;
	
	import scene.SceneFacade;

	/**
	 * 场景控制器
	 * @author dingzhichao
	 *
	 */
	public class SceneController extends BaseController {
		
		public function SceneController() {
		}

		override public function registMsg():void {
			/*角色移动*/
			GameBus.registMsg(RoleMsg.ROLE_MOVE, viewHandler);
		}
		
		override protected function viewHandler(e:GameEvent):void {
			switch(e.type){
				case RoleMsg.ROLE_MOVE:
					SceneFacade.manager.setDepth();
					break;
			}
		}
	}
}
