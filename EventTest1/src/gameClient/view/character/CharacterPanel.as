package gameClient.view.character
{
	import flash.display.Sprite;
	
	import gameClient.manager.window.BaseWindow;

	/**
	 * 角色界面 
	 * @author ding
	 * 
	 */	
	public class CharacterPanel extends BaseWindow
	{
		public function CharacterPanel()
		{
			var rect2:Sprite = new Sprite();
			rect2.graphics.beginFill(0xCCDDFF);
			rect2.graphics.drawRect(30, 30, stageWidth/2 - 20, stageHeight-60);
			addChild(rect2);
		}
	}
}