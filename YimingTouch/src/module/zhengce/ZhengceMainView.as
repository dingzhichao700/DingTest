package module.zhengce {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import util.BaseView;
	import util.WindowManager;
	
	import utils.ResourceManager;
	import utils.Style;

	public class ZhengceMainView extends BaseView {

		private var btnIndex:Sprite;
		private var btn1:Sprite;
		private var btn2:Sprite;
		private var btn3:Sprite;
		private var btn4:Sprite;
		private var boxCon:Sprite;

		private var btnSelect:Bitmap;

		private var sigebang:SigebangView;

		public function ZhengceMainView() {
			LAYER_TYPE = WindowManager.LAYER_PANEL1;

			ResourceManager.getInstance().getImage("assets/index3.jpg", this);
			btnSelect = ResourceManager.getInstance().getImage("assets/btn_select.jpg", this, 1499, 670);
			ResourceManager.getInstance().getImage("assets/btns_3.png", this, 1520, 690);

			boxCon = new Sprite();
			boxCon.x = 150;
			boxCon.y = 450;
			addChild(boxCon);

			btnIndex = Style.getBlock(376, 60, this, 1400, 870);
			btnIndex.addEventListener(MouseEvent.CLICK, onIndex);

			btn1 = Style.getBlock(240, 59, this, 1500, 670, 0x00ff00);
			btn1.addEventListener(MouseEvent.CLICK, onClick1);

			btn2 = Style.getBlock(240, 59, this, 1500, 730, 0x00ff00);
			btn2.addEventListener(MouseEvent.CLICK, onClick2);

			btn3 = Style.getBlock(240, 59, this, 1500, 790, 0x00ff00);
			btn3.addEventListener(MouseEvent.CLICK, onClick3);

			btn4 = Style.getBlock(240, 59, this, 1500, 850, 0x00ff00);
			btn4.addEventListener(MouseEvent.CLICK, onClick4);
		}

		override public function onOpen():void {
			showCon(1);
		}

		private function onIndex(e:MouseEvent):void {
			MainControl.ins.openIndex();
			close();
		}

		private function onClick1(e:MouseEvent):void {
			showCon(1);
		}

		private function onClick2(e:MouseEvent):void {
//			showCon(2);
		}

		private function onClick3(e:MouseEvent):void {
//			showCon(3);
		}

		private function onClick4(e:MouseEvent):void {
//			showCon(4);
		}

		private function showCon(index:int):void {
			boxCon.removeChildren();
			btnSelect.y = this["btn" + index].y;
			switch (index) {
				case 1:
					sigebang ||= new SigebangView();
					sigebang.x = 30;
					sigebang.y = 50;
					boxCon.addChild(sigebang);
					break;
			}
		}

	}
}
