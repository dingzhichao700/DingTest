package com.element {

	import com.GameConfig;
	import com.Style;
	
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Label;
	
	import spark.components.supportClasses.ItemRenderer;
	import spark.primitives.Rect;

	/**
	 * 元素生成类
	 * @author dingzhichao
	 *
	 */
	public class ElementGenerator {

		private static var editEle:Element;

		private static var _eleConfig:ArrayCollection;

		private static const arr:Array = [["文本域", {type:"textField", width:120, height:28, txtContent:"请输入文本"}],
			["位图", {type:"bitmap", width:140, height:110, txtContent:""}],
			["位图组件panelTitleBg2", {type:"panelTitleBg2", width:202, height:14}],
			["位图组件line2", {type:"line2", width:161, height:9}],
			["位图组件txtBg2", {type:"txtBg2", width:122, height:26}],
			["下拉列表comboBox", {type:"downListUp", width:105, height:25, txtContent:"下拉选项1,下拉选项2"}],
			["勾选项checkBox", {type:"checkBox", width:100, height:20, txtContent:"勾选项文本"}],
			["按钮1", {type:"button1", width:60, height:28, txtContent:"按钮1"}], 
			["按钮2", {type:"button2", width:75, height:35, txtContent:"按钮2"}],
			["按钮3", {type:"button3", width:98, height:33, txtContent:"按钮3"}],
			["背景1", {type:"panelBg1", width:100, height:100}],
			["背景2", {type:"panelBg2", width:100, height:100}],
			["背景3", {type:"panelBg3", width:100, height:100}],
			["切换标签1", {type:"tab1", width:70, height:25, txtContent:"标签1,标签2"}],
			["切换标签2", {type:"tab2", width:82, height:27, txtContent:"标签1,标签2"}]];

		public function ElementGenerator() {
		}

		/**UI元素配置*/
		public static function get eleConfig():ArrayCollection {
			if (!_eleConfig) {
				_eleConfig = new ArrayCollection();
				for (var i:int = 0; i < arr.length; i++) {
					var item:ItemRenderer = new ItemRenderer();
					item.id = arr[i][0];
					item.data = arr[i][1]; //资源名，参照GameConfig.COMMON
					_eleConfig.addItem(item);
				}
			}
			return _eleConfig;
		}


		/**
		 * 设置元素的"类型数据"typeData
		 * @param ele 元素对象
		 * @param data 类型数据(必须备齐生成元素的必要类型"属性")
		 *
		 */
		public static function generateByTypeData(ele:Element, data:Object):void {
			editEle = ele;
			editEle.removeAllElements();
			switch (data.type) {
				case "textField": /*文本域*/
					setTextField(data);
					break;
				case "bitmap": /*位图*/
					setBitmap(data);
					break;
				case "panelTitleBg2":/*一些常见九宫格位图*/
				case "txtBg2":
				case "line2":
					setNormalScaleBitmap(data);
					break;
				case "button1": /*按钮*/
				case "button2":
				case "button3":
					setButton(data);
					break;
				case "panelBg1": /*九宫格图的窗口背景*/
				case "panelBg2":
				case "panelBg3":
					setPanelBg(data);
					break;
				case "tab1": /*切换标签*/
				case "tab2":
					setTabbar(data);
					break;
				case "downListUp": /*下拉列表*/
					setComboBox(data);
					break;
				case "checkBox": /*勾选项*/
					setCheckBox(data);
					break;
			}
		}

		/**文本类*/
		private static function setTextField(data:Object):void {
			Style.getTextField("<p valign='bottom' align='left'><font filter='#000000' color='#ffffff' face='Arial' size='12'>" + data.txtContent + "</font></p>", 0, data.height / 2 - 11, null, data.width, data.height, editEle);
		}

		/**模拟位图类*/
		private static function setBitmap(data:Object):void {
			var rect:Rectangle = new Rectangle(2, 2, 130, 75);
			Style.getScaleBitmap(data.type, GameConfig.COMMON, data.width, data.height, rect, editEle);
		}
		
		/**九宫格位图类 一些常见的九宫格位图，有不同的索图矩形，注意要和*/
		private static function setNormalScaleBitmap(data:Object):void {
			var rect:Rectangle;
			switch (data.type) {
				case "panelTitleBg2":
					rect = new Rectangle(84, 1, 1, 12);
					break;
				case "line2":
					rect = new Rectangle(85, 1, 1, 1);
					break;
				case "txtBg2":
					rect = new Rectangle(57, 10, 1, 1);
					break;
			}
			Style.getScaleBitmap(data.type, GameConfig.COMMON, data.width, data.height, rect, editEle);
		}

		/**按钮类*/
		private static function setButton(data:Object):void {
			var rect:Rectangle;
			switch (data.type) {
				case "button1":
					rect = new Rectangle(32, 12, 1, 1);
					break;
				case "button2":
					rect = new Rectangle(35, 15, 1, 1);
					break;
				case "button3":
					rect = new Rectangle(45, 17, 1, 1);
					break;
			}
			Style.getScaleBitmap(data.type, GameConfig.COMMON, data.width, data.height, rect, editEle);
			var label:Label = Style.getTextField("<p vertical-align='center' align='center'><font filter='#000000' color='#ffffff' face='Arial' size='12'>" + data.txtContent + "</font></p>", 0, data.height / 2 - 11, null, data.width, data.height, editEle);
			label.filters = [new GlowFilter(0x320c0c, 1, 2, 2, 5)];
		}

		/**标签页类*/
		private static function setTabbar(data:Object):void {
			var itemArr:Array = String(data.txtContent).split(",");
			var rect:Rectangle;
			switch (data.type) {
				case "tab1":
					rect = new Rectangle(8, 8, 40, 15);
					for (var i:int = 0; i < itemArr.length; i++) {
						Style.getScaleBitmap(data.type, GameConfig.COMMON, data.width, data.height, rect, editEle, data.width * i + 1);
						var label1:Label = Style.getTextField("<p vertical-align='center' align='center'><font filter='#000000' color='#ffffff' face='Arial' size='12'>" + itemArr[i] + "</font></p>", data.width * i + 1, 3, null, data.width, data.height, editEle);
						label1.filters = [new GlowFilter(0x320c0c, 1, 2, 2, 5)];
					}
					break;
				case "tab2":
					rect = new Rectangle(20, 10, 40, 10);
					for (var j:int = 0; j < itemArr.length; j++) {
						Style.getScaleBitmap(data.type, GameConfig.COMMON, data.width, data.height, rect, editEle, 0, data.height * j + 1);
						var label2:Label = Style.getTextField("<p vertical-align='center' align='center'><font filter='#000000' color='#ffffff' face='Arial' size='12'>" + itemArr[j] + "</font></p>", 0, 3 + data.height * j + 1, null, data.width, data.height, editEle);
						label2.filters = [new GlowFilter(0x320c0c, 1, 2, 2, 5)];
					}
					break;
			}
		}
		
		/**下拉列表类*/
		private static function setComboBox(data:Object):void {
			Style.getScaleBitmap("downListBg", GameConfig.COMMON, data.width, data.height, new Rectangle(5, 10, 1, 1), editEle);
			Style.getBitmapImage("downListUp", GameConfig.COMMON, editEle, data.width-22, 3);
			var itemRender:String = String(data.txtContent).split(",")[0];
			var label:Label = Style.getTextField("<p align='left'><font filter='#000000' color='#fdeab9' face='Arial' size='12'>" + itemRender + "</font></p>", 3, data.height / 2 - 11, null, data.width, data.height, editEle);
		}
		
		/**勾选项*/
		private static function setCheckBox(data:Object):void {
			Style.getBitmapImage("checkBox", GameConfig.COMMON, editEle, 1, 2);
			var label:Label = Style.getTextField("<p align='left'><font filter='#000000' color='#ffffff' face='Arial' size='12'>" + data.txtContent + "</font></p>", 23, 0, null, data.width - 20, data.height-2, editEle);
			label.filters = [new GlowFilter(0x320c0c, 1, 2, 2, 5)];
		}

		/**窗口背景类*/
		private static function setPanelBg(data:Object):void {
			Style.getScaleBitmap(data.type, GameConfig.COMMON, data.width, data.height, new Rectangle(8, 8, 1, 1), editEle);
		}
	}
}
