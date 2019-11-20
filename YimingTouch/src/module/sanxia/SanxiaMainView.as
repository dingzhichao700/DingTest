package module.sanxia {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import util.BaseView;
	import util.WindowManager;

	import utils.ResourceManager;
	import utils.Style;

	public class SanxiaMainView extends BaseView {

		private var btn2:Sprite;
		private var btn3:Sprite;
		private var btn4:Sprite;
		private var btn5:Sprite;
		private var btnIndex:Sprite;
		private var picShotList:Array;

		public function SanxiaMainView() {
			LAYER_TYPE = WindowManager.LAYER_PANEL1;

			ResourceManager.getInstance().getImage("assets/index1.jpg", this, 0, 0);

			btn2 = Style.getBlock(302, 68, this, 1438, 527);
			btn2.addEventListener(MouseEvent.CLICK, onClick2);

			btn3 = Style.getBlock(302, 68, this, 1438, 600);
			btn3.addEventListener(MouseEvent.CLICK, onClick3);

			btn4 = Style.getBlock(302, 68, this, 1438, 674);
			btn4.addEventListener(MouseEvent.CLICK, onClick4);

			btn5 = Style.getBlock(302, 68, this, 1438, 747);
			btn5.addEventListener(MouseEvent.CLICK, onClick5);

			btnIndex = Style.getBlock(376, 60, this, 1400, 870);
			btnIndex.addEventListener(MouseEvent.CLICK, onIndex);

			picShotList = [];
			for (var i:int = 0; i < 12; i++) {
				var sp:* = Style.getBlock(188, 146, this);
				sp.x = 126 + 198 * (i % 6);
				sp.y = 533 + 155 * Math.floor(i / 6);
				sp.addEventListener(MouseEvent.CLICK, onPic);
				picShotList.push(sp);
			}
		}

		private function onPic(e:MouseEvent):void {
			var targetIndex:int = 0;
			if (picShotList.indexOf(e.currentTarget) >= 0) {
				targetIndex = picShotList.indexOf(e.currentTarget);
			}
			var url:String = "assets/pic/sanxia/" + (targetIndex + 1) + ".jpg";
			MainControl.ins.showPic(url);
		}

		private function onClick2(e:MouseEvent):void {
			close();
			MainControl.ins.openZuzhijiagouIndex();
		}

		private function onClick3(e:MouseEvent):void {
			close();
			MainControl.ins.openZhengceIndex();
		}

		private function onClick4(e:MouseEvent):void {
			close();
			MainControl.ins.openLingdaoguanhuaiIndex();
		}

		private function onClick5(e:MouseEvent):void {
			close();
			MainControl.ins.openFalvfaguiIndex();
		}

		private function onIndex(e:MouseEvent):void {
			MainControl.ins.openIndex();
			close();
		}

	}
}
