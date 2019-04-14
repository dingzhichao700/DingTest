package utils.cases {
	import flash.text.TextField;

	public class Label extends TextField {

		private var _value:String;
		private var _align:String;
		private var _color:String;
		private var _font:String = "微软雅黑";
		private var _size:int;
		private var _width:int;
		private var _height:int;

		public function Label(value:String, size:int = 20, color:String = "#ffffff", width:int = 200, height:int = 80, align = "left"):void {
			_value = value;
			_color = color;
			_width = width;
			_height = height;
			_align = align;
			_size = size;
			this.mouseEnabled = false;
			this.width = _width;
			this.height = _height;
			setContent();
		}

		public function setText(value:String):void {
			_value = value;
			setContent();
		}

		public function set align(value:String):void {
			_align = value;
			setContent();
		}

		public function set color(value:String):void {
			_color = value;
			setContent();
		}

		private function setContent():void {
			this.htmlText = "<font face='" + _font + "' size='" + _size + "' color='" + _color + "'>" + _value + "</font>";
		}

	}
}
