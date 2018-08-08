package {
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	[SWF(frameRate = "60", backgroundColor = "0xaaaaaa", width = 1920, height = 1080)]
	
	public class AmazingWorld extends Sprite {
		
		private var con:Sprite;
		
		public function AmazingWorld() {

			con = new Sprite();
			addChild(con);
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.load(new URLRequest("bg.jpg"));
		}
		
		private function onComplete(e:Event):void {
			var bmd:BitmapData = Bitmap(e.target.content).bitmapData;
			var img:Bitmap = new Bitmap(bmd);
			img.x = 300;
			img.y = 384;
			img.rotationX = -70;
			
			var img2:Bitmap = new Bitmap(bmd);
			img2.x = 300;
			img2.y = 200;
			img.rotationX = -70;
			
//			TweenMax.to(img, 0.5, {rotationX:-70});
			con.addChild(img);
		}
	}
}
