package utils.tools.component.button {
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import utils.tools.Style;
	import utils.tools.UITools;

	/**
	 * 通用按钮 
	 * @author dingzhichao
	 * 
	 */	
	public class CommonButton extends Button {
		
		private var _label:TextField;
		private var _bg:Bitmap;
		
		public function CommonButton(label:String = "", width:int = 80, height = 48) {
			_bg = Style.getScaleBitmap("panel_1", "common", width, height, new Rectangle(20, 20, 2, 2), this);
			_label = UITools.createTxt(label, 0, 0, width, height, this, 0x000000);
		}
	}
}
