package scene {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import utils.ResourceManager;
	import utils.Style;

	public class SceneFail extends Sprite {
		
		public function SceneFail() {
			ResourceManager.getInstance().getImage("res/bgFail.jpg", this);
			
			var backSp:Sprite = Style.getBlock(310, 100, this, 1200, 920);
			backSp.addEventListener(MouseEvent.CLICK, onBack);
			this.addChild(backSp);
			
			var returnSp:Sprite = Style.getBlock(310, 100, this, 1560, 920);
			returnSp.addEventListener(MouseEvent.CLICK, onBack);
			this.addChild(returnSp);
		}
		
		private function onBack(e:MouseEvent):void {
			SceneManager.getInstance().initStage("index");
		}
	}
}
