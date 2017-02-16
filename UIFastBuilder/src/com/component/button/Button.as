package utils.tools.component.button {
	import flash.events.MouseEvent;
	import flash.utils.getTimer;

	import utils.tools.component.sprite.GSprite;
	import utils.event.ButtonEvent;
	import utils.event.EventUtils;

	/**
	 * 按钮基类 
	 * @author dingzhichao
	 * 
	 */	
	public class Button extends GSprite {
		/**相应时间限制(毫秒)*/
		private const reactLimit:int = 300;
		/**按下计时*/
		private var downTimer:int;
		private var _touchAble:Boolean;

		public function Button() {
			EventUtils.addEventListener(this, MouseEvent.MOUSE_OVER, onButtonHandler);
			EventUtils.addEventListener(this, MouseEvent.MOUSE_OUT, onButtonHandler);
			EventUtils.addEventListener(this, MouseEvent.MOUSE_DOWN, onButtonHandler);
			EventUtils.addEventListener(this, MouseEvent.MOUSE_UP, onButtonHandler);
			_touchAble = true;
		}

		/**按下或弹起*/
		private function onButtonHandler(e:MouseEvent):void {
			if (!_touchAble) {
				return;
			}
			switch (e.type) {
				case MouseEvent.MOUSE_OVER:
					break;
				case MouseEvent.MOUSE_OUT:
					break;
				case MouseEvent.MOUSE_DOWN:
					dispatchEvent(new ButtonEvent(ButtonEvent.MOUSE_DOWN));
					downTimer = getTimer();
					break;
				case MouseEvent.MOUSE_UP:
					if ((getTimer() - downTimer) < reactLimit) {
						dispatchEvent(new ButtonEvent(ButtonEvent.CLICK));
					}
					break;
			}
		}

		public function set touchAble(value:Boolean):void {
			_touchAble = value;
		}

		public function get touchAble():Boolean {
			return _touchAble;
		}

		override public function dispose():void {
			super.dispose();
		}
	}
}
