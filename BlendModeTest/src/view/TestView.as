package view {
	import laya.display.Sprite;

	public class TestView extends Sprite {

		private static var BLEND_MODES:Array = ["source-atop", "source-in", "source-out", "source-over", "destiantion-atop", "destination-in", "destination-out", "destination-over", "lighter", "copy", "xor"];

		public function TestView() {
			for (var i:int = 0; i < 11; i++) {
				var box:Sprite = new Sprite();
				box.pos(Math.floor(i % 4) * 200 + 50, Math.floor(i / 4) * 200 + 50);
				this.addChild(box);

				var sp1:Sprite = new Sprite();
				sp1.graphics.drawRect(0, 0, 100, 100, "#0000ff");
				box.addChild(sp1);

				var sp2:Sprite = new Sprite();
				sp2.graphics.drawCircle(100, 100, 50, "#ff0000");
				sp2.blendMode = BLEND_MODES[i];
				box.addChild(sp2);
			}
		}

	}
}
