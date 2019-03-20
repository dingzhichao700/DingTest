package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	[SWF(width = 640, height = 480, backgroundColor = "0xaaaaaa", frameRate = "30")]
	public class PathCalc extends Sprite {

		/**垂涎V函数斜率k*/
		private var paramK:Number;
		/**垂涎V函数参数b*/
		private var paramB:Number;

		private var dotA:Sprite;
		private var dotB:Sprite;

		public function PathCalc() {
			dotA = new Sprite();
			dotA.graphics.beginFill(0xff0000);
			dotA.graphics.drawCircle(0, 0, 10);
			addChild(dotA);
			dotA.x = 100;
			dotA.y = 100;

			dotB = new Sprite();
			dotB.graphics.beginFill(0xff0000);
			dotB.graphics.drawCircle(0, 0, 10);
			addChild(dotB);
			dotB.x = 300;
			dotB.y = 300;

			dotA.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			dotB.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			draw();
		}

		private function onDown(e:MouseEvent):void {
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			e.currentTarget.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			e.currentTarget.addEventListener(MouseEvent.MOUSE_UP, onUp);
			(e.currentTarget as Sprite).startDrag();
		}

		private function onUp(e:MouseEvent):void {
			e.currentTarget.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			(e.currentTarget as Sprite).stopDrag();
		}

		private function onMove(e:MouseEvent):void {
			draw();
		}

		private function draw():void {
			getApeakPoints(new Point(dotA.x, dotA.y), new Point(dotB.x, dotB.y), 0.2, 50);
		}

		/**
		 * 获取垂线段端点坐标
		 * @param a A点坐标
		 * @param b B点坐标
		 * @param scale 线段AC长度相对AB长度的比例（C为垂点）
		 * @param long 垂线V的单侧长度
		 */
		private function getApeakPoints(a:Point, b:Point, scale:Number, long:int):Array {
			this.graphics.clear();
			this.graphics.lineStyle(1, 0x00ff00);
			this.graphics.moveTo(a.x, a.y);
			this.graphics.lineTo(b.x, b.y);
			this.graphics.endFill();

			/*找出垂直点*/
			var xDis:int = b.x - a.x;
			var yDis:int = b.y - a.y;
			var apeak:Point = new Point(a.x + xDis * scale, a.y + yDis * scale);
			this.graphics.beginFill(0xffff00);
			this.graphics.drawCircle(apeak.x, apeak.y, 5);
			this.graphics.endFill();

			/*计算垂线函数*/
			var angle:Number = Math.atan2(yDis, xDis) * 180 / Math.PI;
			paramK = Math.tan((angle - 90) * Math.PI / 180);
			paramB = apeak.y - paramK * apeak.x;

			var disX:Number = Math.abs(long * Math.sin(angle / 180 * Math.PI));
			trace(paramK + " " + disX);
			var p1:Point = getPoint(apeak.x - disX);
			var p2:Point = getPoint(apeak.x + disX);

			this.graphics.moveTo(p1.x, p1.y);
			this.graphics.lineTo(p2.x, p2.y);
			this.graphics.beginFill(0x0000ff);
			this.graphics.drawCircle(p1.x, p1.y, 5);
			this.graphics.drawCircle(p2.x, p2.y, 5);
			return [p1, p2];
		}

		/**获取垂线上某点*/
		private function getPoint(x:Number):Point {
			return new Point(x, paramK * x + paramB);
		}
	}
}
