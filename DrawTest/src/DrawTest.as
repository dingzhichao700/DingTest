package {
	import com.greensock.TweenMax;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.setTimeout;

	[SWF(frameRate = "30", backgroundColor = "0xaaaaaa", width = 720, height = 480)]
	public class DrawTest extends Sprite {

		private var target:Sprite;
		private var STEP:int = 5;
		private var speedX:int;
		private var speedY:int;
		private var effLayer:Sprite;
		private var phantomTimer:Timer;

		public function DrawTest() {
			speedX = speedY = STEP;
			effLayer = new Sprite();
			this.addChild(effLayer);
			target = new Sprite();
			target.x = 150;
			target.y = 150;
			target.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			target.addEventListener(MouseEvent.MOUSE_UP, onUp);

			for(var i:int = 0; i < 5; i++) {
				var sp:Sprite = new Sprite();
				sp.graphics.beginFill(Math.random() * 0xffffff, 0.6);
				sp.graphics.drawCircle(0, 0, Math.random() * 30 + 10);
				sp.x = 30 + Math.random() * 300;
				sp.y = 30 + Math.random() * 300;
				target.addChild(sp);
			}
			this.addChild(target);

			phantomTimer = new Timer(100, 0);
			phantomTimer.addEventListener(TimerEvent.TIMER, onFrame);
			phantomTimer.start();
//			this.addEventListener(Event.ENTER_FRAME, onFrame);
		}

		private function onDown(e:MouseEvent):void {
			target.startDrag();
		}

		private function onUp(e:MouseEvent):void {
			target.stopDrag();
		}

		private function onFrame(e:TimerEvent):void {
			/*if((target.x + target.width) >= 720) {
				speedX = -STEP;
			} else if(target.x <= 0) {
				speedX = STEP;
			}
			target.x += speedX;
			if((target.y + target.height) >= 480) {
				speedY = -STEP;
			} else if(target.y <= 0) {
				speedY = STEP;
			}
			target.y += speedY;*/

			var bmd:BitmapData = new BitmapData(target.width + 1200, target.height + 200, true, 0);
			bmd.draw(target);
			var bmp:Bitmap = new Bitmap(bmd);
			bmp.x = target.x;
			bmp.y = target.y;
			effLayer.addChild(bmp);
			tweenGhost();
		}

		private function tweenGhost():void {
			var bitmap:Bitmap = effLayer.getChildAt(0) as Bitmap;
			if(bitmap) {
				TweenMax.to(bitmap, 0.5, {alpha:0, onComplete:removeGhost});
			}
		}

		private function removeGhost():void {
			var bitmap:Bitmap = effLayer.getChildAt(0) as Bitmap;
			if(bitmap) {
				effLayer.removeChild(bitmap);
			}
		}

		private function getFramePoint(sp:DisplayObject):Point {
			var point:Point;
			return point;
		}
	}
}
