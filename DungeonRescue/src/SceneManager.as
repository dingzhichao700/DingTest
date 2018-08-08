package {
	import scene.SceneIndex;
	import scene.SceneIntro;
	import scene.SceneRescue;

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
					sceneGame ||= new SceneRescue();
					sceneGame.setState(int(state));
					LayerManager.getInstance().LAYER_BG.addChild(sceneGame);
					
					RolesManager.getInstance().init(int(state));
					PlayerControl.getInstance().init();
					break;
			}
		}
	}
}
