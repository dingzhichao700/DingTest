package module.zhengce {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import module.ImageViewer;
	
	import utils.ResourceManager;
	import utils.Style;

	public class LianxiView extends Sprite {
		
		private var btn1:Sprite;
		private var btn2:Sprite;	
		
		public function LianxiView() {
			ResourceManager.getInstance().getImage("assets/front3_3.png", this, 0, 80);
			
			btn1 = Style.getBlock(330, 260, this, 0, 80);
			btn1.addEventListener(MouseEvent.CLICK, onClick1);
			
			btn2 = Style.getBlock(330, 260, this, 426, 80);
			btn2.addEventListener(MouseEvent.CLICK, onClick2);
		}
		
		private function onClick1(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/lianxi/1.jpg");
		}
		
		private function onClick2(e:MouseEvent):void {
			MainControl.ins.showFile("assets/pic/lianxi/2.jpg");
		}
		
	}
}
