package module.zhengce {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import utils.ResourceManager;
	import utils.Style;

	public class SigebangView extends Sprite {
		
		private var part1:Sprite;
		private var part2:Sprite;
		private var part3:Sprite;
		private var part4:Sprite;
		
		public function SigebangView() {
			ResourceManager.getInstance().getImage("assets/guide3_1.png", this);
			
			part1 = Style.getBlock(1150, 88, this, 0, 75, 0x00ff00);
			part1.addEventListener(MouseEvent.CLICK, onPart1);
			
			part2 = Style.getBlock(1150, 88, this, 0, 169, 0x00ff00);
			part2.addEventListener(MouseEvent.CLICK, onPart2);
			
			part3 = Style.getBlock(1150, 88, this, 0, 263, 0x00ff00);
			part3.addEventListener(MouseEvent.CLICK, onPart3);
			
			part4 = Style.getBlock(1150, 88, this, 0, 357, 0x00ff00);
			part4.addEventListener(MouseEvent.CLICK, onPart4);
		}
		
		private function onPart1(e:MouseEvent):void {
			MainControl.ins.openZhengce_bangrongheView();
		}
		
		private function onPart2(e:MouseEvent):void {
			MainControl.ins.openZhengce_bangfazhanView();
		}
		
		private function onPart3(e:MouseEvent):void {
			MainControl.ins.openZhengce_bangjieyouView();
		}
		
		private function onPart4(e:MouseEvent):void {
			MainControl.ins.openZhengce_bangguanliView();
		}
		
	}
}
