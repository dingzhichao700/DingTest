package utils.tools.component {
	import flash.events.TextEvent;
	import flash.text.TextField;

	public class GameText extends TextField {
		
		private var _limit:int = 20;

		public function GameText() {
			this.addEventListener(TextEvent.TEXT_INPUT, onInputHandler);
		}

		public function set touchAble(value:Boolean):void {
			this.selectable = value;
		}

		override public function set type(value:String):void {
			super.type = value;
			this.selectable = true;
		}

		/**长度限制*/
		public function set limit(value:int):void {
			_limit = value;
		}

		public function onInputHandler(e:TextEvent):void {
			if (this.text.length > _limit) {
				this.text = this.text.slice(0, _limit);
			}
		}
	}
}
