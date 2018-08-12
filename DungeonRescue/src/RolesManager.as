package {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	import Role.Enemy;
	import Role.RoleView;

	public class RolesManager {

		private var roleCon:Sprite;
		private var moveTimer:Timer;
		private var _index:int;
		private var player:RoleView;
		private var enemyList:Array;
		private static const NPC_CFG1:Array = [[1, [700, 100], [500, 100]], [2, [970, 310], [970, 900]]];
		private static const NPC_CFG2:Array = [[1, [500, 100], [700, 100]]];
		private static const NPC_CFG3:Array = [[1, [500, 100], [700, 100]]];

		private static var instance:RolesManager;

		public static function getInstance():RolesManager {
			instance ||= new RolesManager();
			return instance;
		}

		public function RolesManager() {
			enemyList = [NPC_CFG1, NPC_CFG2, NPC_CFG3];
			roleCon ||= new Sprite();
			LayerManager.getInstance().LAYER_PLAYER.addChild(roleCon);
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
			roleCon.removeChildren();

			player ||= new RoleView();
			player.setRes("soldier1");
			player.x = 100;
			player.y = 100;
			player.play("stand", 1);
			roleCon.addChild(player);

			var targetEnemys:Array = enemyList[_index - 1];
			for (var i:int = 0; i < targetEnemys.length; i++) {
				var enemy:Enemy = new Enemy();
				enemy.setRes("enemy" + targetEnemys[i][0]);
				var start:Point = new Point(targetEnemys[i][1][0], targetEnemys[i][1][1]);
				var end:Point = new Point(targetEnemys[i][2][0], targetEnemys[i][2][1]);
				enemy.setParol(start, end);
				roleCon.addChild(enemy);
			}
		}

		private function onMoveTimer(e:TimerEvent):void {
			var step:int = RoleView.STEP;
			var playerCtr:PlayerControl = PlayerControl.getInstance();
			var xDis:int = playerCtr.moveHori[0] == 4 ? step : (playerCtr.moveHori[0] == 3 ? -step : 0);
			var yDis:int = playerCtr.moveVert[0] == 2 ? step : (playerCtr.moveVert[0] == 1 ? -step : 0);
			if (Math.abs(xDis) > 0 && Math.abs(yDis)) {
				xDis = xDis / Math.sqrt(2);
				yDis = yDis / Math.sqrt(2);
			}
			onMove(xDis, yDis);
		}

		public function onMove(xDis:int, yDis:int):void {
			if (!player) {
				return;
			}
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

			setIndexs();
		}

		private function setRange():void {
			for (var i:int = 0; i < roleCon.numChildren - 1; i++) {
				var player:DisplayObject = roleCon.getChildAt(i);
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

		private function setIndexs():void {
			for (var i:int = 0; i < roleCon.numChildren - 1; i++) {
				for (var j:int = 0; j < roleCon.numChildren - 1; j++) {
					var obj1:DisplayObject = roleCon.getChildAt(j);
					var obj2:DisplayObject = roleCon.getChildAt(j + 1);
					if (obj1 && obj2 && obj1.y > obj2.y) {
						roleCon.swapChildrenAt(j, j + 1);
					}
				}
			}
		}

	}
}
