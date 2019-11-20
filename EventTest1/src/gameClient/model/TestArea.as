package gameClient.model
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	
	import gameClient.manager.layer.LayerManager;
	
	import utils.display.sprite.Quad;
	import utils.display.text.GameText;
	import utils.tools.TextTools;

	/**游戏测试*/
	public class TestArea extends Sprite
	{
		private var memoryInfo:GameText;
		
		public function TestArea()
		{
			init();
		}
		
		public function init():void {
			var rect:Quad = new Quad(100, 80, 0x222222, 0.9);
			addChild(rect);
			memoryInfo = TextTools.createTxt("内存占用：", rect.x+5, rect.y, rect.width, rect.height, 0xeef4ff, 16, 1);
			addChild(memoryInfo);
			layer.addChild(this);
			
			this.addEventListener(Event.ENTER_FRAME, frameHandler);
		}
		
		private function frameHandler(e:Event):void {
			memoryInfo.text = "内存占用：\n" + (System.totalMemory /1024/1024).toFixed(3) + "mb";
		}
	
		
		private function get layer():Sprite{
			return LayerManager.testLayer;
		}
	}
}