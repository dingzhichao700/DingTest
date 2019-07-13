package module.zhuzhi {
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import util.BaseView;
	import util.WindowManager;
	
	import utils.ResourceManager;
	import utils.Style;

	public class ZuzhijiagouMainView extends BaseView {
		
		private var btn1:Sprite;
		private var btn2:Sprite;
		private var btn3:Sprite;
		private var btnIndex:Sprite;
		private var btnSelect:Bitmap;
		
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
		
		private function showCon(index:int):void {
			boxCon.removeChildren();
			var targetY:int = this["btn" + index].y;
			TweenMax.to(btnSelect, 0.2, {y: targetY});
			switch (index) {
				case 1:
					ResourceManager.getInstance().getImage("assets/front2_" + index + ".png", boxCon, 100, 50);
					break;
				case 2:
					ResourceManager.getInstance().getImage("assets/front2_" + index + ".png", boxCon, 100, 50);
					break;
				case 3:
					ResourceManager.getInstance().getImage("assets/front2_" + index + ".png", boxCon);
					break;
			}
		}
		
		private function onIndex(e:MouseEvent):void {
			MainControl.ins.openIndex();
			close();
		}
		
	}
}
