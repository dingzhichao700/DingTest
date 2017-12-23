package {
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	
	import module.MainModel;
	
	import tool.EventName;
	import tool.GameBus;
	
	import utils.Fps;
	import utils.ResourceManager;


	[SWF(frameRate = "30", backgroundColor = "0xaaaaaa", width = 640, height = 480)]
	public class ChatRoom extends Sprite {


		public function ChatRoom() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			init();
		}

		public function init():void {
			MainModel.getInstance().stage = this.stage;
			new ModuleFactory();
			if(!ResourceManager.getInstance().getRes("mainUi")) {
				ResourceManager.getInstance().loadRes("mainUi", init);
				return;
			}

			GameBus.getInstance().dispatchMsg(EventName.GAME_START);
			var fps:Fps = new Fps();
			fps.x = 70;
			this.addChild(fps);
		}
	}
}
