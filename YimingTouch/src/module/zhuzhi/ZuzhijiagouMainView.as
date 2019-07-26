package module.zhuzhi {
	import com.greensock.TweenMax;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import module.ImageViewer;

	import util.BaseView;
	import util.WindowManager;

	import utils.ResourceManager;
	import utils.Style;

	public class ZuzhijiagouMainView extends BaseView {

		private var btn1:Sprite;
		private var btn2:Sprite;
		private var btn3:Sprite;
		private var btn4:Sprite;
		private var imgBtn1:Bitmap;
		private var imgBtn2:Bitmap;
		private var imgBtn3:Bitmap;

		private var btnIndex:Sprite;
		private var btnSelect:Bitmap;

		private var imageView:ImageViewer;

		private var boxCon:Sprite;

		public function ZuzhijiagouMainView() {
			LAYER_TYPE = WindowManager.LAYER_PANEL1;

			ResourceManager.getInstance().getImage("assets/index2.jpg", this, 0, 0);
			btnSelect = ResourceManager.getInstance().getImage("assets/btn_select.jpg", this, 1499, 670);
			ResourceManager.getInstance().getImage("assets/btns_2.png", this, 1520, 612);

			boxCon = new Sprite();
			boxCon.x = 80;
			boxCon.y = 340;
			addChild(boxCon);

			btnIndex = Style.getBlock(376, 60, this, 1400, 870);
			btnIndex.addEventListener(MouseEvent.CLICK, onIndex);

			btn1 = Style.getBlock(240, 59, this, 1500, 597, 0x00ff00);
			btn1.addEventListener(MouseEvent.CLICK, onClick1);

			btn2 = Style.getBlock(240, 59, this, 1500, 655, 0x00ff00);
			btn2.addEventListener(MouseEvent.CLICK, onClick2);

			btn3 = Style.getBlock(240, 59, this, 1500, 715, 0x00ff00);
			btn3.addEventListener(MouseEvent.CLICK, onClick3);

			btn4 = Style.getBlock(240, 59, this, 1500, 776, 0x00ff00);
			btn4.addEventListener(MouseEvent.CLICK, onClick4);
		}

		override public function onOpen():void {
			btnSelect.y = 597;
			showCon(1);
		}

		private function onClick1(e:MouseEvent):void {
			showCon(1);
		}

		private function onClick2(e:MouseEvent):void {
			showCon(2);
		}

		private function onClick3(e:MouseEvent):void {
			showCon(3);
		}

		private function onClick4(e:MouseEvent):void {
			showCon(4);
		}

		private function showCon(index:int):void {
			boxCon.removeChildren();
			var targetY:int = this["btn" + index].y;
			TweenMax.to(btnSelect, 0.2, {y: targetY});
			switch (index) {
				case 1:
					ResourceManager.getInstance().getImage("assets/front2_" + index + ".png", boxCon, 100, 50);
					showButton1();
					break;
				case 2:
					ResourceManager.getInstance().getImage("assets/front2_" + index + ".png", boxCon, 100, 50);
					showButton2();
					break;
				case 3:
					ResourceManager.getInstance().getImage("assets/front2_" + index + ".png", boxCon);
					break;
				case 4:
					ResourceManager.getInstance().getImage("assets/front2_" + index + ".png", boxCon, 100, 10);
					showButton4();
					break;
			}
		}

		private function showButton1():void {
			var sp1:Sprite = Style.getBlock(255, 47, boxCon, 420, 280);
			sp1.addEventListener(MouseEvent.CLICK, onPic1);

			var sp2:Sprite = Style.getBlock(255, 47, boxCon, 420, 377);
			sp2.addEventListener(MouseEvent.CLICK, onPic2);

			var sp3:Sprite = Style.getBlock(255, 47, boxCon, 150, 535);
			sp3.addEventListener(MouseEvent.CLICK, onPic3);

			var sp4:Sprite = Style.getBlock(255, 47, boxCon, 420, 535);
			sp4.addEventListener(MouseEvent.CLICK, onPic4);

			var sp5:Sprite = Style.getBlock(255, 47, boxCon, 692, 535);
			sp5.addEventListener(MouseEvent.CLICK, onPic5);
		}

		private function showButton2():void {
			var sp6:Sprite = Style.getBlock(223, 108, boxCon, 218, 255);
			sp6.addEventListener(MouseEvent.CLICK, onPic6);

			var sp7:Sprite = Style.getBlock(245, 108, boxCon, 868, 255);
			sp7.addEventListener(MouseEvent.CLICK, onPic7);

			var sp8:Sprite = Style.getBlock(200, 105, boxCon, 140, 494);
			sp8.addEventListener(MouseEvent.CLICK, onPic8);

			var sp9:Sprite = Style.getBlock(213, 105, boxCon, 668, 494);
			sp9.addEventListener(MouseEvent.CLICK, onPic9);
		}

		private function showButton4():void {
			imgBtn1 = ResourceManager.getInstance().getImage("", boxCon, 100, 160);
			imgBtn2 = ResourceManager.getInstance().getImage("", boxCon, 472, 160);
			imgBtn3 = ResourceManager.getInstance().getImage("", boxCon, 844, 160);

			imageView = new ImageViewer();
			imageView.x = 100;
			imageView.y = 250;
			imageView.setMask(1116, 435);
			boxCon.addChild(imageView);

			var file1:Sprite = Style.getBlock(371, 70, boxCon, imgBtn1.x, imgBtn1.y);
			file1.addEventListener(MouseEvent.CLICK, onFile1);

			var file2:Sprite = Style.getBlock(371, 70, boxCon, imgBtn2.x, imgBtn2.y);
			file2.addEventListener(MouseEvent.CLICK, onFile2);

			var file3:Sprite = Style.getBlock(371, 70, boxCon, imgBtn3.x, imgBtn3.y);
			file3.addEventListener(MouseEvent.CLICK, onFile3);
			showFile(1);
		}

		private function onFile1(e:MouseEvent):void {
			showFile(1);
		}

		private function onFile2(e:MouseEvent):void {
			showFile(2);
		}

		private function onFile3(e:MouseEvent):void {
			showFile(3);
		}

		private function showFile(index:int):void {
			ResourceManager.getInstance().setImageData("assets/zuzhi_yiming_1_" + (index == 1 ? 1 : 0) + ".png", imgBtn1);
			ResourceManager.getInstance().setImageData("assets/zuzhi_yiming_2_" + (index == 2 ? 1 : 0) + ".png", imgBtn2);
			ResourceManager.getInstance().setImageData("assets/zuzhi_yiming_3_" + (index == 3 ? 1 : 0) + ".png", imgBtn3);
			imageView.showFile("assets/pic/zuzhi/" + index + ".jpg");
		}

		private function onPic1(e:MouseEvent):void {
			MainControl.ins.showSmallPic("assets/pic/zuzhi/1.png");
		}

		private function onPic2(e:MouseEvent):void {
			MainControl.ins.showSmallPic("assets/pic/zuzhi/2.png");
		}

		private function onPic3(e:MouseEvent):void {
			MainControl.ins.showSmallPic("assets/pic/zuzhi/3.png");
		}

		private function onPic4(e:MouseEvent):void {
			MainControl.ins.showSmallPic("assets/pic/zuzhi/4.png");
		}

		private function onPic5(e:MouseEvent):void {
			MainControl.ins.showSmallPic("assets/pic/zuzhi/5.png");
		}

		private function onPic6(e:MouseEvent):void {
			MainControl.ins.showSmallPic("assets/pic/zuzhi/6.png");
		}

		private function onPic7(e:MouseEvent):void {
			MainControl.ins.showSmallPic("assets/pic/zuzhi/7.png");
		}

		private function onPic8(e:MouseEvent):void {
			MainControl.ins.showSmallPic("assets/pic/zuzhi/8.png");
		}

		private function onPic9(e:MouseEvent):void {
			MainControl.ins.showSmallPic("assets/pic/zuzhi/9.png");
		}

		private function onIndex(e:MouseEvent):void {
			MainControl.ins.openIndex();
			close();
		}

	}
}
