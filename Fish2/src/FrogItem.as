package {
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import utils.Dispatcher;
	import utils.LoopManager;
	import utils.ResourceManager;
	import utils.SoundManager;

	public class FrogItem extends Sprite {

		private var img:Bitmap;
		private var con:Sprite;

		public function FrogItem() {
			con = new Sprite();
			addChild(con);

			img = ResourceManager.getInstance().getImage("assets/other/qingwa.png", con);
			con.addEventListener(MouseEvent.MOUSE_OVER, onOver);
		}

		private function onOver(e:MouseEvent):void {
			var result:Number = Math.random();
			if (result < 0.3) { //小概率蛙鸣
				SoundManager.getInstance().playSound("assets/waming.mp3", false, 0.1/*, reset*/);
			} else { //大概率跳走
				con.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
				var dis:int = Math.random() * 30 + 150;
				TweenLite.to(con, 0.5, {y: -dis, onComplete:onJump});
			}
		}

		private function onJump():void {
			var mainPos:Point = con.localToGlobal(new Point(30, 20));
			Dispatcher.dispatch(FishEvent.DRAW_RIPPLE, mainPos);//水波
			SoundManager.getInstance().playSound("assets/waterSound.mp3", false, 1); //入水声
			
			TweenLite.to(con, 0.2, {alpha:0.5, onComplete:onJump2});
		}
		
		private function onJump2():void {
			TweenLite.to(con, 0.2, {alpha:0});
			LoopManager.getInstance().doDelay(8000, onReborn);
		}
		
		private function onReborn():void {
			con.y = 130;
			con.alpha = 0.3
			TweenLite.to(con, 1, {y:0, onComplete:onReborn2});
		}
		
		private function onReborn2():void {
			TweenLite.to(con, 0.2, {alpha:1});
			reset();
		}
		
		private function reset():void {
			con.addEventListener(MouseEvent.MOUSE_OVER, onOver);
		}

	}
}
