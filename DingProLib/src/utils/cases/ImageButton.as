package utils.cases {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import utils.ResourceManager;

	public class ImageButton extends Sprite {
		
		private var imgBtn:Bitmap;
		
		public function ImageButton() {
		}
		
		public function setImage(url):void {
			imgBtn = ResourceManager.getInstance().getImage(url, this, 0, 0);
		}
	}
}
