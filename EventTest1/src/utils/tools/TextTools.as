package utils.tools
{
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import utils.display.text.GameText;

	/**
	 * 文本工具 
	 * @author ding
	 * 
	 */	
	public class TextTools
	{
		/**微软雅黑*/
		public static const WRYH:String = "微软雅黑";
		/**黑体*/
		public static const HT:String = "黑体";
		/**宋体*/
		public static const ST:String = "宋体";
		
		/**
		 * 创建文本 
		 * @param _text 文本
		 * @param _width 宽度
		 * @param _height 高度
		 * @param _x X
		 * @param _y Y
		 * @param _color 颜色值
		 * @param _size 字号
		 * @param _ttf 字体
		 * @param _bold 是否粗体
		 * @param _selectable 是否可选
		 * @return 
		 * 
		 */		
		public static function createTxt(_text:String, _x:int=0, _y:int=0, _width:int = 100, _height:int = 30, _color:Number = 0x000000, _size:int = 16, _align:int = 1, _ttf = WRYH, _bold:Boolean = false, _selectable = false):GameText {
			var content:GameText = new GameText();
			content.width = _width;
			content.height = _height;
			content.x = _x;
			content.y = _y;
			content.wordWrap = true;
			content.selectable = _selectable;
			
			var format:TextFormat = new TextFormat();
			var hAlign:String;
			var autoAlign:String;
			switch(_align){
				case 1:
					hAlign = TextFormatAlign.LEFT;
					autoAlign = TextFieldAutoSize.LEFT;
					break;
				case 2:
					hAlign = TextFormatAlign.CENTER;
					autoAlign = TextFieldAutoSize.CENTER;
					break;
				case 3:
					hAlign = TextFormatAlign.RIGHT;
					autoAlign = TextFieldAutoSize.RIGHT;
					break;
			}
			format.align = hAlign;
			format.size = _size;
			format.color = _color;
			format.font = _ttf;
			format.bold = _bold;
			content.autoSize = autoAlign;
			content.defaultTextFormat = format;
			content.text = _text;
			return content;
		}
	}
}