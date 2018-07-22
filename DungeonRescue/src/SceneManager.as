package {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import utils.LoadManager;

	public class SceneManager {

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
		public function initStage(state:int):void {
			switch (state) {
				case 0:
					LayerManager.getInstance().clearAll();
					var startSp:Sprite = new Sprite();
					startSp.graphics.beginFill(0x00ff00, 0.5);
					startSp.graphics.drawRect(0, 0,  350, 100);
					startSp.x = 780;
					startSp.y = 840;
					startSp.addEventListener(MouseEvent.CLICK, onStart);
					LayerManager.getInstance().LAYER_TOP.addChild(startSp);
					
					LoadManager.getInstance().loadImg("index.jpg", LayerManager.getInstance().LAYER_BG);
					break;
				case 1:
				case 2:
				case 3:
					LayerManager.getInstance().clearAll();
					LoadManager.getInstance().loadImg("gameBg.jpg", LayerManager.getInstance().LAYER_BG);
					LoadManager.getInstance().loadImg("stage" + state + ".png", LayerManager.getInstance().LAYER_BG);
					BlockPainter.getInstance().initMission(state);
					
					RolesManager.getInstance().init();
					PlayerControl.getInstance().init();
					break;
			}
		}
		
		private function onStart(e:MouseEvent):void {
			initStage(2);
		}
	}
}
