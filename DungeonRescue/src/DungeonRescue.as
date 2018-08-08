package {
	import flash.display.Sprite;
	import flash.system.fscommand;
	
	[SWF(frameRate = "60", backgroundColor = "0xaaaaaa", width = 1920, height = 1080)]
	public class DungeonRescue extends Sprite {
		
		private var bgWidth:int = 720;
		private var bgHeight:int = 480;
		
		public function DungeonRescue() {
//			stage.scaleMode = StageScaleMode.NO_SCALE;
			fscommand("fullscreen", "true");
			init();
		}
		
		private function init():void {
			LayerManager.getInstance().init(this.stage);
			KeyBoardManager.getInstance().init(this.stage);
			
			SceneManager.getInstance().initStage("index");
		}
	}
}