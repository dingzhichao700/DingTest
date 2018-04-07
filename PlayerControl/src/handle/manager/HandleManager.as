package handle.manager {
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import map.MapFacade;
	import map.controller.MapController;
	
	import pathing.PathingFacade;
	
	import role.RoleFacade;
	
	import scene.SceneFacade;

	/**
	 * 游戏玩家控制 管理器
	 * @author dingzhichao
	 *
	 */
	public class HandleManager extends Sprite {

		private var gameStage:Sprite;
		/**鼠标是否按下*/
		private var mouseDown:Boolean;
		private var moveTimer:Timer;

		public function HandleManager() {
		}

		/**初始化主角*/
		public function init():void {
			initListener();
		}

		/**初始化玩家操作侦听*/
		private function initListener():void {
			gameStage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			gameStage.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyBoardHandler);
		}

		/**鼠标事件*/
		public function onMouseDown(e:MouseEvent):void {
			gameStage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			gameStage.addEventListener(MouseEvent.MOUSE_UP, onMouseOut);
			mouseDown = true;
			moveRole();
			
			moveTimer ||= new Timer(300);
			moveTimer.addEventListener(TimerEvent.TIMER, onTimerHandler);
			moveTimer.start();
		}
		
		private function onMouseOut(e:MouseEvent):void {
			mouseDown = false;
			gameStage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			gameStage.removeEventListener(MouseEvent.MOUSE_UP, onMouseOut);
			if(moveTimer){
				moveTimer.stop();
				moveTimer.removeEventListener(TimerEvent.TIMER, onTimerHandler);
			}
		}

		/**键盘事件*/
		public function onKeyBoardHandler(e:KeyboardEvent):void {
			switch (e.keyCode) {
				/*JKL 分别控制 网格、移动区域、移动节点的显示*/
				case 74:
				case 75:
				case 76:
					PathingFacade.manager.showGrid(e.keyCode);
					break;
			}
		}

		/**计时获取鼠标坐标*/
		public function onTimerHandler(e:TimerEvent):void {
			if (mouseDown) {
				moveRole();
			}
		}
		
		private function moveRole():void {
			if(mouseX < 0 || mouseX > MapFacade.dataManager.mapWidth){
				return;
			}
			if(mouseY < 0 || mouseY > MapFacade.dataManager.mapHeight){
				return;
			}
			var point:Point = SceneFacade.manager.gameContainer.globalToLocal(new Point(mouseX, mouseY))
			RoleFacade.manager.moveRole(point, RoleFacade.manager.mainRole);
		}

		/**获取舞台*/
		public function getStage(stage:Sprite):void {
			gameStage = stage
		}
	}
}
