package {
	import flash.display.Bitmap;
	import flash.display.Sprite;
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

	public class Zhengce_sigebangView extends BaseView {

		private var txt:TextArea;
		private var btn1:ImageButton;
		private var btn2:ImageButton;
		private var btn3:ImageButton;
		private var btn4:ImageButton;
		private var btnIndex:ImageButton;
		private var btnReturn:ImageButton;
		private var btnBack:ImageButton;
		
		private var con:Sprite;
		private var picMain:Bitmap;
		private var picShotList:Array;
		private var fileShotList:Array;

		public function Zhengce_sigebangView() {
			LAYER_TYPE = WindowManager.LAYER_PANEL1;
			
			ResourceManager.getInstance().getImage("assets/part3_1.jpg", this, 0, 0);
			
			btn1 = Style.getImageButton("assets/par3_1_btn1.png", this, 50, 240);
			btn1.addEventListener(MouseEvent.CLICK, onClick1);
			
			btn2 = Style.getImageButton("assets/par3_1_btn2.png", this, 50, 360);
			btn2.addEventListener(MouseEvent.CLICK, onClick2);
			
			btn3 = Style.getImageButton("assets/par3_1_btn3.png", this, 50, 480);
			btn3.addEventListener(MouseEvent.CLICK, onClick3);
			
			btn4 = Style.getImageButton("assets/par3_1_btn4.png", this, 50, 600);
			btn4.addEventListener(MouseEvent.CLICK, onClick4);
			
			btnIndex = Style.getImageButton("assets/returnIndex.png", this, 400, 900);
			btnIndex.addEventListener(MouseEvent.CLICK, onIndex);
			
			btnReturn = Style.getImageButton("assets/returnHome.png", this, 1200, 900);
			btnReturn.addEventListener(MouseEvent.CLICK, onReturn);
			
			con = new Sprite();
			con.x = 550;
			con.y = 190;
			addChild(con);
		}

		override public function onOpen():void {
			showPic();
		}

		private function onClick1(e:MouseEvent):void {
			showPic();
		}

		private function onClick2(e:MouseEvent):void {
			showFiles();
		}

		private function onClick3(e:MouseEvent):void {
		}

		private function onClick4(e:MouseEvent):void {
		}

		private function onIndex(e:MouseEvent):void {
			MainControl.ins.openZhengceIndex();
			close();
		}

		private function onBack1(e:MouseEvent):void {
			this.removeChild(btnBack);
			showFiles();
		}
		
		private function onReturn(e:MouseEvent):void {
			close();
			MainControl.ins.openHome();
		}
		
		private function clearCon():void {
			con.removeChildren();
		}

		private function showFiles():void {
			clearCon();
			fileShotList = [];
			for (var i:int = 0; i < 4; i++) {
				var sp:Sprite = new Sprite();
				var bmp:Bitmap = ResourceManager.getInstance().getImage("assets/file_" + (i + 1) + ".png");
				sp.addChild(bmp);
				sp.x = 320 * i;
				sp.y = 120;
				sp.addEventListener(MouseEvent.CLICK, onFile);
				con.addChild(sp);
				fileShotList.push(sp);
			}
		}
		
		private function onFile(e:MouseEvent):void {
			var targetIndex:int = 0;
			if(fileShotList.indexOf(e.currentTarget) >= 0){
				targetIndex = fileShotList.indexOf(e.currentTarget);
			}
			showFile(targetIndex);
			btnBack ||= Style.getImageButton("assets/returnBack.png");
			btnBack.x = 400;
			btnBack.y = 900;
			btnBack.addEventListener(MouseEvent.CLICK, onBack1);
			this.addChild(btnBack);
		}
		
		private function showFile(index:int):void {
			clearCon();
			var str:String = "<font size='30' color='#ff0000'>\n\n\n           浙江省水库移民工作领导小组办公室关于印发\n            《浙江省水库移民专项资金项目管理暂行办法》的通知\n</font>"; 
			str += XmlManager.ins.getData("file" + (index+1));
			txt = Utils.createTextArea(1272, 673, str, con);
		}
		
		private function showPic():void {
			clearCon();
			picMain = new Bitmap();
			picMain.x = 40;
			picMain.y = 20;
			con.addChild(picMain);

			picShotList = [];
			for (var i:int = 0; i < 6; i++) {
				var sp:Sprite = new Sprite();
				var bmp:Bitmap = ResourceManager.getInstance().getImage("assets/pic/rongru/" + (i + 1) + ".jpg");
				bmp.scaleX = bmp.scaleY = 0.15;
				sp.addChild(bmp);
				sp.x = 1020;
				sp.y = 20 + 110 * i;
				sp.addEventListener(MouseEvent.CLICK, onShot);
				con.addChild(sp);
				picShotList.push(sp);
			}
			setMainPic(0);
		}

		private function onShot(e:MouseEvent):void {
			var targetIndex:int = 0;
			if(picShotList.indexOf(e.currentTarget) >= 0){
				targetIndex = picShotList.indexOf(e.currentTarget);
			}
			setMainPic(targetIndex);
		}

		/**
		 * 选中第几张照片 
		 * @param index 从0开始
		 * 
		 */		
		private function setMainPic(index:int):void {
			var url:String = "assets/pic/rongru/" + (index+1) + ".jpg";
			ResourceManager.getInstance().setImageData(url, picMain);
		}

	}
}
