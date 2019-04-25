package {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import utils.LoopManager;
	import utils.ResourceManager;

	public class HehuaItem extends DressItem {

		private var img:Bitmap;

		private var imgBox:Sprite;

		private var _state:int;
		private var curIndex:int;
		private var delayKey:int;

		private const ANI_COF:Array = [["hehua_stay", 1], ["hehua_open", 121], ["hehua_close", 121], ["hehua_closed", 1]];

		public function HehuaItem(type:int, scale:Number, rotate:int) {
			super(type, scale, 0);
		}

		public function get state():int {
			return _state;
		}

		public function set state(value:int):void {
			_state = value;
			curIndex = 1;
		}

		override protected function init():void {
			con.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			state = 0;
			img = ResourceManager.getInstance().getImage("", con, -70, -70);
			
			this.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onOver(e:MouseEvent):void {
			if(state == 0){
				state = 2;
			}
		}
		
		private function onFrame(e:Event):void {
			var arr:Array = ANI_COF[state];
			var url:String = arr[0];
			var maxFrame:int = arr[1];
			ResourceManager.getInstance().setImageData("assets/other/" + url + "/" + curIndex + ".png", img);
			curIndex++;
			if (curIndex > maxFrame) {
				finishHandler();
			}
		}
		
		private function finishHandler():void {
			switch(state){
				case 0://打开着
					state = 0;
					break;
				case 1://打开
					state = 0;
					break;
				case 2://关闭
					state = 3;
					break;
				case 3://关闭着
					state = 3;
					if(delayKey == 0){
						delayKey = LoopManager.getInstance().doDelay(5000, reOpen);
					}
					break;
			}
		}
		
		private function reOpen():void {
			state = 1;
			delayKey = 0;
		}

	}
}
