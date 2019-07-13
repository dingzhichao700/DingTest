package module {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import fl.controls.TextArea;
	
	import util.BaseView;
	import util.WindowManager;
	
	import utils.ResourceManager;
	import utils.Style;

	public class HomeView extends BaseView {

		private var btn:Sprite;

		public function HomeView() {
			LAYER_TYPE = WindowManager.LAYER_BOTTOM;
			
			ResourceManager.getInstance().getImage("assets/index00.jpg", this, 0, 0);
			btn = Style.getBlock(1900, 1060, this, 10, 10);
			btn.addEventListener(MouseEvent.CLICK, onClick);
		}

		override public function onOpen():void {
		}
		
		private function onClick(e:MouseEvent):void {
			close();
			MainControl.ins.openIndex();
		}

	}
}
