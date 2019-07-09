package module.zhengce {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import util.SecondView;
	
	import utils.ResourceManager;
	import utils.Style;

	public class Sigebang_bangrongheView extends SecondView {

		private var btnPic:Sprite;
		private var picMain:Bitmap;
		private var picShotList:Array;

		public function Sigebang_bangrongheView() {
			ResourceManager.getInstance().getImage("assets/front3_1_1-1.png", conBg, 362, 85);
			btnClose.addEventListener(MouseEvent.CLICK, close);
		}

		override public function onOpen():void {
			con.removeChildren();
			ResourceManager.getInstance().getImage("assets/front3_1_1-2.png", con, 335, 280);
			btnPic = Style.getBlock(1264, 60, this, 333, 920);
			btnPic.addEventListener(MouseEvent.CLICK, showPics);
		}

		private function showPics(e:MouseEvent):void {
			con.removeChildren();

			picShotList = [];
			for (var i:int = 0; i < 9; i++) {
				var sp:Sprite = new Sprite();
				var bmp:Bitmap = ResourceManager.getInstance().getImage("assets/pic/ronghe/mini_" + (i + 1) + ".jpg");
				sp.addChild(bmp);
				sp.x = 500 + 296 * (i % 3);
				sp.y = 300 + 193 * Math.floor(i / 3);
				sp.addEventListener(MouseEvent.CLICK, onPic);
				con.addChild(sp);
				picShotList.push(sp);
			}
		}

		private function onPic(e:MouseEvent):void {
			var targetIndex:int = 0;
			if (picShotList.indexOf(e.currentTarget) >= 0) {
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
			var url:String = "assets/pic/ronghe/" + (index + 1) + ".jpg";
			MainControl.ins.showPic(url);
		}

	}
}
