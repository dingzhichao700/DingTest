package {
	import com.greensock.TweenLite;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;

	import utils.EasyUtils;
	import utils.LoopManager;
	import utils.ResourceManager;

	public class FishItem extends Sprite {

		private var con:Sprite;

		/**类型*/
		private var type:int;
		/**方向*/
		private var direction:int;
		private var _speed:int;
		/**最大帧数*/
		private var maxIndex:int;
		/**当前帧*/
		private var curIndex:int;
		private var _shocked:int;
		private var imgFish:Bitmap;

		/**
		 * @param type 鱼类型 01~16
		 * @param maxNum 最大帧数量 15~32不等
		 */
		public function FishItem($type:int, $maxIndex:int) {
			type = $type;
			maxIndex = $maxIndex;
			this.graphics.drawCircle(0, 0, 10);

			con = new Sprite();
			addChild(con);
			imgFish = ResourceManager.getInstance().getImage("assets/fish/" + /*EasyUtils.rechargeNumByStr(type)*/type + "_1.png", con);
			imgFish.rotation = 90;
			imgFish.x = 275;
			imgFish.y = -275;
			curIndex = 1;
			speed = normalSpeed;

			var shadowFilter:DropShadowFilter = new DropShadowFilter(5, 45, 0, 0.6);
			this.filters = [shadowFilter];
			this.addEventListener(Event.ENTER_FRAME, onFrame);
			
//			var sp:Sprite = new Sprite();
//			sp.graphics.beginFill(0xff0000);
//			sp.graphics.drawCircle(0, 0 ,5);
//			this.addChild(sp);
		}

		/**是否受惊状态 0不是 1 是*/
		public function get shocked():int {
			return _shocked;
		}
		
		/**初始速度，根据鱼虾类型各有不同*/
		private function get normalSpeed():int {
			return type == 7 ? 1 : 5;
		}

		public function set shocked(value:int):void {
			_shocked = value;
			if (_shocked == 1) {
				LoopManager.getInstance().doDelay(2000, recoverFromShock);
			}
		}

		/**恢复状态与速度*/
		public function recover():void {
			this.rotation = Math.random() * 360;
			speed = normalSpeed;
			shocked = 0;
		}

		/**从受惊状态恢复*/
		public function recoverFromShock():void {
			TweenLite.to(this, 2, {rotation: rotation + Math.random() * 90});
			speed = normalSpeed;
			shocked = 0;
		}

		/**速度*/
		public function get speed():int {
			return _speed;
		}

		public function set speed(value:int):void {
			_speed = value;
		}

		private function onFrame(e:Event):void {
			curIndex = curIndex++ < maxIndex ? curIndex++ : 1;
			var url:String = "assets/fish/" + type + "_" + curIndex + ".png";
			ResourceManager.getInstance().setImageData(url, imgFish);
		}
	}
}
