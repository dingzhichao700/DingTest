package {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import Role.Bullet;
	import Role.RoleView;

	import utils.LoopManager;

	public class BulletManager {

		private var moveTimer:Timer;
		private var bulletList:Array;
		private const SPEP:int = 2;

		private static var _instance:BulletManager;

		public static function getInstance():BulletManager {
			_instance ||= new BulletManager;
			return _instance;
		}

		public function BulletManager() {
			bulletList = [];

			if (moveTimer) {
				moveTimer.stop();
				moveTimer.removeEventListener(TimerEvent.TIMER, onMoveTimer);
				moveTimer = null;
			}
			moveTimer = new Timer(10);
			moveTimer.addEventListener(TimerEvent.TIMER, onMoveTimer);
			moveTimer.start();
		}

		private function onMoveTimer(e:TimerEvent):void {
			if (LoopManager.getInstance().isPause) {
				return;
			}
			for (var i:int = 0; i < bulletList.length; i++) {
				var bullet:Bullet = bulletList[i] as Bullet;
				var xDis:int = bullet.dir == 3 ? SPEP : (bullet.dir == 7 ? -SPEP : 0);
				var yDis:int = bullet.dir == 5 ? SPEP : (bullet.dir == 1 ? -SPEP : 0);
				bullet.x += xDis;
				bullet.y += yDis;
				var needRemove:Boolean = false;
				/*打到玩家*/
				if (!player.invincible && player.hitTestPoint(bullet.x, bullet.y, true)) {
					RolesManager.getInstance().hitEnemyOrBullet();
					needRemove = true;
				}
				/*撞墙了*/
				if (BlockPainter.getInstance().blocks && BlockPainter.getInstance().blocks.hitTestPoint(bullet.x, bullet.y, true)) {
					needRemove = true;
				}
				if (needRemove) {
					removeBullet(bullet);
					i--;
				}
			}
		}

		public function shotButtet(x:int, y:int, dir:int, delay:int = 0):void {
			LoopManager.getInstance().doDelay(delay, addButtet, [x, y, dir]);
		}

		public function addButtet(x:int, y:int, dir:int, delay:int = 0):void {
			var bullet:Bullet = new Bullet(dir);
			bullet.x = x;
			bullet.y = y;
			bulletList.push(bullet);
			con.addChild(bullet);
		}

		private function removeBullet(bullet:Bullet):void {
			for (var i:int = 0; i < bulletList.length; i++) {
				if (bulletList[i] == bullet) {
					bulletList.splice(i, 1);
					if (con.contains(bullet)) {
						con.removeChild(bullet);
					}
					return;
				}
			}
		}

		public function get con():Sprite {
			return RolesManager.getInstance().roleCon;
		}

		public function get player():RoleView {
			return RolesManager.getInstance().player;
		}

	}
}
