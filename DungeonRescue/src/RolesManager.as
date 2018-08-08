package {
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import Role.RoleView;

	public class RolesManager {

		private var moveTimer:Timer;
		private var _index:int;
		private var player:RoleView;
		private static const STEP:int = 4;

		private static var instance:RolesManager;

		public static function getInstance():RolesManager {
			instance ||= new RolesManager();
			return instance;
		}

		public function RolesManager() {
		}

		public function init(index:int):void {
			_index = index;
			initPlayer();

			if (moveTimer) {
				moveTimer.stop();
				moveTimer.removeEventListener(TimerEvent.TIMER, onMoveTimer);
				moveTimer = null;
			}
			moveTimer = new Timer(10);
			moveTimer.addEventListener(TimerEvent.TIMER, onMoveTimer);
			moveTimer.start();
		}

		private function initPlayer():void {
			player ||= new RoleView();
			player.setRes("soldier1");
			player.x = 100;
			player.y = 100;
			player.play("stand", 1);
			LayerManager.getInstance().LAYER_PLAYER.addChild(player);
			
			var enemy:RoleView = new RoleView();
			enemy.setRes("enemy1");
			enemy.x = 500;
			enemy.y = 100;
			enemy.play("stand", 1);
			LayerManager.getInstance().LAYER_PLAYER.addChild(enemy);
			
		}

		private function onMoveTimer(e:TimerEvent):void {
			var playerCtr:PlayerControl = PlayerControl.getInstance();
			var xDis:int = playerCtr.moveHori[0] == 4 ? STEP : (playerCtr.moveHori[0] == 3 ? -STEP : 0);
			var yDis:int = playerCtr.moveVert[0] == 2 ? STEP : (playerCtr.moveVert[0] == 1 ? -STEP : 0);
			if(Math.abs(xDis) > 0 && Math.abs(yDis)){
				xDis = xDis/Math.sqrt(2);
				yDis = yDis/Math.sqrt(2);
			}
			onMove(xDis, yDis);
		}

		public function onMove(xDis:int, yDis:int):void {
			if (BlockPainter.getInstance().blocks && BlockPainter.getInstance().blocks.hitTestPoint(player.x + xDis, player.y + yDis, true)) {
				return;
			}
			player.x += xDis;
			player.y += yDis;

			/*动作动画*/
			if (xDis == 0 && yDis == 0) {
				player.play("stand", 1, 5);
			} else {
				if (Math.abs(xDis) >= Math.abs(yDis)) {
					player.play("run", 1, xDis > 0 ? 3 : 7);
				} else {
					player.play("run", 1, yDis > 0 ? 5 : 1);
				}
			}

			if (player.x < 10) {
				player.x = 10;
			} else if (player.x > 1530) {
				player.x = 1530;
			}
			if (player.y < 10) {
				player.y = 10;
			} else if (player.y > 1070) {
				player.y = 1070;
			}
		}

	}
}
