package com.element {
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;

	import mx.controls.Alert;

	/**
	 * 元素代码输出
	 * @author dingzhichao
	 *
	 */
	public class ElementCodeOutput {

		/**组件声明*/
		private static var stateMentStr:String = "";
		/**组件生成*/
		private static var createStr:String = "";
		/**侦听函数*/
		private static var listenStr:String = "";
		/**最终输出*/
		private static var resultStr:String = "";
		/**侦听方法索引 入click1，click2，click3*/
		private static var listenerIndex:int = 0;
		/**Button实例名索引*/
		private static var buttonIndex:int = 0;
		/**Tabbar实例名索引*/
		private static var tabbarIndex:int = 0;
		/**CheckBox实例名索引*/
		private static var checkBoxIndex:int = 0;
		/**ComboBox实例名索引*/
		private static var comboBoxIndex:int = 0;

		public function ElementCodeOutput() {
		}

		/**输出代码至剪贴板*/
		public static function transCode():void {
			if (ElementManager.getInstance().eleData.length == 0) {
				Alert.show("请放置元素后再输出代码!", "警告");
				return;
			}
			resultStr = stateMentStr = createStr = listenStr = "";
			transferCode(ElementManager.getInstance().eleData);
		}

		private static function transferCode(arr:Array):void {
			for (var i:int = 0; i < arr.length; i++) {
				getCodeByType(arr[i]);
			}
			resultStr = stateMentStr + "\n" + createStr + "\n" + listenStr;
			/*resultStr = "private var button1:Button;\n"
			 + "button1 = ComponentUtil.createButton(\"购买\", 142, 69, 50, 28, this, click1)\n";
			 + "private function click1(e:MouseEvent):void {\n\n}";*/
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, resultStr);
			Alert.show("代码已复制到剪贴板", "提示");
		}

		/**
		 * 获取一个组件元素的代码
		 * 由3部分拼合
		 * 1、组件声明
		 * 2、组件生成
		 * 3、组件侦听函数
		 *
		 */
		private static function getCodeByType(ele:Element):void {

			/*
			* 声明部分
			* 如果元素没有实例名，则没有声明部分，如panelBg类，直接生成
			* 有实例名则声明，如："private var btn1:Button;"
			*
			*/
			if (ele.eleName != "") {
				stateMentStr += "private var " + ele.eleName + ":" + getCompoNameByType(ele.type) + ";\n";
			}

			/*
			* 生成部分
			* 如果元素有没有实例名，则只包含生成的方法，如panelBg, 直接Style.getPanelBg1(xx,xx,…);
			* 有实例名则增加实例赋值，如：btn1 = ComponentUtil.createButton(xx,xx,…);
			*
			*/
			createStr += (ele.eleName != "" ? (ele.eleName + " = ") : "") + getCreationByEle(ele) + ";\n";

			/*
			*侦听部分
			* 部分组件才有侦听函数，如Button，Tabbar
			*/
			if (needListener(ele.type)) {
				listenStr += "private function click" + listenerIndex + "(e:" + getListenType(getCompoNameByType(ele.type)) + "):void {\n\n};\n"
			}
		}

		/**组件是否需要侦听函数*/
		private static function needListener(type:String):Boolean {
			var boo:Boolean = false;
			switch (getCompoNameByType(type)) {
				case "Button":
				case "TabBar":
//				case "ComboBox":
					boo = true;
					break;
			}
			return boo;
		}

		private static function getListenType(type:String):String {
			var listenerType:String = "";
			switch (type) {
				case "Button":
					listenerType = "MouseEvent";
					break;
				case "TabBar":
					listenerType = "TabNavigationEvent";
					break;
				case "ComboBox":
					listenerType = "Event";
					break;
			}
			return listenerType;
		}

		/**
		 * 通过类型名获取组件类名
		 * e.g:
		 * button1、button2、button3 : Button
		 * tabbar1、tabbar2 : Tabbar
		 * ...
		 */
		private static function getCompoNameByType(type:String):String {
			var compoName:String = "";
			switch (type) {
				case "textField":
					compoName = "TextField";
					break;
				case "bitmap":
					compoName = "Bitmap";
					break;
				case "button1":
				case "button2":
				case "button3":
					compoName = "Button";
					break;
				case "panelBg1":
				case "panelBg2":
				case "panelBg3":
				case "panelTitleBg2":
				case "line2":
				case "txtBg2":
					compoName = "ScaleBitmap";
					break;
				case "tab1":
				case "tab2":
					compoName = "TabBar";
					break;
				case "downListUp":
					compoName = "ComboBox";
					break;
				case "checkBox":
					compoName = "CheckBox";
					break;
			}
			return compoName;
		}
		

		/**
		 * 根据元素类型生成默认实例名
		 */
		public static function getSampleNameByType(type:String):String {
			var sampleName:String = "";
			switch (getCompoNameByType(type)) {
				case "TextField":
				case "Bitmap":
				case "ScaleBitmap":
					sampleName = "";
					break;
				case "Button":
					sampleName = "btn" + ++buttonIndex;
					break;
				case "TabBar":
					sampleName = "tab" + ++tabbarIndex;
					break;
				case "ComboBox":
					sampleName = "combo" + ++comboBoxIndex;
					break;
				case "CheckBox":
					sampleName = "check" + ++checkBoxIndex;
					break;
			}
			return sampleName;
		}

		/**
		 * 获取组件的生成表达式
		 *  e.g:
		 * <element>
		 *   <commonData name="btn1" x="585" y="268" index="0" pivotX="0" pivotY="0" rotation="0"/>
		 *	 <typeData type="button1" height="28" width="60" txtContent = "按钮1"/>
		 * </element>
		 * 得到：
		 * button1 = ComponentUtil.createButton("按钮1", 585, 268, 60, 28, this, onClick);
		 * ...
		 */
		private static function getCreationByEle(ele:Element):String {
			var str:String = "";
			switch (ele.type) {
				case "textField":
					str = "ComponentUtil.createTextField(\"" + ele.data.typeData.txtContent + "\", " + ele.x + ", " + ele.y + ", Style.commonPanelLeft, " + ele.data.typeData.height + ", " + ele.data.typeData.width + ", this)";
					break;
				case "bitmap": //位图的ele.data.typeData.txtContent放的是位图资源名称，如"abc.jpg"就是"abc"
					str = "Style.getBitmap(\"" + ele.data.typeData.txtContent + "\", null, this, " + ele.x + ", " + ele.y + ");";
					break;
				case "button1":
					str = "ComponentUtil.createButton(\"" + ele.data.typeData.txtContent + "\", " + ele.x + ", " + ele.y + ", " + ele.data.typeData.height + ", " + ele.data.typeData.width + ", this, " + getListener() + ")";
					break;
				case "button2":
					str = "ComponentUtil.createButton(\"" + ele.data.typeData.txtContent + "\", " + ele.x + ", " + ele.y + ", " + ele.data.typeData.height + ", " + ele.data.typeData.width + ", this, " + getListener() + ")";
					str += ";\n" + ele.eleName + ".bgSkin = Style.getInstance().buttonSpcSkin()";
					break;
				case "button3":
					str = "ComponentUtil.createButton(\"" + ele.data.typeData.txtContent + "\", " + ele.x + ", " + ele.y + ", " + ele.data.typeData.height + ", " + ele.data.typeData.width + ", this, " + getListener() + ")";
					str += ";\n" + ele.eleName + ".bgSkin = Style.getButtonSkinRed2()";
					break;
				case "panelBg1":
					str = "Style.getPanelBg1(" + ele.data.typeData.width + ", " + ele.data.typeData.height + ", this, " + ele.x + ", " + ele.y + ")";
					break;
				case "panelBg2":
					str = "Style.getPanelBg2(" + ele.data.typeData.width + ", " + ele.data.typeData.height + ", this, " + ele.x + ", " + ele.y + ")";
					break;
				case "panelBg3":
					str = "Style.getPanelBg3(" + ele.data.typeData.width + ", " + ele.data.typeData.height + ", this, " + ele.x + ", " + ele.y + ")";
					break;
				case "panelTitleBg2":
				case "line2":
				case "txtBg2":
					str = "Style.getScaleBitmap(\"" + ele.type + "\", null, " + getScaleRectangleByType(ele.type) + ", this, " + ele.x + ", " + ele.y + "," + ele.width + ", " + ele.height + ")";
					break;
				case "tab1":
				case "tab2":
					var itemArr:Array = String(ele.data.typeData.txtContent).split(",");
					var itemStr:String = "";
					for (var i:int = 0; i < itemArr.length; i++) {
						itemStr += "[\"" + itemArr[i] + "\", " + ele.data.typeData.width + ", " + ele.data.typeData.height + "]";
						itemStr += i == (itemArr.length - 1) ? "" : ",";
					}
					str = "ComponentUtil.createTabBar(" + ele.x + ", " + ele.y + ", [" + itemStr + "], this, " + getListener() + ")";
					str += ele.type == "tab2" ? ";\n" + ele.eleName + ".direction = TabDirection.VECTICAL" : "";
					break;
				case "checkBox":
					str = "ComponentUtil.createCheckBox(\"" + ele.data.typeData.txtContent + "\", " + ele.x + ", " + ele.y + ", this)";
					break;
				case "downListUp":
					str = "ComponentUtil.createComboBox(\"label\", " + ele.x + ", " + ele.y + ", " + ele.data.typeData.width + ", " + ele.data.typeData.height + ", this)";
					break;
			}
			return str;
		}
		

		/**根据类型获取索图矩形*/
		private static function getScaleRectangleByType(type:String):String {
			var str:String = "";
			switch (type) {
				case "panelTitleBg2":
					str = "new Rectangle(84, 1, 1, 12)";
					break;
				case "line2":
					str = "new Rectangle(85, 1, 1, 1)";
					break;
				case "txtBg2":
					str = "new Rectangle(57, 10, 1, 1)";
					break;
			}
			return str;
		}

		private static function getListener():String {
			return "click" + ++listenerIndex;
		}
	}
}
