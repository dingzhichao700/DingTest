package scene {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import utils.ResourceManager;
	import utils.Style;

	public class SceneWin extends Sprite {
		
		public function SceneWin() {
			ResourceManager.getInstance().getImage("res/bgWin.jpg", this);
			
			var startSp:Sprite = Style.getBlock(310, 100, this, 1200, 920);
			startSp.addEventListener(MouseEvent.CLICK, onBack);
			this.addChild(startSp);
			
			var returnSp:Sprite = Style.getBlock(310, 100, this, 1560, 920);
			returnSp.addEventListener(MouseEvent.CLICK, onBack);
			this.addChild(returnSp);
		}
		
		private function onBack(e:MouseEvent):void {
			SceneManager.getInstance().initStage("index");
		}
	}
}
