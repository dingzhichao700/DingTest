package {
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	import utils.Dispatcher;

	public class PlayerControl {
		
		/**竖直方向状态：第1个数记录当前按下的键，第2个数记录上一个按下的键，上1下2*/
		private var _moveVert:Array = [0, 0];
		/**水平方向状态 同上，右3左4*/
		private var _moveHori:Array = [0, 0];
		
		private static var instance:PlayerControl;
		public static function getInstance():PlayerControl {
			instance ||= new PlayerControl();
			return instance;
		}
		
		public function PlayerControl() {
		}
		
		public function init():void {
			Dispatcher.addListener(KeyEvent.KEY_DOWN, onDown);
			Dispatcher.addListener(KeyEvent.KEY_UP, onUp);
		}
		
		public function get moveVert():Array {
			return _moveVert;
		}
		
		public function get moveHori():Array {
			return _moveHori;
		}
		
		private function onDown(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case 87: //W
				case 83: //S
				case 65: //A
				case 68: //D
					setMoveState(e.keyCode, e.type == "keyDown");
					break;
			}
		}
		
		private function onUp(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case 87: //W
				case 83: //S
				case 65: //A
				case 68: //D
					setMoveState(e.keyCode, e.type == "keyDown");
					break;
			}
		}
		
		/**
		 * 设置移动状态
		 * @param key 按键
		 * @param isDown 按键是否按下
		 */
		private function setMoveState(key:int, isDown:Boolean):void {
			if (isDown) {//按下
				switch (key) {
					case 87: //W
						if (_moveVert[0] != 1) {
							_moveVert[1] = _moveVert[0];
							_moveVert[0] = 1;
						}
						break;
					case 83: //S
						if (_moveVert[0] != 2) {
							_moveVert[1] = _moveVert[0];
							_moveVert[0] = 2;
						}
						break;
					case 65: //A
						if (_moveHori[0] != 3) {
							_moveHori[1] = _moveHori[0];
							_moveHori[0] = 3;
						}
						break;
					case 68: //D
						if (_moveHori[0] != 4) {
							_moveHori[1] = _moveHori[0];
							_moveHori[0] = 4;
						}
						break;
				}
			}
			if (!isDown) {//松开
				switch (key) {
					case 87: //W
						if (_moveVert[0] == 1) {
							_moveVert[0] = _moveVert[1];
							_moveVert[1] = 0;
						} else if (_moveVert[1] == 1) {
							_moveVert[1] = 0;
						}
					case 83: //S
						if (_moveVert[0] == 2) {
							_moveVert[0] = _moveVert[1];
							_moveVert[1] = 0;
						} else if (_moveVert[1] == 2) {
							_moveVert[1] = 0;
						}
						break;
					case 65: //A
						if (_moveHori[0] == 3) {
							_moveHori[0] = _moveHori[1];
							_moveHori[1] = 0;
						} else if (_moveHori[1] == 3) { 
							_moveHori[1] = 0;
						}
						break;
					case 68: //D
						if (_moveHori[0] == 4) {
							_moveHori[0] = _moveHori[1];
							_moveHori[1] = 0;
						} else if (_moveHori[1] == 4) {
							_moveHori[1] = 0;
						}
						break;
				}
			}
		}
		
	}
}
