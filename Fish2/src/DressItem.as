package {
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	
	import utils.LoopManager;
	import utils.ResourceManager;
	import utils.Style;

	public class DressItem extends Sprite {

		private var _type:int;
		private var _scale:Number;
		protected var con:Sprite;

		/**晃动状态 0原位， 1其他位置*/
		public var rockState:int;
		/**晃动之前的初始点*/
		private var protoPoint:Point;
		/**是否正在晃动*/
		public var rocking:Boolean;
		/**荷叶上的青蛙*/
		private var frog:FrogItem;
		
		private var img:Bitmap;

		private const CRAB_LIMIT:int = 120;
		private const SCREW_SIZE:int = 30;
		private const ROCK_SIZE:int = 5;


		/**装饰元件*/
		public function DressItem(type:int, scale:Number, rotate:int) {
			_type = type;
			_scale = scale;
			rotation = rotate;

			var filter1:DropShadowFilter = new DropShadowFilter(15, 45, 0, 0.4);
			this.filters = [filter1];

			con = new Sprite();
			addChild(con);

			init();

		/**定位红点*/
//			var sp:Sprite = new Sprite();
//			sp.graphics.beginFill(0xff0000);
//			sp.graphics.drawCircle(0, 0 ,5);
//			this.addChild(sp);
		}

		protected function init():void {
			switch (_type) {
				case 1:
				case 2:
				case 3:
				case 4:
				case 6:
					_scale = 0.6 + Math.random() * 0.2;
					break;
				case 5:
					_scale = 0.1 + Math.random() * 0.1;
					break;
			}
			_scale = Number(_scale.toFixed(2));
			_scale = scale;

			img = ResourceManager.getInstance().getImage("assets/other/leaf_" + _type + ".png", null, 0, 0, onLoaded);

			/**青蛙*/
			if (_type <= 4) {
				if (Math.random() < 0.4) {
					frog ||= new FrogItem();
					con.addChild(frog);
				}
			}
		}

		private function onLoaded():void {
			img.scaleX = img.scaleY = _scale;
			img.x = -img.width / 2;
			img.y = -img.height / 2;
			addChild(img);
		}
		
		public function get type():int {
			return _type;
		}

		public function get scale():Number {
			return _scale;
		}

		public function get rotate():int {
			return int(this.rotation);
		}

		/**根据某点晃动*/
		public function rockByPoint(point:Point):void {
			if (rocking) {
				return;
			}
			if (type == 6) {
				return;
			}
			protoPoint = new Point(this.x, this.y);
			var rockDis:int = Math.random() * ROCK_SIZE;
			var targetPoint:Point = new Point(); //设定目标点
			targetPoint.x = this.x <= point.x ? this.x - rockDis : this.x + rockDis;
			targetPoint.y = this.y <= point.y ? this.y - rockDis : this.y + rockDis;

			rocking = true;
			TweenLite.to(this, 4, {x: targetPoint.x, y: targetPoint.y, ease: Elastic.easeInOut});
			TweenLite.to(this, 4, {rotation: this.rotation + Math.random() * 50, ease: Linear.easeNone});

			LoopManager.getInstance().doDelay(200, onReturn);
		}

		/**通过鼠标坐标，设置位置偏斜*/
		public function setCrab(point:Point):void {
			var dis:int = getDis(point);
			if (dis < CRAB_LIMIT) {
				var angel:Number = getAngel(point);
				var overX:Number = Math.cos(angel) * ((CRAB_LIMIT - dis) / CRAB_LIMIT) * SCREW_SIZE;
				var overY:Number = Math.sin(angel) * ((CRAB_LIMIT - dis) / CRAB_LIMIT) * SCREW_SIZE;
				delayToCrab(new Point(overX, overY));
			} else {
				con.x = 0;
				con.y = 0;
			}
		}

		private function delayToCrab(point:Point):void {
			var targetX:Number = point.x;
			var targetY:Number = point.y;
			if (type == 6) {
				targetX = targetX / 4;
				targetY = targetY / 4;
			}
			TweenLite.to(con, 0.5, {x: targetX, y: targetY});
		}

		private function getDis(point:Point):int {
			return Math.sqrt((point.x - this.x) * (point.x - this.x) + (point.y - this.y) * (point.y - this.y));
		}

		private function getAngel(point:Point):Number {
			return Math.atan2(this.y - point.y, this.x - point.x);
		}

		/**"晃"回到晃动前的位置*/
		private function onReturn():void {
			TweenLite.to(this, 4, {x: protoPoint.x, y: protoPoint.y, ease: Elastic.easeInOut});
			TweenLite.to(this, 4, {rotation: this.rotation - Math.random() * 30, ease: Linear.easeNone});
			LoopManager.getInstance().doDelay(2, onOver);
		}

		private function onOver():void {
			rocking = false;
		}

	}
}
