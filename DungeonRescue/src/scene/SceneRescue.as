package scene {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	import utils.Dispatcher;
	import utils.Label;
	import utils.LoopManager;
	import utils.ResourceManager;
	import utils.Style;

	/**
	 * 游戏场景管理器
	 * @author Administrator
	 *
	 */
	public class SceneRescue extends Sprite {

		private var pauseSp:Sprite;
		private var backSp:Sprite;
		private var pauseWindow:Sprite;
		private var btnResume:Sprite;

		private var btnUp:Sprite;
		private var btnDown:Sprite;
		private var btnLeft:Sprite;
		private var btnRight:Sprite;

		private var txtLevel:Label;
		private var txtName:Label;
		private var txtChance:Label;

		private var imgMaze:Bitmap;

		private const LEVEL_NUM:Array = ["一", "二", "三"];
		private const MISSION_NAME:Array = ["逃出生天", "拯救战友", "拯救战友"];

		public function SceneRescue() {
			ResourceManager.getInstance().getImage("res/bgScene.jpg", this);
			imgMaze = ResourceManager.getInstance().getImage("", this);

			ResourceManager.getInstance().getImage("res/btn_up.png", this, 1670, 435);
			ResourceManager.getInstance().getImage("res/btn_down.png", this, 1670, 635);
			ResourceManager.getInstance().getImage("res/btn_left.png", this, 1570, 535);
			ResourceManager.getInstance().getImage("res/btn_right.png", this, 1770, 535);

			var radius:int = 60;
			btnUp = Style.getRound(radius, this, 1670 + radius, 435 + radius);
			btnDown = Style.getRound(radius, this, 1670 + radius, 635 + radius);
			btnLeft = Style.getRound(radius, this, 1570 + radius, 535 + radius);
			btnRight = Style.getRound(radius, this, 1770 + radius, 535 + radius);
			btnUp.addEventListener(MouseEvent.MOUSE_DOWN, onDir);
			btnDown.addEventListener(MouseEvent.MOUSE_DOWN, onDir);
			btnLeft.addEventListener(MouseEvent.MOUSE_DOWN, onDir);
			btnRight.addEventListener(MouseEvent.MOUSE_DOWN, onDir);

			pauseSp = Style.getBlock(285, 90, this, 1580, 820);
			pauseSp.addEventListener(MouseEvent.CLICK, onPause);

			backSp = Style.getBlock(285, 90, this, 1580, 950);
			backSp.addEventListener(MouseEvent.CLICK, onBack);

			txtLevel = Style.getText("第一关", this, 1610, 30, 80, "#f2b106", 300, 300);
			txtName = Style.getText("逃出生天", this, 1630, 140, 50, "#f2b106", 200, 100);
			Style.getText("剩余尝试次数", this, 1580, 230, 50, "#ffffff", 350, 100);
			txtChance = Style.getText("3", this, 1710, 300, 80, "#ffffff");

			pauseWindow = new Sprite();
			ResourceManager.getInstance().getImage("res/windowPause.png", pauseWindow);
			btnResume = Style.getBlock(285, 90, pauseWindow, 580, 660);
			btnResume.addEventListener(MouseEvent.CLICK, onPause);
			pauseWindow.visible = false;
			LayerManager.getInstance().LAYER_TOP.addChild(pauseWindow);
		}

		public function updateInfo():void {
			var stage:int = GameDataManager.getInstance().curStage;
			txtLevel.setText("第" + LEVEL_NUM[stage - 1] + "关")
			txtName.setText(MISSION_NAME[stage - 1])
			txtChance.setText(GameDataManager.getInstance().chance + "");
		}

		public function setState(index:int):void {
			ResourceManager.getInstance().setImageData("res/stage" + index + ".jpg", imgMaze);
			BlockPainter.getInstance().initMission(index);
			updateInfo();
		}

		private function onDir(e:MouseEvent):void {
			e.currentTarget.addEventListener(MouseEvent.MOUSE_UP, onOut);
			e.currentTarget.addEventListener(MouseEvent.MOUSE_OUT, onOut);

			var keyEvent:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN);
			switch (e.currentTarget) {
				case btnUp:
					keyEvent.keyCode = 87;
					break;
				case btnDown:
					keyEvent.keyCode = 83;
					break;
				case btnLeft:
					keyEvent.keyCode = 65;
					break;
				case btnRight:
					keyEvent.keyCode = 68;
					break;
			}
			Dispatcher.dispatch(KeyEvent.KEY_DOWN, keyEvent);
		}

		private function onOut(e:MouseEvent):void {
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_UP, onOut);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, onOut);

			var keyEvent:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_UP);
			switch (e.currentTarget) {
				case btnUp:
					keyEvent.keyCode = 87;
					break;
				case btnDown:
					keyEvent.keyCode = 83;
					break;
				case btnLeft:
					keyEvent.keyCode = 65;
					break;
				case btnRight:
					keyEvent.keyCode = 68;
					break;
			}
			Dispatcher.dispatch(KeyEvent.KEY_UP, keyEvent);
		}

		private function onPause(e:MouseEvent):void {
			if (LoopManager.getInstance().isPause) {
				SceneManager.getInstance().startMainLine();
				pauseWindow.visible = false;
			} else {
				LoopManager.getInstance().pause();
				SceneManager.getInstance().pauseMainLine();
				pauseWindow.visible = true;
			}
		}

		private function onBack(e:MouseEvent):void {
			SceneManager.getInstance().initStage("index");
		}

	}
}
