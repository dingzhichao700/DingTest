package module.lingdao {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import util.BaseView;
	import util.WindowManager;
	
	import utils.ResourceManager;
	import utils.Style;

	public class LingdaoguanhuaiMainView extends BaseView {
		
		private var btn1:Sprite;
		private var btn2:Sprite;
		private var btn3:Sprite;
		private var btn5:Sprite;
		
		private var part1:Sprite;
		private var part2:Sprite;
		private var part3:Sprite;
		private var part4:Sprite;
		private var part5:Sprite;
		private var part6:Sprite;
		private var btnIndex:Sprite;
		
		public function LingdaoguanhuaiMainView() {
			LAYER_TYPE = WindowManager.LAYER_PANEL1;
			
			ResourceManager.getInstance().getImage("assets/index4.jpg", this, 0, 0);
			
			btn1 = Style.getBlock(302, 68, this, 1438, 454);
			btn1.addEventListener(MouseEvent.CLICK, onClick1);
			
			btn2 = Style.getBlock(302, 68, this, 1438, 527);
			btn2.addEventListener(MouseEvent.CLICK, onClick2);
			
			btn3 = Style.getBlock(302, 68, this, 1438, 600);
			btn3.addEventListener(MouseEvent.CLICK, onClick3);
			
			btn5 = Style.getBlock(302, 68, this, 1438, 747);
			btn5.addEventListener(MouseEvent.CLICK, onClick5);
			
			part1 = Style.getBlock(368, 125, this, 138, 529);
			part1.addEventListener(MouseEvent.CLICK, onPart1);
			
			part2 = Style.getBlock(368, 125, this, 526, 529);
			part2.addEventListener(MouseEvent.CLICK, onPart2);
			
			part3 = Style.getBlock(368, 125, this, 914, 529);
			part3.addEventListener(MouseEvent.CLICK, onPart3);
			
			part4 = Style.getBlock(368, 173, this, 138, 671);
			part4.addEventListener(MouseEvent.CLICK, onPart4);
			
			part5 = Style.getBlock(368, 173, this, 526, 671);
			part5.addEventListener(MouseEvent.CLICK, onPart5);
			
			part6 = Style.getBlock(368, 173, this, 914, 671);
			part6.addEventListener(MouseEvent.CLICK, onPart6);
			
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
		
		private function onClick5(e:MouseEvent):void {
			close();
			MainControl.ins.openFalvfaguiIndex();
		}
		
		private function onPart1(e:MouseEvent):void {
			MainControl.ins.showPic("assets/pic/lingdao/1.png");
		}
		
		private function onPart2(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/lingdao/2.jpg");
		}
		
		private function onPart3(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/lingdao/3.jpg");
		}
		
		private function onPart4(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/lingdao/4.jpg");
		}
		
		private function onPart5(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/lingdao/5.jpg");
		}
		
		private function onPart6(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/lingdao/6.jpg");
		}
		
		private function onIndex(e:MouseEvent):void {
			MainControl.ins.openIndex();
			close();
		}
		
	}
}
