package Role {
	import flash.display.Sprite;

	public class Bullet extends Sprite {

		private var _dir:int;

		public function Bullet(value:int) {
			_dir = value;
			this.graphics.beginFill(0xffff00, 1);
			this.graphics.drawCircle(0, 0, 6);
		}

		public function get dir():int {
			return _dir;
		}

	}
}
