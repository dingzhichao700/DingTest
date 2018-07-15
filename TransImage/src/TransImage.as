package  {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.fanflash.display.DistortSprite;
	
	/**
	 * 测试类
	 * @author www.fanflash.cn
	 */
	[SWF(frameRate = "60", backgroundColor = "0xaaaaaa", width = 1920, height = 1080)]
	
	public class TransImage extends Sprite{
		
		public function TransImage() {
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.load(new URLRequest("testImg2.png"));
		}
		
		public function onComplete(e:Event):void {
			var bmd:BitmapData = (e.target.content as Bitmap).bitmapData;
			var t:DistortSprite = new DistortSprite(bmd, true);
			t.x = 50;
			t.y =50;
			this.addChild(t);
			t.showPoints = true
			
		}
	}
}