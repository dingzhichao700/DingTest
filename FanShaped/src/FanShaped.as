package {
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * 画扇形
	 * @author LuLihong
	 * @date 2014-04-25
	 */
	public class FanShaped extends Sprite {

		/**圆心*/
		private var _center:Point;
		/**半径*/
		private var _radius:Number = 0;
		/**扇形起始相位角度*/
		private var _startAngle:Number = 0;
		/**扇形角度*/
		private var _angle:Number = 360;
		/**背景色 */
		private var _fillColor:uint;
		private var _fillAlpha:Number;

		/**
		 *
		 * @param center
		 * @param radius
		 * @param startAngle
		 * @param fillColor
		 * @param fillAlpha
		 */
		public function FanShaped(center:Point, radius:Number, startAngle:Number, fillColor:uint = 0x2C7EB5, fillAlpha:Number = 1.0) {
			this._center = center;
			this._radius = radius;
			this._startAngle = startAngle;

			this._fillColor = fillColor;
			this._fillAlpha = fillAlpha;
		}

		/**
		 * 画扇形
		 * @param angle			扇形角度
		 * @param fillColor		背景色
		 *
		 */
		public function drawSector(angle:Number, fillColor:uint = 0x2C7EB5):void {
			this._angle = angle;
			this._fillColor = fillColor;

			this.graphics.clear();

			this.graphics.lineStyle(1, _fillColor);
			this.graphics.beginFill(_fillColor, _fillAlpha);

			if (Math.abs(_angle) > 360) {
				_angle = 360;
			}

			var x:Number = _center.x;
			var y:Number = _center.y;
			var n:Number = Math.ceil(Math.abs(_angle) / 45);
			var angleA:Number = _angle / n;
			angleA = angleA * Math.PI / 180;
			var startA:Number = _startAngle * Math.PI / 180;

			this.graphics.moveTo(x, y);
			this.graphics.lineTo(x + _radius * Math.cos(startA), y + _radius * Math.sin(startA));
			//圆弧
			for (var i:uint = 1; i <= n; i++) {
				startA += angleA;
				var angleMid1:Number = startA - angleA / 2;
				var bx:Number = x + _radius / Math.cos(angleA / 2) * Math.cos(angleMid1);
				var by:Number = y + _radius / Math.cos(angleA / 2) * Math.sin(angleMid1);
				var cx:Number = x + _radius * Math.cos(startA);
				var cy:Number = y + _radius * Math.sin(startA);
				this.graphics.curveTo(bx, by, cx, cy);
			}
			this.graphics.lineTo(x, y);
			this.graphics.endFill();
		}

	}
}
