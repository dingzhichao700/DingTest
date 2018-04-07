package role.util {
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import role.RoleState;
	import role.view.RoleBase;

	/**
	 * 角色工具类
	 * @author dingzhichao
	 *
	 */
	public class RoleUtils {
		public function RoleUtils() {
		}

		/**角色定方向*/
		public static function orientateRole(roleBase:RoleBase):void {
			/**判断目标点*/
			if (!roleBase.vo.target || roleBase.vo.position.equals(roleBase.vo.target)) {
				roleBase.vo.state = RoleState.STAND;
			} else {
				/**目标角度*/
				var angle:Number;
				var position:Point = roleBase.vo.position;
				var target:Point = roleBase.vo.target;
				angle = Math.atan2(target.y - position.y, target.x - position.x) / Math.PI * 180;
				roleBase.vo.angle = angle;
				/*判断方向*/
				if (-112.5 < angle && angle < -67.5) {
					roleBase.vo.direction = 1;
				} else if (-67.5 < angle && angle < -22.5) {
					roleBase.vo.direction = 2;
				} else if (-22.5 < angle && angle < 22.5) {
					roleBase.vo.direction = 3;
				} else if (22.5 < angle && angle < 67.5) {
					roleBase.vo.direction = 4;
				} else if (67.5 < angle && angle < 112.5) {
					roleBase.vo.direction = 5;
				} else if (122.5 < angle && angle < 167.5) {
					roleBase.vo.direction = 6
				} else if (-167.5 < angle && angle < -122.5) {
					roleBase.vo.direction = 8;
				} else if (167.5 < angle || angle < -167.5) {
					roleBase.vo.direction = 7;
				}
				roleBase.vo.state = RoleState.RUN;
			}
		}
	}
}
