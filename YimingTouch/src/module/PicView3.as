package module {
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import util.BaseView;
	import util.WindowManager;
	
	import utils.ResourceManager;
	import utils.Style;
	import utils.cases.ImageButton;

	public class PicView3 extends BaseView {

		private var btnClose:ImageButton;
		private var img:Bitmap;

		private var btn_left:ImageButton;
		private var btn_right:ImageButton;
		private var curIndex:int;

		public function PicView3() {
			LAYER_TYPE = WindowManager.LAYER_PANEL3;
			var bg:Bitmap = ResourceManager.getInstance().getImage("assets/white.jpg", this);
			bg.alpha = 0.7;

			img = new Bitmap();
			img.x = 40;
			img.y = 25;
			addChild(img);

			btnClose = Style.getImageButton("assets/btn_close.png", this, 1788, 10);
			btnClose.addEventListener(MouseEvent.CLICK, close);

			btn_left = Style.getImageButton("assets/arrow3.png", this, 0, 570);
			btn_left.addEventListener(MouseEvent.CLICK, onLeft);

			btn_right = Style.getImageButton("assets/arrow4.png", this, 1865, 570);
			btn_right.addEventListener(MouseEvent.CLICK, onRight);
		}

		override public function onOpen():void {
		}
		
		public function showPic(index:int):void {
			curIndex = index;
			update();
		}

		private function onLeft(e:MouseEvent):void {
			if (curIndex > 1) {
				curIndex--;
			}
			update();
		}

		private function onRight(e:MouseEvent):void {
			if (curIndex < 3) {
				curIndex++;
			}
			update();
		}

		private function update():void {
			btn_left.visible = curIndex != 1;
			btn_right.visible = curIndex != 3;
			ResourceManager.getInstance().setImageData("assets/pic/zuzhi/" + curIndex + ".png", img);
		}

	}
}
