package module {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import util.BaseView;
	import util.WindowManager;
	
	import utils.ResourceManager;
	import utils.Style;

	public class PicSmallView extends BaseView {

		private var btnClose:Sprite;
		private var img:Bitmap;

		public function PicSmallView() {
			
			LAYER_TYPE = WindowManager.LAYER_PANEL3;
			var bg:Bitmap = ResourceManager.getInstance().getImage("assets/white.jpg", this);
			bg.alpha = 0.8;

			img = new Bitmap();
			img.x = 563;
			img.y = 280;
			addChild(img);
			
			btnClose = Style.getBlock(100, 100, this, 1357, 283);
			btnClose.addEventListener(MouseEvent.CLICK, close);
		}

		public function showPic(url:String):void {
			img.bitmapData = null;
			ResourceManager.getInstance().setImageData(url, img);
		}

	}
}
