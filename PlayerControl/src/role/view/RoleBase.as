package role.view {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import event.GameBus;
	
	import res.ResFacade;
	import res.vo.ResDataVo;
	
	import role.RoleState;
	import role.msg.RoleMsg;
	import role.vo.RoleVo;

	/**
	 * 基本角色
	 * @author dingzhichao
	 *
	 */
	public class RoleBase extends Sprite {

		private var _vo:RoleVo;
		private var actArr:Array;
		/**动画帧索引*/
		private var index:uint;
		/**容器*/
		private var container:Sprite;
		private var offsetX:int = 255;
		private var offsetY:int = 305;

		public function RoleBase(name:String) {
			_vo = new RoleVo(name);
			init();
		}

		/**初始化*/
		private function init():void {
			/**角色阴影*/
//			var shadow:Bitmap = UITools.getShade();
//			shadow.scaleY = 0.7;
//			shadow.x = -shadow.width/2;
//			shadow.y = -shadow.height/2;
//			this.addChild(shadow);
			container = new Sprite();
			this.addChild(container);
		}

		/**帧频事件*/
		public function onFrame():void {
			checkState();
			getBitmapByState();
			checkPostion();
			move();
		}

		/**检查状态*/
		private function checkState():void {
			/*如果当前状态与前一状态不同，将动画播放头置为0*/
			if (vo.state != vo.preState) {
				index = 0;
				vo.preState = vo.state;
			}
		}

		/**检查状态，取得对应的动作图片资源*/
		private function getBitmapByState():void {
			var state:String;
			switch (vo.state) {
				case RoleState.STAND:
					state = "stand1";
					break;
				case RoleState.RUN:
					state = "run1";
					break;
				case RoleState.ATTACK:
					state = "attack1";
					break;
				case RoleState.HURT:
					state = "hurt1";
					break;
				case RoleState.DEAD:
					state = "dead1";
					break;
				case RoleState.SIT:
					state = "sit1";
					break;
			}
			/**方向*/
			var direction:uint = vo.direction;
			if (direction == 6 || direction == 7 || direction == 8) {
				switch (vo.direction) {
					case 6:
						direction = 4;
						break;
					case 7:
						direction = 3;
						break;
					case 8:
						direction = 2;
						break;
				}
			}
			actArr = ResFacade.dataManager.getAnimeArr(vo.name, state, direction);
		}

		/**播放动画帧*/
		public function playAnime():void {
			container.removeChildren();
			if (!actArr) {
				return;
			}
			if (index == actArr.length) {
				index = 0;
			}
			var resVo:ResDataVo = ResDataVo(actArr[index]);
			var bmd:BitmapData = new BitmapData(resVo.cutArea[2] - resVo.cutArea[0], resVo.cutArea[3] - resVo.cutArea[1], true, 0);
			bmd.draw(resVo.bitmap, new Matrix(1, 0, 0, 1, -resVo.cutArea[0], -resVo.cutArea[1]), null, null, new Rectangle(0, 0, resVo.cutArea[2], resVo.cutArea[3]));
			var bitmap:Bitmap = new Bitmap(bmd);
			bitmap.y = -offsetY + resVo.cutArea[1];
			container.addChild(bitmap);
			/*检查方向*/
			if (vo.direction == 6 || vo.direction == 7 || vo.direction == 8) {
				bitmap.scaleX = -1;
				bitmap.x = offsetX - resVo.cutArea[0];
			} else {
				bitmap.scaleX = 1;
				bitmap.x = resVo.cutArea[0] - offsetX;
			}
			index++;
		}

		/**检查位置*/
		private function checkPostion():void {
			vo.position = new Point(this.x, this.y);
		}

		/**移动*/
		private function move():void {
			/*如果角色还没有目标点，或者离目标点很近时*/
			if (vo.target && Point.distance(vo.target, vo.position) <= 5) {
				/*如果角色已经处于"站立"状态，返回*/
				if (vo.state == RoleState.STAND) {
					return;
				}
				/*否则，直接将角色定位到目标点上*/
				vo.state = RoleState.STAND;
				vo.target = vo.position;
				GameBus.sendMsg(RoleMsg.ROLE_MOVE);
				GameBus.sendMsg(RoleMsg.MOVE_OVER, vo);
				return;
			}
			if (vo.state == RoleState.RUN) {
				var speedX:Number = Math.cos(this.vo.angle / 180 * Math.PI) * this.vo.speed;
				var speedY:Number = Math.sin(this.vo.angle / 180 * Math.PI) * this.vo.speed;
				this.x += speedX;
				this.y += speedY;
				/*抛出消息：角色移动*/
				GameBus.sendMsg(RoleMsg.ROLE_MOVE);
			}
		}

		public function get vo():RoleVo {
			return _vo;
		}
	}
}
