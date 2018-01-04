package {
	import flash.display.Bitmap;
	import flash.display.Sprite;

	import utils.BitmapClip;
	import utils.Style;

	public class Role extends Sprite {

		private var _state:int;
		private var _appearType:int;
		private var conBody:Sprite;
		private var conFoot:Sprite;

		public function Role() {
			this.graphics.beginFill(0xff0000, 0.8);
			this.graphics.drawCircle(0, 0, 5);
			conBody = new Sprite();
			addChild(conBody);
			var body:Bitmap = Style.getBitmap("body", "", conBody);
			body.x = -body.width / 2;
			body.y = -130;
			conFoot = new Sprite();
			addChild(conFoot);

			playStand();
		}

		public function setAppear(type:int):void {
			_appearType = type;
		}

		/*↓↓↓控制脚↓↓↓*/
		public function playStand():void {
			conFoot.removeChildren();
			var leg1:Bitmap = Style.getBitmap("leg_1", "", conFoot);
			leg1.x = -40;
			var leg2:Bitmap = Style.getBitmap("leg_1", "", conFoot);
			leg2.x = 9;
			leg1.y = leg2.y = -30;
		}

		public function playWalk():void {
			conFoot.removeChildren();
			BitmapClip.getBitmapClip("leg", "", true, 16, -20);
			BitmapClip.getBitmapClip("leg", "", true, 16, 20);
		}

		public function playJump():void {
		}
		/*↑↑↑控制脚↑↑↑*/
	}
}
