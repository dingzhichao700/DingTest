package {
	import flash.display.Sprite;
	import flash.system.fscommand;
	
	import util.WindowManager;
	import util.XmlManager;

	[SWF(width = 1920, height = 1080, backgroundColor = "0xffffff", frameRate = "60")]
	public class YimingTouch extends Sprite {

		public function YimingTouch() {
			fscommand("fullscreen", "true");
			WindowManager.ins.init(this.stage);
			
			var xmlList:Array = [
				GameConfig.XML_QIANYAN, 
				GameConfig.XML_SIGEBANG,
				GameConfig.XML_FILE_1,
				GameConfig.XML_FILE_2,
				GameConfig.XML_FILE_3,
				GameConfig.XML_FILE_4
			];
			XmlManager.ins.loadXml(xmlList, init);
		}
		
		public function init():void {
			MainControl.ins.openHome();
		}

	}
}
