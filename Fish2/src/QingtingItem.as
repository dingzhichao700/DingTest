package {
	import com.greensock.TweenLite;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import utils.LoopManager;
	import utils.ResourceManager;

	public class QingtingItem extends Sprite {

		private var img:Bitmap;

		private var imgBox:Sprite;
		private var con:Sprite;

		private var _state:int;
		private var curIndex:int;
		private var hideCount:int;

		private const HIDE_MAX:int = 2;
		private const ANI_COF:Array = [["qingting", 25]];

		public function QingtingItem() {
			con = new Sprite();
			addChild(con);
			con.scaleX = con.scaleY = 0.8;

			img = ResourceManager.getInstance().getImage("", con);
			con.rotation = Math.random() * 360;

			con.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			LoopManager.getInstance().doDelay(5000, onLoop);
			
			curIndex = 1;
			this.addEventListener(Event.ENTER_FRAME, onFrame);
		}

		public function get state():int {
			return _state;
		}

		public function set state(value:int):void {
			_state = value;
		}

		private function onFrame(e:Event):void {
			var arr:Array = ANI_COF[state];
			var url:String = arr[0];
			var maxFrame:int = arr[1];
			if (curIndex > maxFrame) {
				curIndex = 1;
			}
			ResourceManager.getInstance().setImageData("assets/other/" + url + "/" + curIndex + ".png", img);
			curIndex++;
		}

		private function onLoop():void {
			TweenLite.to(img, 1, {x: 10 - Math.random() * 20});
			LoopManager.getInstance().doDelay(1000, onLoop);
		}

		private function onOver(e:MouseEvent):void {
			con.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			TweenLite.killTweensOf(img);

			if (hideCount < HIDE_MAX) {
				if (hideCount == 0) {
					TweenLite.to(img, 0.4, {x: (50 + Math.random() * 30) * (Math.random() > 0.5 ? 1 : -1)});
				}
				LoopManager.getInstance().doDelay(1500, reset);
				hideCount++;
			} else {
				TweenLite.to(img, 1, {y: -500});
				LoopManager.getInstance().doDelay(1100, onFly);
				hideCount = 0;
			}
		}

		private function onFly():void {
			TweenLite.to(img, 1, {y: -800});
			LoopManager.getInstance().doDelay(1100, onFly2);
		}

		private function onFly2():void {
			TweenLite.to(img, 1, {y: -1000, x: Math.random() * 200});
			LoopManager.getInstance().doDelay(1100, onFly3);
		}

		private function onFly3():void {
			TweenLite.to(con, 1, {alpha: 0});
			LoopManager.getInstance().doDelay(8000, init);
		}

		private function init():void {
			con.rotation = Math.random() * 360;
			img.x = 0;
			img.y = 0;
			TweenLite.to(con, 1, {y: 0, alpha: 1});
			LoopManager.getInstance().doDelay(1000, reset);
		}

		private function reset():void {
			con.addEventListener(MouseEvent.MOUSE_OVER, onOver);
		}


	}
}
