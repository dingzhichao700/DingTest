package res.controller {
	import flash.utils.getTimer;

	import basic.BaseController;
	import basic.GameMsg;

	import event.GameBus;
	import event.GameEvent;

	import res.ResFacade;
	import res.msg.ResMsg;

	/**
	 * 资源 控制器
	 * @author dingzhichao
	 *
	 */
	public class ResController extends BaseController {

		public function ResController() {

		}

		override public function registMsg():void {
			GameBus.registMsg(GameMsg.GAME_START, viewHandler);
			GameBus.registMsg(ResMsg.LOAD_OVER, viewHandler);
		}

		override protected function viewHandler(e:GameEvent):void {
			switch (e.type) {
				case GameMsg.GAME_START:
					ResFacade.dataManager.startLoad();
					break;
				case ResMsg.LOAD_OVER:
					var costTime:int = getTimer() - GameClient.startTime;
					trace("=====角色资源加载完成===== 耗时：" + costTime/1000 + "秒");
					break;
			}
		}
	}
}
