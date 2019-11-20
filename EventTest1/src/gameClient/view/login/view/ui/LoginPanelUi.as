package gameClient.view.login.view.ui
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextFieldType;
	
	import gameClient.manager.GameManager;
	import gameClient.view.login.view.item.LoginUserRender;
	
	import utils.display.button.GameButton;
	import utils.display.scrollScreen.ScrollScreen2;
	import utils.display.sprite.GSprite;
	import utils.display.text.GameText;
	import utils.tools.TextTools;

	public class LoginPanelUi extends Sprite
	{
		public var startBtn:GameButton;
		public var closeBtn:GameButton;
		public var testBtn:GameButton;
		public var scroll:ScrollScreen2;
		public var welcome:GameText;
		public var container:GSprite;
		
		public function LoginPanelUi()
		{
			var rect2:Sprite = new Sprite();
			rect2.graphics.beginFill(0xaa33CC);
			rect2.graphics.drawRect(20, 20, GameManager.viewRect.width-40, GameManager.viewRect.height-40);
			addChild(rect2);
			
			var rect:Sprite = new Sprite();
			rect.graphics.beginFill(0x00FF00);
			rect.graphics.drawRect(0, 0, 200, 40);
			addChild(rect);
			rect.x = 780/2 - rect.width/2;
			rect.y = 220;
			
			welcome = TextTools.createTxt("Enter your name", 0, 0, 200, 30, 0x000000, 24, 2, TextTools.WRYH, false);
			welcome.restrict = "A-Z a-z 0-9";
			welcome.type = TextFieldType.INPUT;
			welcome.limit = 10;
			rect.addChild(welcome);
			
			startBtn = new GameButton(0xFF9246, "打 开", 180, 80, 3, 28);
			addChild(startBtn);
			startBtn.x = 100;
			startBtn.y = 250;
			closeBtn = new GameButton(0xffa820, "关 闭", 80, 80, 4, 20);
			addChild(closeBtn);
			closeBtn.x = 100;
			closeBtn.y = 360;
			testBtn = new GameButton(0xFF9246, "测   试", 350, 160, 5, 40);
			addChild(testBtn);
			testBtn.x = 70;
			testBtn.y = 50;
			
			container = new GSprite();
			addChild(container);
			
			scroll = new ScrollScreen2();
			scroll.area = new Rectangle(0, 0, 220, 350);
			scroll.verticalGap = 5;
			scroll.scrollRender = LoginUserRender;
			scroll.x = 520;
			scroll.y = 50;
			scroll.dataSource = new Array("1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1");
			container.addChild(scroll);
		}
	}
}