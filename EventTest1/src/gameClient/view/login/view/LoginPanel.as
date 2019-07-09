package gameClient.view.login.view
{
	import flash.geom.Rectangle;
	import flash.system.System;
	
	import gameClient.manager.saving.SavingManager;
	import gameClient.manager.window.BaseWindow;
	import gameClient.view.login.view.item.LoginUserRender;
	import gameClient.view.login.view.ui.LoginPanelUi;
	
	import utils.display.scrollScreen.ScrollScreen2;
	import utils.display.sprite.GSprite;
	import utils.event.ButtonEvent;

	/**
	 * 登陆界面 
	 * @author ding
	 * 
	 */	
	public class LoginPanel extends BaseWindow
	{
		private var view:LoginPanelUi;
		
		public function LoginPanel()
		{
			this.addChild(view = new LoginPanelUi());
			view.startBtn.addEventListener(ButtonEvent.CLICK, clickHandler);
			view.closeBtn.addEventListener(ButtonEvent.CLICK, closeHandler);
			view.testBtn.addEventListener(ButtonEvent.CLICK, testHandler);
		}
		
		override protected function open():void{
			checkPlayerInfo();	
		}
		
		private function checkPlayerInfo():void {
			SavingManager.checkSaving();
		}
		
		public function clickHandler(e:ButtonEvent):void {
//			WindowManager.openWindow(WindowName.CHARACTER_PANEL);
			view.scroll.dataSource = new Array("1", "1", "1");
		}
		
		public function closeHandler(e:ButtonEvent):void {
//			WindowManager.closeWindow(WindowName.CHARACTER_PANEL);
			view.scroll.dataSource = new Array("1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1");
		}
		
		public function testHandler(e:ButtonEvent):void {
			System.gc();
		}
	}
}