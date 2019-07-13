package module.falv {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import util.BaseView;
	import util.WindowManager;
	
	import utils.ResourceManager;
	import utils.Style;

	public class FalvfaguiMainView extends BaseView {
		
		private var btn1:Sprite;
		private var btn2:Sprite;
		private var btn3:Sprite;
		private var btn4:Sprite;
		
		private var part1:Sprite;
		private var part2:Sprite;
		private var part3:Sprite;
		
		private var btnIndex:Sprite;
		
		public function FalvfaguiMainView() {
			LAYER_TYPE = WindowManager.LAYER_PANEL1;
			
			ResourceManager.getInstance().getImage("assets/index5.jpg", this, 0, 0);
			
			btn1 = Style.getBlock(302, 68, this, 1438, 454);
			btn1.addEventListener(MouseEvent.CLICK, onClick1);
			
			btn2 = Style.getBlock(302, 68, this, 1438, 527);
			btn2.addEventListener(MouseEvent.CLICK, onClick2);
			
			btn3 = Style.getBlock(302, 68, this, 1438, 600);
			btn3.addEventListener(MouseEvent.CLICK, onClick3);
			
			btn4 = Style.getBlock(302, 68, this, 1438, 674);
			btn4.addEventListener(MouseEvent.CLICK, onClick4);
			
			part1 = Style.getBlock(261, 365, this, 171, 529);
			part1.addEventListener(MouseEvent.CLICK, onPart1);
			
			part2 = Style.getBlock(261, 365, this, 475, 529);
			part2.addEventListener(MouseEvent.CLICK, onPart2);
			
			part3 = Style.getBlock(261, 365, this, 780, 529);
			part3.addEventListener(MouseEvent.CLICK, onPart3);
			
			btnIndex = Style.getBlock(376, 60, this, 1400, 870);
			btnIndex.addEventListener(MouseEvent.CLICK, onIndex);
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
		
		private function onPart1(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/falv/1.jpg");
		}
		
		private function onPart2(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/falv/2.jpg");
		}
		
		private function onPart3(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/falv/3.jpg");
		}
		
		private function onIndex(e:MouseEvent):void {
			MainControl.ins.openIndex();
			close();
		}
	}
}
