package {
	import scene.SceneFail;
	import scene.SceneIndex;
	import scene.SceneIntro;
	import scene.SceneRescue;
	import scene.SceneWin;

	import utils.Dispatcher;
	import utils.LoopManager;

	public class SceneManager {

		private var sceneGame:SceneRescue;

		private static var _instance:SceneManager;

		public static function getInstance():SceneManager {
			_instance ||= new SceneManager;
			return _instance;
		}

		public function SceneManager() {
		}

		/**
		 * 初始化关卡
		 * @param state 0 封面 123关卡 10
		 *
		 */
		public function initStage(state:String):void {
			LayerManager.getInstance().clearAll();
			RolesManager.getInstance().clearRoles();
			switch (state) {
				case "index":
					var index:SceneIndex = new SceneIndex();
					LayerManager.getInstance().LAYER_BG.addChild(index);
					break;
				case "intro":
					var intro:SceneIntro = new SceneIntro();
					LayerManager.getInstance().LAYER_BG.addChild(intro);
					break;
				case "1":
				case "2":
				case "3":
					GameDataManager.getInstance().setStage(int(state));
					sceneGame ||= new SceneRescue();
					sceneGame.setState(int(state));
					LayerManager.getInstance().LAYER_BG.addChild(sceneGame);

					RolesManager.getInstance().init(int(state));
					PlayerControl.getInstance().init();

					/*迷宫场景，启动总线*/
					SceneManager.getInstance().startMainLine();
					break;
				case "goodEnd":
					var goodEnd:SceneWin = new SceneWin();
					LayerManager.getInstance().LAYER_BG.addChild(goodEnd);
					break;
				case "badEnd":
					var badEnd:SceneFail = new SceneFail();
					LayerManager.getInstance().LAYER_BG.addChild(badEnd);
					break;
			}
		}

		public function updateInfo():void {
			if (sceneGame) {
				sceneGame.updateInfo();
			}
		}

		public function tryPassStage():void {
			if (GameDataManager.getInstance().checkPassMission()) {
				if (GameDataManager.getInstance().curStage == 3) {
					initStage("goodEnd");
				} else {
					SceneManager.getInstance().initStage((GameDataManager.getInstance().curStage + 1).toString());
				}
			}
		}

		/**启动总线*/
		public function startMainLine():void {
			LoopManager.getInstance().resume();
			Dispatcher.dispatch(GameEvent.MAIN_LINE_EVENT, GameEvent.LINE_START);
		}

		/**暂停总线*/
		public function pauseMainLine():void {
			LoopManager.getInstance().pause();
			Dispatcher.dispatch(GameEvent.MAIN_LINE_EVENT, GameEvent.LINE_PAUSE);
		}

	}
}
