package util {
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import fl.controls.TextArea;

	public class Utils {
		
		public function Utils() {
		}
		
		/**
		 * 创建文本
		 * @param width 宽度
		 * @param height 高度
		 * @param text 文本
		 * @param parent 父容器
		 * @param x
		 * @param y
		 * @param fontSize 字号
		 * @param color 字色
		 * @param wrap 是否自动换行
		 */
		public static function createText(width:int, height:int, text:String = "", parent:DisplayObjectContainer = null, x:int = 0, y:int = 0, fontSize:int = 20, color:int = 0x000000, wrap:Boolean = true):TextField {
			var txt:TextField = new TextField;
			
			var format:TextFormat = new TextFormat();
			format.font = "微软雅黑";
			format.size = fontSize;
			format.color = color;
			txt.defaultTextFormat =  format;
			txt.text = text;
			txt.width = width;
			txt.height = height;
			txt.wordWrap = wrap;
			if (parent) {
				parent.addChild(txt);
				txt.x = x;
				txt.y = y;
			}
			return txt;
		}
		
		/**
		 * 创建文本区域
		 * @param width 宽度
		 * @param height 高度
		 * @param text 文本
		 * @param parent 父容器
		 * @param x
		 * @param y
		 * @param fontSize 字号
		 * @param color 字色
		 */
		public static function createTextArea(width:int, height:int, text:String = "", parent:DisplayObjectContainer = null, x:int = 0, y:int = 0, fontSize:int = 20, color:int = 0x000000):TextArea {
			var txt:TextArea = new TextArea;
			
			var format:TextFormat = new TextFormat();
			format.font = "微软雅黑";
			format.size = fontSize;
			format.color = color;
			txt.setStyle("textFormat", format);
			txt.setStyle("borderColor","0xff0000");//下 
			txt.setStyle("highlightColor","0xff0000");//上 
			txt.setStyle("color","0xff0000");//字 
			txt.setStyle("shadowColor","0xff0000");//下 
			txt.setStyle("borderCapColor","0xff0000");//左右外 
			txt.setStyle("shadowCapColor","0xff0000");//左右内 
			txt.setStyle("buttonColor", "0xffffff"); //顶部 （PS:这个是我补充的)
			
			txt.htmlText = text;
			txt.width = width;
			txt.height = height;
			txt.editable = false;
			if (parent) {
				parent.addChild(txt);
				txt.x = x;
				txt.y = y;
			}
			return txt;
		}
	}
}
