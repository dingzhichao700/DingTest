package module.zhengce {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import util.SecondView;
	
	import utils.ResourceManager;
	import utils.Style;

	public class Sigebang_bangfazhanView extends SecondView {

		private var part1:Sprite;
		private var part2:Sprite;
		private var part3:Sprite;
		private var part4:Sprite;

		public function Sigebang_bangfazhanView() {
			ResourceManager.getInstance().getImage("assets/front3_1_2.png", conBg, 362, 85);
			btnClose.addEventListener(MouseEvent.CLICK, onClose);

			part1 = Style.getBlock(334, 144, this, 1165, 295, 0x00ff00);
			part1.addEventListener(MouseEvent.CLICK, onPart1);

			part2 = Style.getBlock(334, 144, this, 1165, 447, 0x00ff00);
			part2.addEventListener(MouseEvent.CLICK, onPart2);

			part3 = Style.getBlock(334, 144, this, 1165, 600, 0x00ff00);
			part3.addEventListener(MouseEvent.CLICK, onPart3);

			part4 = Style.getBlock(334, 144, this, 1165, 750, 0x00ff00);
			part4.addEventListener(MouseEvent.CLICK, onPart4);
		}

		private function onPart1(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/fazhan/file1.jpg");
		}

		private function onPart2(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/fazhan/file2.jpg");
		}

		private function onPart3(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/fazhan/file3.jpg");
		}

		private function onPart4(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/fazhan/file4.jpg");
		}

		private function onClose(e:MouseEvent):void {
			close();
		}

	}
}
