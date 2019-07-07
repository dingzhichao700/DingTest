package {
	import flash.events.MouseEvent;
	
	import fl.controls.TextArea;
	
	import util.BaseView;
	import util.MainControl;
	import util.WindowManager;
	
	import utils.ResourceManager;
	import utils.Style;
	import utils.cases.ImageButton;

	public class HomeView extends BaseView {

		private var txt:TextArea;
		private var btn:ImageButton;

		public function HomeView() {
			LAYER_TYPE = WindowManager.LAYER_BOTTOM;
			
			ResourceManager.getInstance().getImage("assets/index.jpg", this, 0, 0);
			btn = Style.getImageButton("assets/enter.png", this, 800, 800);
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
