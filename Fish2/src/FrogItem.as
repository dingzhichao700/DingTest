package {
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	
	import utils.Dispatcher;
	import utils.LoopManager;
	import utils.ResourceManager;
	import utils.SoundManager;

	public class FrogItem extends Sprite {

		private var img:Bitmap;

		private var _state:int;
		
		private var curIndex:int;

		private var con:Sprite;
		
		private const ANI_COF:Array = [["qingwa_stay",80],["qingwa_jump",26]];

		public function FrogItem() {
			con = new Sprite();
			con.scaleX = con.scaleY = 1.1;
			addChild(con);
			
			var filter1:DropShadowFilter = new DropShadowFilter(8, 45, 0, 0.5);
			this.filters = [filter1];

			img = ResourceManager.getInstance().getImage("", con);
			curIndex = 1;

			con.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			this.addEventListener(Event.ENTER_FRAME, onFrame);
		}

		public function get state():int {
			return _state;
		}

		public function set state(value:int):void {
			_state = value;
			curIndex = 1; //状态改变，回到第一帧
		}

		public function playJump():void {
			state = 1;
		}

		private function onFrame(e:Event):void {
			var arr:Array = ANI_COF[state];
			var url:String = arr[0];
			var maxFrame:int = arr[1];
			if(curIndex > maxFrame){
				curIndex = 1;
			}
			ResourceManager.getInstance().setImageData("assets/other/" + url + "/" + curIndex + ".png", img);
			curIndex++;
		}
		
		private function onOver(e:MouseEvent):void {
			var url:String;
			if (Math.random() < 0.5) { //小概率蛙鸣
				url = "assets/waming2.mp3";
			} else {
				url = "assets/waming3.mp3";
			}
			SoundManager.getInstance().playSound(url, false, 0.8);
			con.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			var dis:int = Math.random() * 30 + 200;
			TweenLite.to(con, 0.5, {y: -dis, onComplete: onJump});
			playJump();
		}

		private function onJump():void {
			var mainPos:Point = con.localToGlobal(new Point(30, 20));
			Dispatcher.dispatch(FishEvent.DRAW_RIPPLE, mainPos); //水波
			SoundManager.getInstance().playSound("assets/waterSound.mp3", false, 1); //入水声

			TweenLite.to(con, 0.2, {alpha: 0.5, onComplete: onJump2});
		}

		private function onJump2():void {
			TweenLite.to(con, 0.2, {alpha: 0});
			LoopManager.getInstance().doDelay(8000, onReborn);
		}

		private function onReborn():void {
			con.y = 130;
			con.alpha = 0.3;
			state = 0;
			TweenLite.to(con, 1, {y: 0, onComplete: onReborn2});
		}

		private function onReborn2():void {
			TweenLite.to(con, 0.1, {alpha: 1});
			reset();
		}

		private function reset():void {
			con.addEventListener(MouseEvent.MOUSE_OVER, onOver);
		}

	}
}
