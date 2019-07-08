package module.sanxia {
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
		
		public function SanxiaMainView() {
			LAYER_TYPE = WindowManager.LAYER_PANEL1;

			ResourceManager.getInstance().getImage("assets/index3_1.jpg", this, 0, 0);
			
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
