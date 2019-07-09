package module {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import util.BaseView;
	import util.WindowManager;
	
	import utils.ResourceManager;
	import utils.Style;

	public class IndexView extends BaseView {

		private var btn1:Sprite;
		private var btn2:Sprite;
		private var btn3:Sprite;
		private var btn4:Sprite;
		private var btn5:Sprite;
		private var btnBack:Sprite;

		public function IndexView() {
			LAYER_TYPE = WindowManager.LAYER_BOTTOM;
			
			ResourceManager.getInstance().getImage("assets/index01.jpg", this, 0, 0);
			
			btn1 = Style.getBlock(302, 68, this, 1438, 454);
			btn1.addEventListener(MouseEvent.CLICK, onClick1);
			
			btn2 = Style.getBlock(302, 68, this, 1438, 527);
			btn2.addEventListener(MouseEvent.CLICK, onClick2);
			
			btn3 = Style.getBlock(302, 68, this, 1438, 600);
			btn3.addEventListener(MouseEvent.CLICK, onClick3);
			
			btn4 = Style.getBlock(302, 68, this, 1438, 674);
			btn4.addEventListener(MouseEvent.CLICK, onClick4);
			
			btn5 = Style.getBlock(302, 68, this, 1438, 747);
			btn5.addEventListener(MouseEvent.CLICK, onClick5);
			
			btnBack = Style.getBlock(376, 60, this, 1400, 870);
			btnBack.addEventListener(MouseEvent.CLICK, onBack);
		}

		override public function onOpen():void {
		}
		
		private function onClick1(e:MouseEvent):void {
			close();
			MainControl.ins.openSanxiaIndex();
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
		
		private function onBack(e:MouseEvent):void {
			MainControl.ins.openHome();
		}

	}
}
