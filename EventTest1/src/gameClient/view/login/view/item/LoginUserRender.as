package gameClient.view.login.view.item
{
	import flash.display.Shape;
	
	import utils.display.button.GameButton;
	import utils.display.scrollScreen.ScrollRender;
	import utils.event.ButtonEvent;
	import utils.event.EventUtils;

	/**
	 * 登陆用户item 
	 * @author ding
	 * 
	 */	
	public class LoginUserRender extends ScrollRender
	{
		public var startBtn:GameButton;
		
		public function LoginUserRender()
		{
		}
		
		override public function create():void {
			var quad:Shape = new Shape();
			quad.graphics.beginFill(0xFFBB77);
			quad.graphics.drawRect(0, 0, 200, 80);
			quad.graphics.endFill();
			addChild(quad);
			startBtn = new GameButton(0x20C6FF, "打开", 50, 50);
			startBtn.x = 90;
			startBtn.y = 15;
			addChild(startBtn);
			EventUtils.addEventListener(startBtn, ButtonEvent.CLICK, clickHandler);
			EventUtils.addEventListener(startBtn, ButtonEvent.MOUSE_OVER, flowHandler);
		}
		
		override public function update():void {
			
		}
		
		private function clickHandler(e:ButtonEvent):void{
			trace("啊啊啊啊");
		}
		
		private function flowHandler(e:ButtonEvent):void{
		}
		
		override public function get width():Number {
			return 150;
		}
		
		override public function get height():Number {
			return 80;
		}
	}
}