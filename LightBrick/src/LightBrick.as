package {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.utils.Dictionary;

	[SWF(frameRate = "60", backgroundColor = "0x444444", width = 960, height = 480)]
	public class LightBrick extends Sprite {

		private var btnList:Array;
		private var count:int;
		private var color:Number = 0x5cb14d;
		private var curA:Number;
		private var GAP:Number = 0.1;
		private var STEP:Number = 0.1;
		private var filterDic:Dictionary;

		public function LightBrick() {
			init();
			this.addEventListener(Event.ENTER_FRAME, onFrame);
		}

		private function init():void {
			filterDic = new Dictionary();

			curA = 0;
			count = 1;
			btnList = [];
			for(var i:int = 0; i < 8; i++) {
				var btn:Sprite = new Sprite();
				btn.graphics.beginFill(color, 0.5);
				btn.graphics.drawRect(0, 0, 150, 100);
				btn.x = 120 + 190 * (i % 4);
				btn.y = 120 + 140 * int(i / 4);
				btn.addEventListener(MouseEvent.MOUSE_OVER, onOver);
				btn.addEventListener(MouseEvent.MOUSE_OUT, onOut);
				this.addChild(btn);
				btnList.push(btn);

				switch(i) {
					case 0:
						break;
					case 1:
						break;
				}
			}
		}

		private function onOver(e:MouseEvent):void {
			lockOn(e.currentTarget as Sprite, 1);
		}

		private function onOut(e:MouseEvent):void {
			lockOn(e.currentTarget as Sprite, 0);
		}

		private function lockOn(sp:DisplayObject, state:int):void {
			if(filterDic[sp]) {
				filterDic[sp] = state;
			} else {
				filterDic[sp] = state;
			}
		}

		private function onFrame(e:Event):void {
			for(var key:* in filterDic) {
				var list:Array = key.filters;
				if(list.length != 0) {
					for(var i:int = 0; i < list.length; i++) {
						if(list[i] is GlowFilter) {
							var glow:GlowFilter = list[i];
							glow.alpha += filterDic[key] == 1 ? STEP : -STEP;
							Sprite(key).filters = [glow];
						}
					}
				} else {
					glow = new GlowFilter(color, STEP, 15, 15, 1, 3);
					Sprite(key).filters = [glow];
				}
			}
		}
	}
}
