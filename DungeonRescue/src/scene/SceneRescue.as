package scene {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import utils.ResourceManager;

	public class SceneRescue extends Sprite {
		
		private var imgMaze:Bitmap;
		
		public function SceneRescue() {
			ResourceManager.getInstance().getImage("bgScene.jpg", this);
			imgMaze = ResourceManager.getInstance().getImage("", this);
		}
		
		public function setState(index:int):void {
			ResourceManager.getInstance().setImageData("stage" + index + ".jpg", imgMaze);
			BlockPainter.getInstance().initMission(index);
		}

	}
}
