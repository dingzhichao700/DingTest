package com {
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import com.element.ElementManager;

	/**
	 * 键盘事件管理
	 * @author dingzhichao
	 *
	 */
	public class KeyboardManager {

		private var _stage:Stage;
		private var funcImportMap:Function;
		private var funcExportMap:Function;
		private var funcImportEle:Function;
		private var funcShowMap:Function;

		private static var _instance:KeyboardManager;

		public static function getInstance():KeyboardManager {
			_instance ||= new KeyboardManager();
			return _instance;
		}

		public function KeyboardManager() {
		}

		public function initListener(stage:Stage, funcArr:Array):void {
			_stage = stage;
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			funcImportMap = funcArr[0];
			funcExportMap = funcArr[1];
			funcImportEle = funcArr[2];
			funcShowMap = funcArr[3];
		}

		private function onKeyDown(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case 27: //ESC 取消选择
					eleManager.cancelSelect();
					break;
				case 46: //DELETE 移除元素
					eleManager.removeEle();
					break;
				case 33: //PAGE UP 上移元素
					eleManager.upEle();
					break;
				case 34: //PAGE DOWN 下移元素
					eleManager.downEle();
					break;
				case 35: //END 置底元素
					eleManager.downEle(1);
					break;
				case 36: //HOME 置顶元素
					eleManager.upEle(1);
					break;
				case 37: // ←
				case 38: // ↑
				case 39: // →
				case 40: // ↓
					if (!e.ctrlKey && !e.shiftKey) {
						eleManager.moveEle(e.keyCode); //方向键按格子移动
					} else {
						eleManager.pivotEle(e.keyCode, e.shiftKey); //ctrl + 方向键设置偏移, 按住shift每次移动5像素
					}
					break;
				case 82: // R 重置元素偏移量
					eleManager.pivotEle(0);
					break;
				case 70: // F
					if (e.altKey) {
						if (!e.ctrlKey) {
							importMap(); // alt + F 导入地图
						} else {
							importEle(); // alt + ctrl + F 导入元素
						}
					}
					break;
				case 69: // alt + E 导出地图
					if (e.altKey) {
						exportMap();
					}
					break;
				case 73: // alt + I 导入配置
					ConfigManager.getInstance().importConfig();
					break;
				case 76: // alt + L 导出配置
					ConfigManager.getInstance().exportConfig();
					break;
				/*case 49: // 1 显示地图
					showMap();
					break;
				case 51: // 3 显示元素
					eleManager.showEle();
					break;*/
				case 17: // Ctrl 选区
					eleManager.areaSelect();
					break;
			}
		}

		private function onKeyUp(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case 17: // Ctrl 选区
					eleManager.areaCancel();
					break;
			}
		}

		private function importMap():void {
			funcImportMap == null ? null : funcImportMap();
		}

		private function exportMap():void {
			funcExportMap == null ? null : funcExportMap();
		}

		private function importEle():void {
			funcImportEle == null ? null : funcImportEle();
		}

		private function showMap():void {
			funcShowMap == null ? null : funcShowMap();
		}

		/**元素管理*/
		private function get eleManager():ElementManager {
			return ElementManager.getInstance();
		}
	}
}
