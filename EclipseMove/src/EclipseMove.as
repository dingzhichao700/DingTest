package {
	import flash.display.Sprite;

	public class EclipseMove extends Sprite {
		
		private var RADIUS:int = 50;
		
		public function EclipseMove() {
			var sp:Sprite = new Sprite();
			sp.x = 100;
			sp.y = 100;
			addChild(sp);
			for (var i:int = 0; i < 360; i++) {
				sp.graphics.beginFill(0xfff00);
				var posX:Number= Math.cos(i * Math.PI / 180) * RADIUS;
				var posY:Number= Math.sin(i * Math.PI / 180) * RADIUS;
				sp.graphics.drawCircle(posX, posY, 2);
			}
		}
	}
}
