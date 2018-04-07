package handle.controller {
	import basic.BaseController;
	import basic.GameMsg;
	
	import event.GameBus;
	import event.GameEvent;
	
	import handle.HandleFacade;
	
	import res.msg.ResMsg;

	/**
	 * 游戏控制 控制器
	 * @author dingzhichao
	 *
	 */
	public class HandleController extends BaseController {

		public function HandleController() {
		}

		override public function registMsg():void {
			GameBus.registMsg(ResMsg.LOAD_OVER, viewHandler);
		}

		override protected function viewHandler(e:GameEvent):void {
			switch (e.type) {
				case ResMsg.LOAD_OVER:
					HandleFacade.manager.init();
					break;
			}
		}
	}
}
