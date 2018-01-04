package {
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import utils.Fps;
	import utils.ResourceManager;

	[SWF(frameRate = "60", backgroundColor = "0xaaaaaa", width = 720, height = 480)]
	public class PixelShooter extends Sprite {

		/**水平方向状态 右1左2*/
		private var moveHori:int = 0;
		/**竖直方向状态 上1下2*/
		private var moveVert:int = 0;
		private var role:Role;
		private var SPEED:int = 3;
		private var moveTimer:Timer;

		public function PixelShooter() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, onUp);
			
			moveTimer = new Timer(10);
			moveTimer.addEventListener(TimerEvent.TIMER, onMoveTimer);
			
			init();
		}

		private function init():void {
			if (!ResourceManager.getInstance().hasRes("common")) {
				ResourceManager.getInstance().loadRes("common", init)
				return;
			}

			var fps:Fps = new Fps();
			fps.x = 60;
			this.addChild(fps);

			role = new Role();
			role.x = 200;
			role.y = 200;
			this.addChild(role);
			
			moveTimer.start();
		}

		private function onDown(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case 87: //W
				case 83: //S
				case 65: //A
				case 68: //D
					setMoveState(e.keyCode, e.type == "keyDown");
					break;
			}
		}

		private function onUp(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case 87: //W
				case 83: //S
				case 65: //A
				case 68: //D
					setMoveState(e.keyCode, e.type == "keyDown");
					break;
			}
		}

		/**
		 * 设置移动状态
		 * @param key 按键
		 * @param dir 方向：1横向2纵向
		 * @param isDown 按键是否按下
		 */
		private function setMoveState(key:int, isDown:Boolean):void {
			if (key == 65 || key == 68) {
				moveHori = key == 68 ? (isDown ? 1 : 0) : (isDown ? 2 : 0);
			}
			if (key == 83 || key == 87) {
				moveVert = key == 83 ? (isDown ? 1 : 0) : (isDown ? 2 : 0);
			}
		}

		private function moveRole():void {
			role.x += moveHori == 1 ? SPEED : (moveHori == 2 ? -SPEED : 0);
			role.y += moveVert == 1 ? SPEED : (moveVert == 2 ? -SPEED : 0);
		}
		
		private function onMoveTimer(e:TimerEvent):void {
			moveRole();
		}
	}
}
