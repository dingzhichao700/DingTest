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

	public class ZhengceMainView extends BaseView {
		
		private var txt:TextArea;
		private var btn1:ImageButton;
		private var btn2:ImageButton;
		private var btn3:ImageButton;
		private var btn4:ImageButton;
		private var btnIndex:ImageButton;
		private var btnReturn:ImageButton;
		
		public function ZhengceMainView() {
			LAYER_TYPE = WindowManager.LAYER_PANEL1;
			
			ResourceManager.getInstance().getImage("assets/part3_index.jpg", this, 0, 0);
			txt = Utils.createTextArea(850, 600, XmlManager.ins.getData(GameConfig.XML_SIGEBANG), this, 140, 230, 25);
			
			btn1 = Style.getImageButton("assets/part3_btn1.png", this, 1180, 240);
			btn1.addEventListener(MouseEvent.CLICK, onClick1);
			
			btn2 = Style.getImageButton("assets/part3_btn2.png", this, 1180, 360);
			btn2.addEventListener(MouseEvent.CLICK, onClick2);
			
			btn3 = Style.getImageButton("assets/part3_btn3.png", this, 1180, 480);
			btn3.addEventListener(MouseEvent.CLICK, onClick3);
			
			btn4 = Style.getImageButton("assets/part3_btn4.png", this, 1180, 600);
			btn4.addEventListener(MouseEvent.CLICK, onClick4);
			
			btnIndex = Style.getImageButton("assets/returnIndex.png", this, 400, 900);
			btnIndex.addEventListener(MouseEvent.CLICK, onIndex);
			
			btnReturn = Style.getImageButton("assets/returnHome.png", this, 1200, 900);
			btnReturn.addEventListener(MouseEvent.CLICK, onReturn);
		}
		
		override public function onOpen():void {
		}
		
		private function onClick1(e:MouseEvent):void {
			close();
			MainControl.ins.openZhengce_sigebangView();
		}
		
		private function onClick2(e:MouseEvent):void {
		}
		
		private function onClick3(e:MouseEvent):void {
		}
		
		private function onClick4(e:MouseEvent):void {
		}
		
		private function onIndex(e:MouseEvent):void {
			MainControl.ins.openIndex();
			close();
		}
		
		private function onReturn(e:MouseEvent):void {
			close();
			MainControl.ins.openHome();
		}
		
	}
}
