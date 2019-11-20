package module {
	import flash.display.Bitmap;
	import flash.events.MouseEvent;

	import util.BaseView;
	import util.WindowManager;

	import utils.ResourceManager;
	import utils.Style;
	import utils.cases.ImageButton;

	public class PicView2 extends BaseView {

		private var btnClose:ImageButton;
		private var img:Bitmap;

		private var btn_left:ImageButton;
		private var btn_right:ImageButton;
		private var curIndex:int;

		public function PicView2() {
			LAYER_TYPE = WindowManager.LAYER_PANEL3;
			ResourceManager.getInstance().getImage("assets/bg_panel2.png", this);

			img = new Bitmap();
			img.x = 363;
			img.y = 103;
			addChild(img);

			btnClose = Style.getImageButton("assets/btn_close.png", this, 1503, 30);
			btnClose.addEventListener(MouseEvent.CLICK, close);

			btn_left = Style.getImageButton("assets/arrow1.png", this, 144, 464);
			btn_left.addEventListener(MouseEvent.CLICK, onLeft);

			btn_right = Style.getImageButton("assets/arrow2.png", this, 1660, 464);
			btn_right.addEventListener(MouseEvent.CLICK, onRight);
		}

		override public function onOpen():void {
			curIndex = 1;
			update();
		}

		private function onLeft(e:MouseEvent):void {
			if (curIndex > 1) {
				curIndex--;
			}
			update();
		}

		private function onRight(e:MouseEvent):void {
			if (curIndex < 4) {
				curIndex++;
			}
			update();
		}

		private function update():void {
			btn_left.visible = curIndex != 1;
			btn_right.visible = curIndex != 4;
			ResourceManager.getInstance().setImageData("assets/pic/lingdao/1_" + curIndex + ".png", img);
		}

	}
}
