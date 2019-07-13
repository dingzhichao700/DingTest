package module.zhengce {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import util.SecondView;
	
	import utils.ResourceManager;
	import utils.Style;

	public class Sigebang_bangguanliView extends SecondView {

		private var btnPic:Sprite;
		private var picShotList:Array;

		public function Sigebang_bangguanliView() {
			ResourceManager.getInstance().getImage("assets/front3_1_4-1.png", conBg, 362, 85);
			btnClose.addEventListener(MouseEvent.CLICK, close);
		}

		override public function onOpen():void {
			con.removeChildren();
			ResourceManager.getInstance().getImage("assets/front3_1_4-2.png", con, 335, 285);
			btnPic = Style.getBlock(1264, 60, con, 333, 916, 0x0000ff);
			btnPic.addEventListener(MouseEvent.CLICK, showFiles);
		}

		private function showFiles(e:MouseEvent):void {
			con.removeChildren();
			ResourceManager.getInstance().getImage("assets/front3_1_4-3.png", con, 517, 380);

			picShotList = [];
			for (var i:int = 0; i < 3; i++) {
				var sp:Sprite = Style.getBlock(288, 188, this, 517 + 306 * i, 380, 0x00ff00);
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
			showFile(targetIndex);
		}

		private function showFile(index:int):void {
			var url:String = "assets/pic/guanli/" + (index + 1) + ".jpg";
			MainControl.ins.showFile(url);
		}

	}
}
