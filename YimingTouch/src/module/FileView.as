package module {
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import util.BaseView;
	import util.WindowManager;
	
	import utils.ResourceManager;
	import utils.Style;
	import utils.cases.ImageButton;

	public class FileView extends BaseView {

		private var con:Sprite;
		private var btnClose:ImageButton;
		private var down_point:Point;
		private var down_posY:int;
		private var speed:Number;
		private var timer_speed:Timer;
		private var timer_flow:Timer;
		private var imageView:ImageViewer;

		public function FileView() {
			LAYER_TYPE = WindowManager.LAYER_PANEL3;
			ResourceManager.getInstance().getImage("assets/bg_panel2.png", this);

			con = new Sprite();
			con.x = 363;
			con.y = 103;
			addChild(con);

			imageView = new ImageViewer();
			imageView.setMask(1206, 857);
			con.addChild(imageView);

			btnClose = Style.getImageButton("assets/btn_close.png", this, 1503, 30);
			btnClose.addEventListener(MouseEvent.CLICK, close);
		}

		public function showFile(url:String):void {
			imageView.showFile(url);
		}

	}
}
