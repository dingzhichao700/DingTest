package {
	import flash.display.Sprite;
	import flash.system.fscommand;
	import flash.utils.getTimer;
	
	import util.WindowManager;
	
	import utils.ResourceManager;

	[SWF(width = 1920, height = 1080, backgroundColor = "0xffffff", frameRate = "60")]
	public class YimingTouch extends Sprite {

		private const IMAGE_LIST:Array = [
			"assets/bg_panel2.png", 
			"assets/index00.jpg", 
			"assets/index01.jpg", 
			"assets/index1.jpg", 
			"assets/index2.jpg", 
			"assets/index3.jpg", 
			"assets/index4.jpg", 
			"assets/index5.jpg",
			"assets/pic/dangjian/1.jpg",
			"assets/pic/falv/1.jpg",
			"assets/pic/falv/2.jpg",
			"assets/pic/falv/3.jpg",
			"assets/pic/fazhan/1.jpg",
			"assets/pic/fazhan/2.jpg",
			"assets/pic/fazhan/3.jpg",
			"assets/pic/fazhan/4.jpg",
			"assets/pic/guanli/1.jpg",
			"assets/pic/guanli/2.jpg",
			"assets/pic/guanli/3.jpg",
			"assets/pic/jieyou/1.jpg",
			"assets/pic/jieyou/2.jpg",
			"assets/pic/jieyou/3.jpg",
			"assets/pic/jieyou/4.jpg",
			"assets/pic/jieyou/5.jpg",
			"assets/pic/jieyou/6.jpg",
			"assets/pic/jingji/1.jpg",
			"assets/pic/lianxi/1.jpg",
			"assets/pic/lianxi/2.jpg",
			"assets/pic/lingdao/1.png",
			"assets/pic/lingdao/2.jpg",
			"assets/pic/lingdao/3.jpg",
			"assets/pic/lingdao/4.jpg",
			"assets/pic/lingdao/5.jpg",
			"assets/pic/lingdao/6.jpg",
			"assets/pic/ronghe/1.jpg",
			"assets/pic/ronghe/2.jpg",
			"assets/pic/ronghe/3.jpg",
			"assets/pic/ronghe/4.jpg",
			"assets/pic/ronghe/5.jpg",
			"assets/pic/ronghe/6.jpg",
			"assets/pic/ronghe/7.jpg",
			"assets/pic/ronghe/8.jpg",
			"assets/pic/ronghe/9.jpg",
			"assets/pic/sanxia/1.jpg",
			"assets/pic/sanxia/2.jpg",
			"assets/pic/sanxia/3.jpg",
			"assets/pic/sanxia/4.jpg",
			"assets/pic/sanxia/5.jpg",
			"assets/pic/sanxia/6.jpg",
			"assets/pic/sanxia/7.jpg",
			"assets/pic/sanxia/8.jpg",
			"assets/pic/sanxia/9.jpg",
			"assets/pic/sanxia/10.jpg",
			"assets/pic/sanxia/11.jpg",
			"assets/pic/sanxia/12.jpg",
		];
		private var load_index:int;
		private var loadList:Array;
		private var load_startTime:Number;

		public function YimingTouch() {
			fscommand("fullscreen", "true");
			WindowManager.ins.init(this.stage);

			/*var xmlList:Array = [
				GameConfig.XML_QIANYAN,
				GameConfig.XML_SIGEBANG,
				GameConfig.XML_FILE_1,
				GameConfig.XML_FILE_2,
				GameConfig.XML_FILE_3,
				GameConfig.XML_FILE_4
			];
			XmlManager.ins.loadXml(xmlList, init);*/
			load_index = 0;
			load_startTime = getTimer();
			preloadImage();
		}

		private function preloadImage():void {
			trace("load process:" + Math.floor((load_index / IMAGE_LIST.length) * 100) + "%");
			if (load_index == IMAGE_LIST.length) {
				trace("load complete, cost:" + (getTimer()-load_startTime)/1000 + " sec");
				init();
				return;
			} else {
				var url:String = IMAGE_LIST[load_index];
				ResourceManager.getInstance().getImage(url, null, 0, 0, preloadImage);
				load_index++;
			}
		}

		private function init():void {
			MainControl.ins.openHome();
		}

	}
}
