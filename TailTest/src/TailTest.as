package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import utils.ResourceManager;
	import utils.Style;

	[SWF(frameRate = "30", backgroundColor = "0xaaaaaa", width = 720, height = 480)]

	public class TailTest extends Sprite {

		private var resBmp:Bitmap;
		private var CUT:int = 3;

		public function TailTest() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			init();
		}

		private function init():void {
			if(!ResourceManager.getInstance().hasRes("common")) {
				ResourceManager.getInstance().loadRes("common", init);
				return;
			}

			resBmp = Style.getBitmap("tail", "", this, 50, 50);
			var bmd:BitmapData;
			var cutWidth:int = resBmp.width / CUT;
			for(var i:int = 0; i < CUT; i++) {
				bmd = new BitmapData(cutWidth, resBmp.height, true, 0);
				bmd.copyPixels(resBmp.bitmapData, new Rectangle(cutWidth * i, 0, cutWidth, resBmp.height), new Point());

				var pixelTop:int = 0;
				for(var j:int = 0; j < bmd.height; j++) {
					var value:int = bmd.getPixel(bmd.width - 1, j);
					if(value != 0) {
						pixelTop = j;
						break;
					}
				}
				for(j; j < bmd.height; j++) {
					var value:int = bmd.getPixel(bmd.width - 1, j);
					trace(j);
					if(value != 0) {
						pixelTop = j;
						break;
					}
				}
				
				
//				var round:Sprite = new Sprite();
//				round.

				var bmp:Bitmap = new Bitmap(bmd)
				bmp.x = 50 + (cutWidth + 5) * i;
				bmp.y = 180;
				addChild(bmp);
			}
		}
	}
}
