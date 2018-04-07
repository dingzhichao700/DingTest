package role.vo {
	import flash.geom.Point;

	/**
	 * 基本角色VO
	 * @author dingzhichao
	 *
	 */
	public class RoleVo {

		/**角色*/
		private var _name:String;
		/**血量*/
		private var _hp:uint;
		/**速度*/
		private var _speed:uint = 5;
		/**方向 8个方向顺时针从1到8表示*/
		private var _direction:uint = 1;
		/**状态  0站立；1奔跑；2攻击； 3受击； 4死亡； 5坐下（参考RoleState）*/
		private var _state:uint = 0;
		/**前一个状态*/
		private var _preState:uint;
		/**坐标点*/
		private var _position:Point;
		/**目标点*/
		private var _target:Point;
		/**角度*/
		private var _angle:Number;
		/**移动节点数组*/
		private var _routeArr:Array;

		public function RoleVo(mAnimeRes:String) {
			_name = mAnimeRes;
			_position = new Point();
		}

		/**角色*/
		public function set name(mName:String):void {
			_name = mName;
		}
		public function get name():String {
			return _name;
		}

		/**血量*/
		public function set hp(value:uint):void {
			_hp = value;
		}
		public function get hp():uint {
			return _hp;
		}

		/**速度*/
		public function set speed(value:uint):void {
			_speed = value;
		}
		public function get speed():uint {
			return _speed;
		}

		/**方向 8个方向顺时针从1到8表示*/
		public function set direction(value:uint):void {
			_direction = value;
		}
		public function get direction():uint {
			return _direction;
		}

		/**状态  0站立；1奔跑；2攻击； 3受击； 4死亡； 5坐下（参考RoleState）*/
		public function set state(value:uint):void {
			_state = value;
		}
		public function get state():uint {
			return _state;
		}

		/**前一个状态*/
		public function set preState(value:uint):void {
			_preState = value;
		}
		public function get preState():uint {
			return _preState;
		}

		/**坐标点*/
		public function set position(point:Point):void {
			_position = point;
		}
		public function get position():Point {
			return _position;
		}

		/**目标点*/
		public function set target(point:Point):void {
			_target = point;
		}
		public function get target():Point {
			return _target;
		}

		/**角度(对目标的偏转角度)*/
		public function set angle(value:Number):void {
			_angle = value;
		}
		public function get angle():Number {
			return _angle;
		}

		/**移动节点数组*/
		public function set routeArr(arr:Array):void {
			_routeArr = arr;
		}
		public function get routeArr():Array {
			return _routeArr;
		}
	}
}
