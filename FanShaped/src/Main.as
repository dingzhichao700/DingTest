package {
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Main extends Sprite {
		public function Main() {
			var sector:FanShaped = new FanShaped(new Point(100, 100), 100, 0);
			this.addChild(sector);
			sector.drawSector(90);
		}
	}
}
