package module {
	import flash.display.Bitmap;
	import flash.events.MouseEvent;

	import util.BaseView;
	import util.WindowManager;

	import utils.ResourceManager;
	import utils.Style;
	import utils.cases.ImageButton;

	public class PicView extends BaseView {

		private var btnClose:ImageButton;
		private var img:Bitmap;

		public function PicView() {
			LAYER_TYPE = WindowManager.LAYER_PANEL3;
			ResourceManager.getInstance().getImage("assets/bg_panel2.png", this);

			img = new Bitmap();
			img.x = 363;
			img.y = 103;
			addChild(img);
			
			btnClose = Style.getImageButton("assets/btn_close.png", this, 1503, 30);
			btnClose.addEventListener(MouseEvent.CLICK, close);
		}

		public function showPic(url:String):void {
			ResourceManager.getInstance().setImageData(url, img);
		}

	}
}
