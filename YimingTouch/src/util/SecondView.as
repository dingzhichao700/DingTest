package util {
	import flash.display.Sprite;

	import utils.ResourceManager;
	import utils.Style;
	import utils.cases.ImageButton;

	public class SecondView extends BaseView {

		protected var conBg:Sprite;
		protected var con:Sprite;
		protected var btnClose:ImageButton;

		public function SecondView() {
			LAYER_TYPE = WindowManager.LAYER_PANEL2;
			ResourceManager.getInstance().getImage("assets/bg_panel2.png", this);

			conBg = new Sprite();
			addChild(conBg);

			con = new Sprite();
			addChild(con);

			btnClose = Style.getImageButton("assets/btn_close.png", this, 1503, 30);
		}

	}
}
