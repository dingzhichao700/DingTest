package com.component {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import spark.primitives.BitmapImage;


	/**
	 * 九宫格图片
	 * @author dingzhichao
	 *
	 */
	public class Scale9Bitmap extends BitmapImage {

		private var _bitmap:Bitmap;
		private var _width:Number;
		private var _height:Number;
		private var _rect:Rectangle;
		/**索图矩形*/
		private static var rect:Rectangle;
		/**缩放宽度*/
		private static var ScaleWidth:int;
		/**缩放高度*/
		private static var ScaleHeight:int;
		/**源图像data*/
		private static var resData:BitmapData;
		/**最终图像data*/
		private static var finalData:BitmapData;

		public function Scale9Bitmap() {
		}

		/**
		 * 生成九宫格位图
		 * @param _bitmap 源位图
		 * @param _width  缩放宽度
		 * @param _height 缩放高度
		 * @param _rect   索图矩形
		 * @return
		 */
		public static function createScale9Bitmap(_bitmap:Bitmap, _width:int, _height:int, _rect:Rectangle):Scale9Bitmap {
			var scale9Bitmap:Scale9Bitmap = new Scale9Bitmap();
			scale9Bitmap.bitmap = _bitmap;
			scale9Bitmap.rect = _rect;
			scale9Bitmap.width = _width;
			scale9Bitmap.height = _height;
			return scale9Bitmap;
		}

		/**
		 * 生成九宫格位图BitmapData
		 * @param _bitmap 源位图
		 * @param _width  缩放宽度
		 * @param _height 缩放高度
		 * @param _rect   索图矩形
		 * @return
		 */
		public static function createScale9BitmapData(_bitmap:Bitmap, _width:int, _height:int, _rect:Rectangle):BitmapData {
			rect = _rect;
			resData = _bitmap.bitmapData;
			ScaleWidth = _width - resData.width + rect.width;
			ScaleHeight = _height - resData.height + rect.height;
			finalData = new BitmapData(_width, _height, true, 0);
			createFinal();
			return finalData;
		}

		private static function createFinal():void {
			/*===左上===*/
			createScale(new Rectangle(0, 0, rect.x, rect.y), 0, 0, 0, 0);
			/*===中上===*/
			createScale(new Rectangle(rect.x, 0, rect.width, rect.y), ScaleWidth, 0, rect.x, 0);
			/*===右上===*/
			createScale(new Rectangle(rect.x + rect.width, 0, resData.width - rect.x - rect.width, rect.y), 0, 0, rect.x + ScaleWidth, 0);
			/*===左中===*/
			createScale(new Rectangle(0, rect.y, rect.x, rect.height), 0, ScaleHeight, 0, rect.y);
			/*===中中===*/
			createScale(new Rectangle(rect.x, rect.y, rect.width, rect.height), ScaleWidth, ScaleHeight, rect.x, rect.y);
			/*===右中===*/
			createScale(new Rectangle(rect.x + rect.width, rect.y, resData.width - rect.x - rect.width, rect.height), 0, ScaleHeight, rect.x + ScaleWidth, rect.y);
			/*===左下===*/
			createScale(new Rectangle(0, rect.y + rect.height, rect.x, resData.height - rect.y - rect.height), 0, 0, 0, rect.y + ScaleHeight);
			/*===中下===*/
			createScale(new Rectangle(rect.x, rect.y + rect.height, rect.width, resData.height - rect.y - rect.height), ScaleWidth, 0, rect.x, rect.y + ScaleHeight);
			/*===右下===*/
			createScale(new Rectangle(rect.x + rect.width, rect.y + rect.height, resData.width - rect.x - rect.width, resData.height - rect.y - rect.height), 0, 0, rect.x + ScaleWidth, rect.y + ScaleHeight);
		}

		/**
		 * 创建缩放bitmapData
		 * @param _rect			取图区域
		 * @param _scaleWidth 	缩放后宽度(填0则不缩放)
		 * @param _scaleHeight 	缩放后高度(填0则不缩放)
		 * @param xPos			x安置位置
		 * @param yPos			y安置位置
		 */
		private static function createScale(_rect:Rectangle, _scaleWidth:int, _scaleHeight:int, xPos:int, yPos:int):void {
			var data:BitmapData = new BitmapData(_rect.width, _rect.height, true, 0);
			data.copyPixels(resData, _rect, new Point());

			/*取得区域图像，生成bitmap，缩放后后置入sprite, 再draw一次*/
			var bitmap:Bitmap = new Bitmap(data);
			bitmap.width = _scaleWidth == 0 ? bitmap.width : _scaleWidth;
			bitmap.height = _scaleHeight == 0 ? bitmap.height : _scaleHeight;
			var sprite:Sprite = new Sprite();
			sprite.addChild(bitmap);
			data = new BitmapData(sprite.width, sprite.height, true, 0);
			data.draw(sprite);

			finalData.draw(data, new Matrix(1, 0, 0, 1, xPos, yPos));
		}

		public function set bitmap(_bitmap:Bitmap):void {
			this._bitmap = _bitmap;
		}

		public function set rect(_rect:Rectangle):void {
			this._rect = _rect;
		}

		override public function set width(value:Number):void {
			this._width = value < 1 ? 1 : value;
			if (!_bitmap || !_rect || !_height) {
				return;
			}
			this.source = createScale9BitmapData(_bitmap, _width, _height, _rect);
		}

		override public function set height(value:Number):void {
			this._height = value < 1 ? 1 : value;
			if (!_bitmap || !_rect || !_width) {
				return;
			}
			this.source = createScale9BitmapData(_bitmap, _width, _height, _rect);
		}
	}
}
