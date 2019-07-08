package module.zhengce {
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import fl.controls.TextArea;

	import util.BaseView;
	import util.Utils;
	import util.WindowManager;
	import util.XmlManager;

	import utils.ResourceManager;
	import utils.Style;
	import utils.cases.ImageButton;

	public class ZhengceMainView extends BaseView {

		private var txt:TextArea;
		private var btn1:Sprite;
		private var btn2:Sprite;
		private var btn3:Sprite;
		private var btn4:Sprite;
		private var btnIndex:Sprite;

		public function ZhengceMainView() {
			LAYER_TYPE = WindowManager.LAYER_PANEL1;

			ResourceManager.getInstance().getImage("assets/index3_3.jpg", this, 0, 0);
//			txt = Utils.createTextArea(850, 600, XmlManager.ins.getData(GameConfig.XML_SIGEBANG), this, 140, 230, 25);
//			txt.setStyle("backgroundColor", "0xffffff"); 

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
		}

		private function onClick1(e:MouseEvent):void {
//			close();
//			MainControl.ins.openZhengce_sigebangView();
		}

		private function onClick2(e:MouseEvent):void {
		}

		private function onClick3(e:MouseEvent):void {
		}

		private function onClick4(e:MouseEvent):void {
		}

		private function onIndex(e:MouseEvent):void {
			MainControl.ins.openIndex();
			close();
		}

	}
}
