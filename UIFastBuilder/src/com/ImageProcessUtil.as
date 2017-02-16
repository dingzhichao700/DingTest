package com  {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import mx.core.UIComponent;

	public class ImageProcessUtil {
		public function ImageProcessUtil() {
		}

		//将显示对象转换为ByteArray
		public static function displayObjectToByteArray(target:DisplayObject):ByteArray {
			var width:int = target.width;
			var height:int = target.height;
			var bitmapData:BitmapData = displayObjectToBitmapData(target);
			var byteArr:ByteArray = bitmapData.getPixels(new Rectangle(0, 0, width, height));
			byteArr.writeShort(width);
			byteArr.writeShort(height);
			return byteArr;
		}

		//将显示对象转换为图片
		private static function displayObjectToBitmapData(target:DisplayObject):BitmapData {
			var width:int = target.width;
			var height:int = target.height;
			var bitmapData:BitmapData = new BitmapData(width, height, false, 0);
			bitmapData.draw(target);
			return bitmapData;
		}
	}
}
