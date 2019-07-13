package module {
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import utils.ResourceManager;

	public class ImageViewer extends Sprite {

		private var imgFile:Bitmap;
		private var con:Sprite;
		private var fileCon:Sprite;
		private var down_point:Point;
		private var down_posY:int;
		private var speed:Number;
		private var timer_speed:Timer;
		private var timer_flow:Timer;
		private var mask:Sprite;
		private var content_h:int;

		public function ImageViewer() {
			con = new Sprite();
			addChild(con);

			fileCon = new Sprite();
			fileCon.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			con.addChild(fileCon);

			imgFile = new Bitmap();
			fileCon.addChild(imgFile);
		}
		
		public function setMask(width:int, height:int):void {
			mask ||= new Sprite();
			mask.graphics.beginFill(0xff0000, 0.5);
			mask.graphics.drawRect(0, 0, width, height);
			con.addChild(mask);
			fileCon.mask = mask;
			content_h = height;
		}

		public function showFile(url:String):void {
			if(timer_flow){
				timer_flow.removeEventListener(TimerEvent.TIMER, onFlow);
			}
			fileCon.y = 0;
			imgFile.bitmapData = null;
			ResourceManager.getInstance().setImageData(url, imgFile, onLoad);
		}

		private function onLoad():void {
		}

		private function onDown(e:MouseEvent):void {
			TweenMax.killAll();
			timer_flow && timer_flow.stop();
			timer_speed && timer_speed.stop();

			fileCon.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			fileCon.addEventListener(MouseEvent.MOUSE_UP, onUp);
			fileCon.addEventListener(MouseEvent.MOUSE_OUT, onUp);
			down_point = new Point(mouseX, mouseY);
			down_posY = fileCon.y;

			timer_speed = new Timer(50);
			timer_speed.addEventListener(TimerEvent.TIMER, onTimer);
			timer_speed.start();
		}

		private function onTimer(e:TimerEvent):void {
			speed = (mouseY - down_point.y) / 2;
		}

		private function onMove(e:MouseEvent):void {
			var addY:int = mouseY - down_point.y;
			fileCon.y = down_posY + addY;
		}

		private function onUp(e:MouseEvent):void {
			timer_speed.stop();
			fileCon.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			fileCon.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			fileCon.removeEventListener(MouseEvent.MOUSE_OUT, onUp);
			if (imgFile.height < content_h) {
				TweenMax.to(fileCon, 500, {y: 0});
				return;
			}
			if (fileCon.y > 0) {
				TweenMax.to(fileCon, 0.5, {y: 0});
			} else if (fileCon.y + imgFile.height < content_h) {
				TweenMax.to(fileCon, 0.5, {y: content_h - imgFile.height});
			} else {
				playFlow();
			}
		}

		private function playFlow():void {
			timer_flow = new Timer(10);
			timer_flow.addEventListener(TimerEvent.TIMER, onFlow);
			timer_flow.start();
		}

		private function onFlow(e:TimerEvent):void {
			var targetY:int = fileCon.y + speed;
			if (targetY > 0) {
				fileCon.y = 0;
				timer_flow.stop();
				timer_flow.removeEventListener(TimerEvent.TIMER, onFlow);
				return;
			} else if (fileCon.y + imgFile.height < content_h) {
				fileCon.y = content_h - imgFile.height;
				timer_flow.stop();
				timer_flow.removeEventListener(TimerEvent.TIMER, onFlow);
				return;
			}
			fileCon.y = targetY;
			speed = speed * 0.95;
			if (Math.abs(speed) <= 0.1) {
				timer_flow.stop();
			}
		}

	}
}
