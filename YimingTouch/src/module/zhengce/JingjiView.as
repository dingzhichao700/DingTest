package module.zhengce {
	import flash.display.Sprite;
	
	import module.ImageViewer;
	
	import utils.ResourceManager;

	public class JingjiView extends Sprite {
		
		private var imageView:ImageViewer;
		
		public function JingjiView() {
			ResourceManager.getInstance().getImage("assets/title_jingji.png", this,0, 50);
			
			imageView = new ImageViewer();
			imageView.y = 115;
			imageView.setMask(1116, 464);
			imageView.showFile("assets/pic/jingji/1.jpg");
			this.addChild(imageView);
		}
		
	}
}
