package {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class RolesManager {
		
		private var moveTimer:Timer;
		private var _stage:Stage;
		private var player:Sprite;
		private static const STEP:int = 8;
		
		private static var instance:RolesManager;
		public static function getInstance():RolesManager {
			instance ||= new RolesManager();
			return instance;
		}
		
		public function RolesManager() {
		}
		
		public function init():void {
			initPlayer();
			
			if(moveTimer){
				moveTimer.stop();
				moveTimer.removeEventListener(TimerEvent.TIMER, onMoveTimer);
				moveTimer = null;
			}
			moveTimer = new Timer(10);
			moveTimer.addEventListener(TimerEvent.TIMER, onMoveTimer);
			moveTimer.start();
		}
		
		private function initPlayer():void {
			player ||= new Sprite();
			player.graphics.clear();
			player.graphics.beginFill(0xffff00);
			player.graphics.drawCircle(0, 0, 20);
			player.x = 100;
			player.y = 100;
			LayerManager.getInstance().LAYER_PLAYER.addChild(player);
		}
		
		private function onMoveTimer(e:TimerEvent):void {
			var playerCtr:PlayerControl = PlayerControl.getInstance();
			var xDis:int = playerCtr.moveHori[0] == 4 ? STEP : (playerCtr.moveHori[0] == 3 ? -STEP : 0);
			var yDis:int = playerCtr.moveVert[0] == 2 ? STEP : (playerCtr.moveVert[0] == 1 ? -STEP : 0);
			onMove(xDis, yDis);
		}
		
		public function onMove(xDis:int, yDis:int):void {
			if(BlockPainter.getInstance().blocks && BlockPainter.getInstance().blocks.hitTestPoint(player.x+xDis, player.y+yDis, true)){
				return;
			}
			player.x += xDis;
			player.y += yDis;
			if(player.x < 10){
				player.x = 10;
			} else if(player.x > 1530){
				player.x = 1530;
			} 
			if(player.y < 10){
				player.y = 10;
			} else if(player.y > 1070){
				player.y = 1070;
			}
		}
		
	}
}
