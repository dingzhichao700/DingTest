package  {
	import flash.geom.Point;

	public class Bezier {
		//  =====================================  属性
		//  对外变量
		private static var p_start:Point; // 起点
		private static var p_ctrl:Point; // 贝塞尔点
		private static var p_over:Point; // 终点
		private static var step:uint; // 分割份数
		//  辅助变量
		private static var ax:int;
		private static var ay:int;
		private static var bx:int;
		private static var by:int;
		private static var A:Number;
		private static var B:Number;
		private static var C:Number;
		private static var total_length:Number; // 长度

		//  速度函数
		private static function s(t:Number):Number {
			return Math.sqrt(A * t * t + B * t + C);
		}

		//  长度函数
		private static function L(t:Number):Number {
			var temp_ctrl:Number = Math.sqrt(C + t * (B + A * t));
			var temp_over:Number = (2 * A * t * temp_ctrl + B * (temp_ctrl - Math.sqrt(C)));
			var temp3:Number = Math.log(B + 2 * Math.sqrt(A) * Math.sqrt(C));
			var temp4:Number = Math.log(B + 2 * A * t + 2 * Math.sqrt(A) * temp_ctrl);
			var temp5:Number = 2 * Math.sqrt(A) * temp_over;
			var temp6:Number = (B * B - 4 * A * C) * (temp3 - temp4);
			return (temp5 + temp6) / (8 * Math.pow(A, 1.5));
		}

		//  长度函数反函数，使用牛顿切线法求解
		private static function InvertL(t:Number, l:Number):Number {
			var t1:Number = t;
			var t2:Number;
			do {
				t2 = t1 - (L(t1) - l) / s(t1);
				if (Math.abs(t1 - t2) < 0.000001) {
					break;
				}
				t1 = t2;
			} while (true);
			return t2;
		}

		//  返回所需总步数
		public static function init($p_start:Point, $p_ctrl:Point, $p_over:Point, $speed:Number):uint {
			p_start = $p_start;
			p_ctrl = $p_ctrl;
			p_over = $p_over;
			//step = 30;
			ax = p_start.x - 2 * p_ctrl.x + p_over.x;
			ay = p_start.y - 2 * p_ctrl.y + p_over.y;
			bx = 2 * p_ctrl.x - 2 * p_start.x;
			by = 2 * p_ctrl.y - 2 * p_start.y;
			A = 4 * (ax * ax + ay * ay);
			B = 4 * (ax * bx + ay * by);
			C = bx * bx + by * by;
			//  计算长度
			total_length = L(1);
			//  计算步数
			step = Math.floor(total_length / $speed);
			if (total_length % $speed > $speed / 2) {
				step++;
			}
			return step;
		}

		// 根据指定nIndex位置获取锚点：返回坐标和角度
		public static function getAnchorPoint(nIndex:Number):Array {
			if (nIndex >= 0 && nIndex <= step) {
				var t:Number = nIndex / step;
				//  如果按照线行增长，此时对应的曲线长度
				var l:Number = t * total_length;
				//  根据L函数的反函数，求得l对应的t值
				t = InvertL(t, l);
				//  根据贝塞尔曲线函数，求得取得此时的x,y坐标
				var xx:Number = (1 - t) * (1 - t) * p_start.x + 2 * (1 - t) * t * p_ctrl.x + t * t * p_over.x;
				var yy:Number = (1 - t) * (1 - t) * p_start.y + 2 * (1 - t) * t * p_ctrl.y + t * t * p_over.y;
				//  获取切线
				var Q0:Point = new Point((1 - t) * p_start.x + t * p_ctrl.x, (1 - t) * p_start.y + t * p_ctrl.y);
				var Q1:Point = new Point((1 - t) * p_ctrl.x + t * p_over.x, (1 - t) * p_ctrl.y + t * p_over.y);
				//  计算角度
				var dx:Number = Q1.x - Q0.x;
				var dy:Number = Q1.y - Q0.y;
				var radians:Number = Math.atan2(dy, dx);
				var degrees:Number = radians * 180 / Math.PI;
				xx = int(xx * 10) / 10
				yy = int(yy * 10) / 10
				degrees = int(degrees * 10) / 10
				return [xx, yy, degrees];
			} else {
				return [];
			}
		}
	}
}
