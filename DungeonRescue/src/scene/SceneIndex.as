package scene {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import utils.ResourceManager;
	import utils.Style;

	public class SceneIndex extends Sprite {
		
		public function SceneIndex() {
			ResourceManager.getInstance().getImage("res/bgIndex.jpg", this);
			
			var startSp:Sprite = Style.getBlock(410, 130, this, 1290, 840);
			startSp.addEventListener(MouseEvent.CLICK, onStart);
			this.addChild(startSp);
		}
		
		private function onStart(e:MouseEvent):void {
			SceneManager.getInstance().initStage("intro");
		}
	}
}
