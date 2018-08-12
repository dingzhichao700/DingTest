package scene {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import utils.ImageButton;
	import utils.LoopManager;
	import utils.ResourceManager;
	import utils.Style;

	public class SceneIntro extends Sprite {

		private var imgRole:Bitmap;
		private var btnLeft:ImageButton;
		private var btnRight:ImageButton;
		private var index:int;
		private const ROLE_URL:Array = ["soldier1.png", "soldier2.png", "enemy1.png", "enemy2.png"];

		public function SceneIntro() {
			ResourceManager.getInstance().getImage("bgIntro.jpg", this);

			var startSp:Sprite = Style.getBlock(310, 100, this, 1200, 920);
			startSp.addEventListener(MouseEvent.CLICK, onBegin);
			this.addChild(startSp);

			var returnSp:Sprite = Style.getBlock(310, 100, this, 1560, 920);
			returnSp.addEventListener(MouseEvent.CLICK, onBack);
			this.addChild(returnSp);

			btnLeft = Style.getImageButton("arrow_1.png", this, 150, 500);
			btnLeft.addEventListener(MouseEvent.CLICK, onChangeLeft);

			btnRight = Style.getImageButton("arrow_2.png", this, 1000, 500);
			btnRight.addEventListener(MouseEvent.CLICK, onChangeRight);

			imgRole = ResourceManager.getInstance().getImage("", this, 360, 240);
			index = 0;
			update();
		}

		private function onBegin(e:MouseEvent):void {
			SceneManager.getInstance().initStage("1");
		}

		private function onBack(e:MouseEvent):void {
			SceneManager.getInstance().initStage("index");
		}

		private function onChangeLeft(e:MouseEvent):void {
			if(index > 0){
				index--;
			}
			update();
		}

		private function onChangeRight(e:MouseEvent):void {
			if(index < ROLE_URL.length - 1){
				index++;
			}
			update();
		}
		
		private function update():void {
			ResourceManager.getInstance().setImageData(ROLE_URL[index], imgRole);
			btnLeft.visible = index > 0;
			btnRight.visible = index < ROLE_URL.length - 1;
		}

	}
}
