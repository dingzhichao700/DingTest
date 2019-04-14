package {
	import com.greensock.TweenLite;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import utils.LoopManager;
	import utils.ResourceManager;

	public class QingtingItem extends Sprite {

		private var img:Bitmap;
		private var con:Sprite;
		private var hideCount:int;

		private const HIDE_MAX:int = 2;

		public function QingtingItem() {
			con = new Sprite();
			addChild(con);

			img = ResourceManager.getInstance().getImage("assets/other/qingting.png", con);
			con.rotation = Math.random() * 360;

			con.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			LoopManager.getInstance().doDelay(5000, onLoop);
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
					TweenLite.to(img, 1, {x: 30 * (Math.random() > 0.5 ? 1 : -1)});
				} else if (hideCount == 1) {
					TweenLite.to(img, 1, {x: 0});
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
			TweenLite.to(img, 1, {y: -1000, x:Math.random()*200});
			LoopManager.getInstance().doDelay(1100, onFly3);
		}
			
		private function onFly3():void {
			TweenLite.to(con, 1, {alpha: 0});
			LoopManager.getInstance().doDelay(8000, init);
		}
		
		private function init():void {
			con.rotation = Math.random() * 360;
			img.x = 0;
			img.y = 400;
			TweenLite.to(con, 1, {y: 0, alpha: 1});
			LoopManager.getInstance().doDelay(1000, reset);
		}

		private function reset():void {
			con.addEventListener(MouseEvent.MOUSE_OVER, onOver);
		}


	}
}
