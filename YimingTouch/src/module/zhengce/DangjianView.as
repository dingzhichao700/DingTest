package module.zhengce {
	import flash.display.Sprite;
	
	import module.ImageViewer;
	
	import utils.ResourceManager;

	public class DangjianView extends Sprite {
		
		private var imageView:ImageViewer;
		
		public function DangjianView() {
			ResourceManager.getInstance().getImage("assets/title_dangjian.png", this,0, 50);
			
			imageView = new ImageViewer();
			imageView.y = 115;
			imageView.setMask(1116, 464);
			imageView.showFile("assets/pic/dangjian/1.jpg");
			this.addChild(imageView);
		}
		
	}
}
