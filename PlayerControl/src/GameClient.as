package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import basic.GameMsg;
	
	import event.GameBus;
	
	import handle.HandleFacade;
	
	import pathing.PathingFacade;
	
	import scene.SceneFacade;

	[SWF(width = "1080", height = "640", backgroundColor = "0xDDaaDD", frameRate = "60")]
	public class GameClient extends Sprite {

		public static var Width:int;
		public static var Height:int;
		public static var startTime:int;

		public function GameClient() {	
			this.addEventListener(Event.ADDED_TO_STAGE, onStart);
		}

		private function onStart(e:Event):void {
			/*模块入口初始化*/
			FirstEnterGame.init();
			/*设置舞台引用*/
			initStage();
			/*抛出游戏开始消息*/
			GameBus.sendMsg(GameMsg.GAME_START);
			startTime = getTimer();
		}

		/**
		 * 设置舞台引用
		 * 需要获取舞台的管理模块，统一从这里取得引用
		 */
		private function initStage():void {
			/*获取舞台宽高，用于场景移动控制*/
			Width = this.stage.stageWidth;
			Height = this.stage.stageHeight;
			/*获取舞台引用*/
			SceneFacade.manager.getStage(this);
			HandleFacade.manager.getStage(this);
			PathingFacade.manager.getStage(this);
		}
	}
}
