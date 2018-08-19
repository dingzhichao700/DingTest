package Role {
	import flash.display.Sprite;

	import utils.LoopManager;

	public class Enemy extends RoleView {

		private var _fanSprite:Sprite;

		public function Enemy() {
			_fanSprite ||= new Sprite();
			_fanSprite.graphics.beginFill(0xff0000, 0.15);
			_fanSprite.graphics.moveTo(0, 0);
			_fanSprite.graphics.lineTo(150, -50);
			_fanSprite.graphics.lineTo(150, 50);
			_fanSprite.graphics.lineTo(0, 0);
			this.addChildAt(_fanSprite, 0);
		}

		override public function setRes(resName:String):void {
			super.setRes(resName);
			switch (resName) {
				case "enemy1":
					STEP = 3;
					break;
				case "enemy2":
					STEP = 1.5;
					break;
			}
		}

		override protected function turnDirHandler():void {
			switch (dir) {
				case 1:
					_fanSprite.rotation = -90;
					break;
				case 3:
					_fanSprite.rotation = 0;
					break;
				case 5:
					_fanSprite.rotation = 90;
					break;
				case 7:
					_fanSprite.rotation = 180;
					break;
			}
		}

		/**侦测扇形*/
		public function get fanSprite():Sprite {
			return _fanSprite;
		}

		override protected function attack():void {
			if (resName == "enemy2") {
				play("attack", 1, dir, function test():void {
					play("stand", 1, dir);
					LoopManager.getInstance().doDelay(5000, updateParol)
				});
				var xDirAdd:int;
				var yDirAdd:int;
				if(dir == 3 || dir == 7){//横向移动的
					xDirAdd = dir == 3 ? 120 : (dir == 7 ? -120 : 0);
					yDirAdd = -10;
				} else {//纵向移动的
					yDirAdd = dir == 5 ? 20 : (dir == 1 ? -20 : 0);
				}
				BulletManager.getInstance().shotButtet(x + xDirAdd, y + yDirAdd, dir, 800);
			} else {
				play("stand", 1, dir);
				moveOverHandler();
			}
		}

	}
}
