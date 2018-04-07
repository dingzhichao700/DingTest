package utils {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;

	/**
	 * UI工具
	 * @author dingzhichao
	 *
	 */
	public class UITools {
		private static var shade:Bitmap;
		private static var shape:Shape;
		private static var bmd:BitmapData;

		public function UITools() {
		}

		/**生成阴影*/
		public static function getShade():Bitmap {
			if (!shade) {
				shape = new Shape();
				var matr:Matrix = new Matrix();
				matr.createGradientBox(60, 60);
				shape.graphics.beginGradientFill(GradientType.RADIAL, [0x00000, 0x000000], [0.7, 0], [30, 255], matr, SpreadMethod.PAD);
				shape.graphics.drawCircle(0, 0, 100);
				bmd = new BitmapData(60, 60, true, 0);
				bmd.draw(shape);
			}
			return new Bitmap(bmd);
		}
	}
}
