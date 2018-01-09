package utils {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Style {

		/**微软雅黑*/
		public static const WRYH:String = "微软雅黑";
		/**黑体*/
		public static const HT:String = "黑体";
		/**宋体*/
		public static const ST:String = "宋体";

		public function Style() {
		}

		/**
		 * 获取位图
		 * @param imgName	图片名
		 * @param resName	资源名
		 * @param container	父容器
		 * @param x
		 * @param y
		 */
		public static function getBitmap(imgName:String, resName:String = "common", container:DisplayObjectContainer = null, x:int = 0, y:int = 0):Bitmap {
			if (resName == "") {
				resName = "common";
			}
			if (!ResourceManager.getInstance().hasRes(resName)) {
				trace("资源 '" + resName + "' 未加载！");
				return null;
			}
			var classBitmap:Class = ResourceManager.getInstance().getRes(resName).getDefinition(imgName) as Class;
			var bmd:BitmapData = new classBitmap();
			var bmp:Bitmap = new Bitmap(bmd);
			bmp.smoothing = true;
			if (container) {
				bmp.x = x;
				bmp.y = y;
				container.addChild(bmp);
			}
			return bmp;
		}
		
		/**
		 * 获取位图数据
		 * @param imgName	图片名
		 * @param resName	资源名
		 */
		public static function getBitmapData(imgName:String, resName:String = "common"):BitmapData {
			if (resName == "") {
				resName = "common";
			}
			if (!ResourceManager.getInstance().hasRes(resName)) {
				trace("资源 '" + resName + "' 未加载！");
				return null;
			}
			var classBitmap:Class = ResourceManager.getInstance().getRes(resName).getDefinition(imgName) as Class;
			var bmd:BitmapData = new classBitmap();
			return bmd;
		}

		/**
		 * 获取位图数字
		 * 数字图片为横向0、1、2至9的一张图片，获取后按宽度均分成10份
		 * @param numStr 需要的数字
		 * @param imgName 数字图片资源名
		 * @param resName swf资源名
		 * @param container 置入容器名
		 * @param x
		 * @param y
		 * @param gap 数字字符间隔
		 * @return
		 * e.g: Style.getNumSprite("0660", "numYellow", "", this, 100, 200);
		 *
		 */
		public static function getNumSprite(numStr:String, imgName:String, resName:String = "common", container:DisplayObjectContainer = null, x:int = 0, y:int = 0, gap:int = 22):Sprite {
			var bmp:Bitmap = getBitmap(imgName, resName);
			var sp:Sprite = new Sprite();
			for (var i:int = 0; i < numStr.length; i++) {
				var index:int = numStr.charAt(i) == "0" ? 9 : (int(numStr.charAt(i)) - 1);
				var numBmd:BitmapData = new BitmapData(bmp.width / 10, bmp.height);
				numBmd.copyPixels(bmp.bitmapData, new Rectangle(index * bmp.width / 10, 0, bmp.width / 10, bmp.height), new Point);
				var numBmp:Bitmap = new Bitmap(numBmd);
				numBmp.smoothing = true;
				numBmp.x = i * gap;
				sp.addChild(numBmp);
			}
			if (container) {
				sp.x = x;
				sp.y = y;
				container.addChild(sp);
			}
			return sp;
		}

		/**
		 * 获取加减数字图片，正数黄色，负数蓝色，带正负号
		 * @param num 数字
		 * @param container
		 * @param x
		 * @param y
		 */
		public static function getBitmapScoreChange(num:int, container:DisplayObjectContainer = null, x:int = 0, y:int = 0):Bitmap {
			var bitmap:Bitmap = new Bitmap();
			var sp:Sprite = new Sprite();
			if (num >= 0) {
				getBitmap("plusYellow", "", sp, 0, 20);
			} else {
				getBitmap("minusBlue", "", sp, 0, 30);
			}
			getNumSprite((Math.abs(num)).toString(), num >= 0 ? "numYellow1" : "numBlue1", "", sp, 40, 0, 50);
			bitmap.bitmapData = new BitmapData(sp.width, sp.height, true, 0);
			bitmap.bitmapData.draw(sp);
			if (container) {
				bitmap.x = x;
				bitmap.y = y;
				container.addChild(bitmap);
			}
			return bitmap;
		}

	/**
	 * 生成九宫格位图
	 * @param imgName 图片名
	 * @param resName 资源名
	 * @param width	     宽度
	 * @param height  高度
	 * @param rect    索图矩形
	 */
	/*public static function getScaleBitmap(imgName:String, resName:String, width:int, height:int, rect:Rectangle, container:Sprite):ScaleBitmap {
		var bitmap:ScaleBitmap = Scale9Bitmap.createScale9Bitmap(getBitmap(imgName, resName), width, height, rect);
		if (container) {
			container.addChild(bitmap);
		}
		return bitmap;
	}*/
	}
}
