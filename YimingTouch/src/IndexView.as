package {
	import flash.events.MouseEvent;
	
	import fl.controls.TextArea;
	
	import util.BaseView;
	import util.MainControl;
	import util.Utils;
	import util.WindowManager;
	import util.XmlManager;
	
	import utils.ResourceManager;
	import utils.Style;
	import utils.cases.ImageButton;

	public class IndexView extends BaseView {

		private var txt:TextArea;
		private var btn1:ImageButton;
		private var btn2:ImageButton;
		private var btn3:ImageButton;
		private var btn4:ImageButton;
		private var btn5:ImageButton;

		public function IndexView() {
			LAYER_TYPE = WindowManager.LAYER_BOTTOM;
			
			ResourceManager.getInstance().getImage("assets/index2.jpg", this, 0, 0);
			txt = Utils.createTextArea(850, 600, XmlManager.ins.getData(GameConfig.XML_QIANYAN), this, 140, 230, 25);
			
			btn1 = Style.getImageButton("assets/index_btn1.png", this, 1180, 240);
			btn1.addEventListener(MouseEvent.CLICK, onClick1);
			
			btn2 = Style.getImageButton("assets/index_btn2.png", this, 1180, 360);
			btn2.addEventListener(MouseEvent.CLICK, onClick2);
			
			btn3 = Style.getImageButton("assets/index_btn3.png", this, 1180, 480);
			btn3.addEventListener(MouseEvent.CLICK, onClick3);
			
			btn4 = Style.getImageButton("assets/index_btn4.png", this, 1180, 600);
			btn4.addEventListener(MouseEvent.CLICK, onClick4);
			
			btn5 = Style.getImageButton("assets/index_btn5.png", this, 1180, 720);
			btn5.addEventListener(MouseEvent.CLICK, onClick5);
		}

		override public function onOpen():void {
		}
		
		private function onClick1(e:MouseEvent):void {
		}
		
		private function onClick2(e:MouseEvent):void {
		}
		
		private function onClick3(e:MouseEvent):void {
			close();
			MainControl.ins.openZhengceIndex();
		}
		
		private function onClick4(e:MouseEvent):void {
		}
		
		private function onClick5(e:MouseEvent):void {
		}

	}
}
