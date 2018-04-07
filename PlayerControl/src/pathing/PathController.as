package pathing {
	import basic.BaseController;
	import basic.GameMsg;
	
	import event.GameBus;
	import event.GameEvent;
	

	/**
	 * 寻路控制器
	 * @author dingzhichao
	 *
	 */
	public class PathController extends BaseController {

		public function PathController() {
		}

		override public function registMsg():void {
			GameBus.registMsg(GameMsg.GAME_START, viewHandler);
		}

		override protected function viewHandler(e:GameEvent):void {
			switch (e.type) {
				case GameMsg.GAME_START:
					PathingFacade.manager.initGridMap();
					break;
			}
		}
	}
}
