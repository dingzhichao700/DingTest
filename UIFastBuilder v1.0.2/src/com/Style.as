package com {
	import com.component.Scale9Bitmap;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import flashx.textLayout.tlf_internal;
	
	import mx.charts.chartClasses.ChartLabel;
	import mx.controls.Label;
	import mx.core.Container;
	import mx.core.FlexTextField;
	import mx.core.TextFieldAsset;
	import mx.core.UITextField;
	
	import spark.accessibility.RichEditableTextAccImpl;
	import spark.components.Group;
	import spark.components.RichEditableText;
	import spark.components.RichText;
	import spark.components.TextArea;
	import spark.components.supportClasses.TextBase;
	import spark.filters.GlowFilter;
	import spark.primitives.BitmapImage;

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
				resName = GameConfig.COMMON;
			}
			if (!ResourceManager.getInstance().hasRes(resName)) {
				trace("资源未加载！");
				return null;
			}
			var classBitmap:Class = ResourceManager.getInstance().getRes(resName).getDefinition(imgName) as Class;
			var bmd:BitmapData = new classBitmap();
			var bmp:Bitmap = new Bitmap(bmd)
			if (container) {
				bmp.x = x;
				bmp.y = y;
				container.addChild(bmp);
			}
			return bmp;
		}

		public static function getBitmapImage(imgName:String, resName:String = "common", container:Group = null, x:int = 0, y:int = 0):BitmapImage {
			var bmp:BitmapImage = new BitmapImage();
			bmp.source = getBitmap(imgName, resName);
			if (container) {
				bmp.x = x;
				bmp.y = y;
				container.addElement(bmp);
			}
			return bmp;
		}

		/**
		 * 生成九宫格位图
		 * @param imgName 图片名
		 * @param resName 资源名
		 * @param width	     宽度
		 * @param height  高度
		 * @param rect    索图矩形
		 */
		public static function getScaleBitmap(imgName:String, resName:String, width:int, height:int, rect:Rectangle, container:Group, x:int = 0, y:int = 0):Scale9Bitmap {
			var scaleBitmap:Scale9Bitmap = Scale9Bitmap.createScale9Bitmap(getBitmap(imgName, resName), width, height, rect);
			if (container) {
				scaleBitmap.x = x;
				scaleBitmap.y = y;
				container.addElement(scaleBitmap);
			}
			return scaleBitmap;
		}

		public static function getTextField(htmlText:String, x:Number, y:Number, textFormat:TextFormat = null, w:Number = NaN, h:Number = NaN, container:Group = null):Label {
			var txt:Label = new Label();
			txt.x = x;
			txt.y = y;
			txt.width = w;
			txt.height = h;
			txt.htmlText = htmlText;
			if (container) {
				container.addElement(txt);
			}
			return txt;
		}
		
		/**
		 * 直接从路径加载图片
		 * @param url 路径
		 * @param x X
		 * @param y Y
		 * @param parent 父容器
		 * @param width 宽度
		 * @param height 高度
		 * @return
		 */
		/*public static function getImage(url:String, x:int = 0, y:int = 0, parent:DisplayObjectContainer = null, width:int = 0, height:int = 0):Bitmap {
			var bmp:Bitmap = getBitmap("wenhao", "", parent, x, y);
			ImageManager.load(bmp, url, width, height);
			return bmp;
		}*/

		/**
		 * 创建栅格矩形
		 * @param _color 		起始色
		 * @param _resterWidth 	宽度
		 * @param _resterHeight 高度
		 * @param _colorLevel 	层数
		 * @param _interval 	色比例跨度
		 * @return				Sprite
		 */
		public static function getResterRect(_color:int, _resterWidth:int, _resterHeight:int, _colorLevel:int, _interval:Number):Sprite {
			var sprite:Sprite = new Sprite();

			for (var i:int = 0; i < _colorLevel; i++) {
				sprite.graphics.beginFill(Style.resterColor(_color, (1 - i * _interval)));
				sprite.graphics.drawRect(0, (_resterHeight / _colorLevel) * i, _resterWidth, _resterHeight / _colorLevel);
				sprite.graphics.endFill();
			}
			return sprite;
		}

		/**
		 * 获取一种颜色的栅格颜色
		 * @param _color 原色
		 * @param _rate 比例(增加，例如0.1时0x302010会变成0x332211)
		 * @return	int
		 */
		public static function resterColor(_color:int, _rate:Number):int {
			var R:int = _color / (256 * 256);
			var G:int = (_color - R * 256 * 256) / 256;
			var B:int = _color - R * (256 * 256) - G * 256;
			if (_rate == 1) {
				return _color;
			}

			var finalR:int = int(R * (_rate + (R / 256) / 14));
			var finalG:int = int(G * (_rate + (G / 256) / 14));
			var finalB:int = int(B * (_rate + (B / 256) / 14));
			var settledColor:int = finalR * (256 * 256) + finalG * 256 + finalB;
			return settledColor;
		}
	}
}
