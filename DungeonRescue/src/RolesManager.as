package {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import Role.Enemy;
	import Role.Friend;
	import Role.RoleView;
	
	import utils.LoopManager;

	public class RolesManager {

		private var _roleCon:Sprite;
		private var moveTimer:Timer;
		private var _index:int;
		private var _player:RoleView;
		private var enemyList:Array;
		private var friendList:Array;
		private static const NPC_CFG1:Array = [[1, [700, 100], [500, 100]], [1, [970, 310], [970, 900]], [1, [200, 1000], [660, 1000]]];
		private static const NPC_CFG2:Array = [[0, [760, 565]], [1, [1429, 210], [1080, 210]], [2, [920, 680], [920, 800]], [1, [210, 810], [500, 810]]];
		private static const NPC_CFG3:Array = [[0, [1125, 293]], [2, [350, 180], [350, 120]], [1, [160, 470], [160, 660]], [2, [1000, 200], [1060, 200]], [2, [480, 350], [480, 400]], [1, [600, 660], [920, 660]]];
		private var NPC_LIST:Array;
		private static const START_POS:Array = [[100, 100], [100, 100], [1490, 100]];
		private static const SCALE:Array = [1, 0.9, 0.8];

		private static var instance:RolesManager;

		public static function getInstance():RolesManager {
			instance ||= new RolesManager();
			return instance;
		}

		public function RolesManager() {
			NPC_LIST = [NPC_CFG1, NPC_CFG2, NPC_CFG3];
			_roleCon ||= new Sprite();
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
			LayerManager.getInstance().LAYER_PLAYER.addChild(roleCon);

			_player ||= new RoleView();
			_player.setRes("soldier1");
			_player.scaleX = _player.scaleY = SCALE[_index - 1];
			var startPos:Array = START_POS[_index - 1];
			_player.x = startPos[0];
			_player.y = startPos[1];
			_player.play("stand", 1);
			roleCon.addChild(_player);

			friendList = [];
			enemyList = [];
			var npcs:Array = NPC_LIST[_index - 1];
			for (var i:int = 0; i < npcs.length; i++) {
				if (npcs[i][0] == 0) {
					var friend:Friend = new Friend();
					friend.scaleX = friend.scaleY = SCALE[_index - 1];
					friend.setRes("soldier2");
					friend.x = npcs[i][1][0];
					friend.y = npcs[i][1][1];
					roleCon.addChild(friend);
					friendList.push(friend);
				} else {
					var enemy:Enemy = new Enemy();
					enemy.scaleX = enemy.scaleY = SCALE[_index - 1];
					enemy.setRes("enemy" + npcs[i][0]);
					var start:Point = new Point(npcs[i][1][0], npcs[i][1][1]);
					var end:Point = new Point(npcs[i][2][0], npcs[i][2][1]);
					enemy.setParol(start, end);
					roleCon.addChild(enemy);
					enemyList.push(enemy);
				}
			}
		}

		private function onMoveTimer(e:TimerEvent):void {
			if (LoopManager.getInstance().isPause) {
				return;
			}

			var step:int = player.STEP;
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
			/*检测撞墙*/
			if (BlockPainter.getInstance().blocks && BlockPainter.getInstance().blocks.hitTestPoint(player.x + xDis, player.y + yDis, true)) {
				return;
			}
			/*检测终点*/
			if (BlockPainter.getInstance().finish && BlockPainter.getInstance().finish.hitTestPoint(player.x + xDis, player.y + yDis, true)) {
				SceneManager.getInstance().tryPassStage();
				return;
			}
			
			/*移动*/
			player.x += xDis;
			player.y += yDis;
			
			/*检测敌人侦查等*/
			if(enemyHitTest()){
				hitEnemyOrBullet();
				return;
			}
			
			/*检测人质*/
			friendHitTest();

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
		
		public function hitEnemyOrBullet():void {
			if(GameDataManager.getInstance().chance > 0){
				GameDataManager.getInstance().chance--;
				SceneManager.getInstance().updateInfo();
				var startPos:Array = START_POS[_index - 1];
				player.x = startPos[0];
				player.y = startPos[1];
				player.invincible = true;
			} else {
				if (moveTimer) {
					moveTimer.stop();
					moveTimer.removeEventListener(TimerEvent.TIMER, onMoveTimer);
					moveTimer = null;
				}
				SceneManager.getInstance().initStage("badEnd");
			}
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
		
		/**友军碰撞*/
		private function friendHitTest():Boolean {
			var hitFriend:Boolean = false;
			for (var i:int = 0; i < friendList.length; i++) {
				var friend:Friend = friendList[i] as Friend;
				if (friend.positionSp.hitTestPoint(player.x, player.y, false)) {
					hitFriend = true;
					roleCon.removeChild(friend);
					friendList.splice(i, 1);
					i--;
					friend = null;
					GameDataManager.getInstance().resCue++;
				}
			}
			return hitFriend;
		}
		
		/**敌人碰撞*/
		private function enemyHitTest():Boolean {
			var hitEnemy:Boolean = false;
			for (var i:int = 0; i < enemyList.length; i++) {
				var enemy:Enemy = enemyList[i] as Enemy;
				if (enemy.fanSprite.hitTestPoint(player.x, player.y, true)) {
					hitEnemy = true;
				}
			}
			return hitEnemy;
		}
		
		public function get roleCon():Sprite {
			return _roleCon;
		}

		public function get player():RoleView {
			return _player;
		}
	}
}
