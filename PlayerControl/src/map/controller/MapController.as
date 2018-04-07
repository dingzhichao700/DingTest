package map.controller {
	import basic.BaseController;
	import basic.GameMsg;
	
	import event.GameBus;
	import event.GameEvent;
	
	import map.MapFacade;
	import map.msg.MapMsg;
	
	import scene.SceneFacade;

	/**
	 * 地图 Controller
	 * @author dingzhichao
	 *
	 */
	public class MapController extends BaseController {
		
		public function MapController() {
		}

		override public function registMsg():void {
			GameBus.registMsg(GameMsg.GAME_START, viewHandler);
			GameBus.registMsg(MapMsg.LOAD_OVER, viewHandler);
		}

		override protected function viewHandler(e:GameEvent):void {
			switch (e.type) {
				case GameMsg.GAME_START:
					MapFacade.dataManager.startLoad();
					break;
				case MapMsg.LOAD_OVER:
					trace("=====地图资源加载完成=====");
					SceneFacade.manager.setMap(MapFacade.dataManager.gameMap);
					break;
			}
		}
	}
}
