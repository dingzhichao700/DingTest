package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.fscommand;
	
	import gameClient.model.GameStart;
	
	[SWF(width = "780",height = "480",backgroundColor = "0xFFFFFF",frameRate = "60")]
	/**
	 * 游戏测试1
	 */	
	public class GameTest1 extends Sprite
	{
		public function GameTest1()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var gameStart:GameStart = new GameStart(this);
			fscommand("allowscale", "false"); 
//			fscommand("showmenu", "false"); 
			stage.scaleMode = "noScale";
		}
	}
} 
