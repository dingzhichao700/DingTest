package com.element {
	import com.ChineseConvert;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	import flashx.textLayout.tlf_internal;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;

	import spark.components.BorderContainer;
	import spark.components.Group;
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.TextInput;
	import spark.components.supportClasses.ItemRenderer;
	import spark.core.SpriteVisualElement;

	public class ElementManager {
		private var stage:Stage; //舞台
		private var editLayer:Group; //警告层
		private var eleLayer:Group; //元素层
		private var eleLib:Dictionary; //元素库
		private var eleArr:Array; //元素库 数组（排序用）
		private var _eleData:Array; //元素层数据
		private var _currentEle:Element; //当前元素
		private var focusSprite:SpriteVisualElement; //焦点Sprite
		private var editSprite:SpriteVisualElement; //编辑Sprite
		private var tempConfig:Array;
		private var nameTxtInput:spark.components.TextInput;
		private var xTxtInput:spark.components.TextInput;
		private var yTxtInput:spark.components.TextInput;
		private var wTxtInput:spark.components.TextInput;
		private var hTxtInput:spark.components.TextInput;
		private var txtContentInput:spark.components.TextInput;
		private var indexLabel:spark.components.Label;
		private var areaStartPoint:Point;
		private var curElePos:Point;
		private var dragFunc:Function;
		private var dropFunc:Function;
		private var multiArr:Array;

		private static var _instance:ElementManager;

		public static function getInstance():ElementManager {
			_instance ||= new ElementManager();
			return _instance;
		}

		public function ElementManager() {
		}

		public function initLayer(_stage:Stage, _eleLayer:Group, _editLayer:Group, border:BorderContainer, _dragFunc:Function, _dropFunc:Function):void {
			stage = _stage;
			eleLayer = _eleLayer;
			editLayer = _editLayer;
			focusSprite = new SpriteVisualElement();
			editSprite = new SpriteVisualElement();
			editLayer.addElement(focusSprite)
			editLayer.addElement(editSprite)
			indexLabel = border.contentGroup.getChildAt(0) as spark.components.Label;
			nameTxtInput = border.contentGroup.getChildAt(1) as spark.components.TextInput;
			nameTxtInput.addEventListener(FlexEvent.ENTER, setEleName);
			xTxtInput = border.contentGroup.getChildAt(2) as spark.components.TextInput;
			yTxtInput = border.contentGroup.getChildAt(3) as spark.components.TextInput;
			wTxtInput = border.contentGroup.getChildAt(4) as spark.components.TextInput;
			wTxtInput.addEventListener(FlexEvent.ENTER, setEleSize);
			hTxtInput = border.contentGroup.getChildAt(5) as spark.components.TextInput;
			hTxtInput.addEventListener(FlexEvent.ENTER, setEleSize);
			txtContentInput = border.contentGroup.getChildAt(6) as spark.components.TextInput;
			txtContentInput.addEventListener(FlexEvent.ENTER, setTxtContent);
			_eleData ||= new Array();
			dragFunc = _dragFunc;
			dropFunc = _dropFunc;
			multiArr = [];
			stage.addEventListener(MouseEvent.CLICK, onStageClick);
		}

		private function onStageClick(e:MouseEvent):void {
//			cancelSelect();
		}

		/**开关元素显示*/
		public function showEle():void {
			eleLayer.visible = !eleLayer.visible;
		}

		/**增加元素到库*/
		public function addEleLib(arr:Array):void {
			eleLib ||= new Dictionary();
			eleArr ||= new Array();
			for (var i:uint = 0; i < arr.length; i++) {
				var obj:Object = {name:analyEleName(arr[i].nativePath), url:arr[i].nativePath};
				eleArr.push(obj);
			}
			eleArr.sort(ChineseConvert.sortByCN);
			for (var j:uint = 0; j < eleArr.length; j++) {
				eleLib[eleArr[j].name] = eleArr[j];
			}
		}

		/**元素库数据*/
		public function get eleLibData():ArrayCollection {
			var data:ArrayCollection = new ArrayCollection();
			for (var i:int = 0; i < eleArr.length; i++) {
				var item:ItemRenderer = new ItemRenderer();
				item.id = eleArr[i].name;
				item.data = eleArr[i]; //绝对路径
				data.addItem(item);
			}
			return data;
		}

		/**解析元素名称*/
		private function analyEleName(str:String):String {
			var arr:Array = str.split("\\");
			return String(arr[arr.length - 1]);
		}

		/**
		 * 加入元素
		 * @param data {baseData{elename:String,
		 * 						 pos:Point(),
		 * 						 pivot:Point(),
		 * 						 rota:int}
		 * 				typeData{type:String, 其他数据}
		 * 			   }
		 *
		 */
		public function addEle(data:Object):void {
			var ele:Element = new Element();
			ele.data = data;
			ele.addEventListener(Event.RESIZE, onAddComplete);
			ele.addEventListener(MouseEvent.MOUSE_DOWN, dragEle);
			ele.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, dragContainer);
			eleLayer.addElement(ele);
			_eleData.push(ele);
			cancelSelect();
		}

		/**
		 * 添加到舞台
		 * 通过 RESIZE事件侦听对象在舞台上的实例化，然后刷新
		 *
		 */
		private function onAddComplete(e:Event):void {
			Element(e.target).removeEventListener(Event.RESIZE, onAddComplete);
			setCurrentEle(currentEle);
		}

		/**设置元素名*/
		public function setEleName(e:Event):void {
			if (!currentEle) {
				return;
			}
			currentEle.eleName = nameTxtInput.text;
			setEle(currentEle);
		}

		/**设置文本内容*/
		public function setTxtContent(e:Event):void {
			if (!currentEle) {
				return;
			}
			currentEle.txtContent = txtContentInput.text;
			setEle(currentEle);
		}

		/**设置元素类型数据中"长"和"宽*/
		public function setEleSize(e:Event):void {
			if (!currentEle) {
				return;
			}
			var w:Number = Number(wTxtInput.text);
			var h:Number = Number(hTxtInput.text);
			if (w > 0 && h > 0) {
				currentEle.width = w;
				currentEle.height = h;
			}
		}

		/**移除元素*/
		public function removeEle():void {
			if (multiArr.length != 0) {
				for each (var ele:Element in multiArr) {
					eleLayer.removeElement(ele);
					_eleData.splice(_eleData.indexOf(ele), 1);
				}
			} else if (currentEle) {
				eleLayer.removeElement(currentEle);
				_eleData.splice(_eleData.indexOf(currentEle), 1);
			}
			cancelSelect();
		}

		/**调整元素*/
		private function setEle(ele:Element, data:Object = null):void {
			ele.data = data ? data : ele.data;
			lockOnEle();
		}

		private function dragContainer(e:MouseEvent):void {
			/*拖动容器时移除拖元素的侦听*/
			setCurrentEle(Element(e.currentTarget));
			currentEle.removeEventListener(MouseEvent.MOUSE_DOWN, dragEle);
			currentEle.addEventListener(MouseEvent.RIGHT_MOUSE_UP, dropContainer);
			dragFunc(e);
		}

		private function dropContainer(e:MouseEvent):void {
			currentEle.addEventListener(MouseEvent.MOUSE_DOWN, dragEle);
			dropFunc(e);
		}

		/**点击元素*/
		private function dragEle(e:MouseEvent):void {
			curElePos = Element(e.currentTarget).pos;
			setCurrentEle(Element(e.currentTarget));
			currentEle.removeEventListener(MouseEvent.MOUSE_DOWN, dragEle);
			currentEle.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, dragContainer);
			stage.addEventListener(MouseEvent.MOUSE_UP, dropEle);
			eleLayer.addEventListener(MouseEvent.MOUSE_MOVE, onDragMove);
			Element(e.currentTarget).alpha = 0.5;
			Element(e.currentTarget).startDrag();
		}

		/**松开元素*/
		private function dropEle(e:MouseEvent):void {
			/*停止假拖动*/
			eleLayer.removeEventListener(MouseEvent.MOUSE_MOVE, onDragMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, dropEle);
			currentEle.addEventListener(MouseEvent.MOUSE_DOWN, dragEle);
			currentEle.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, dragContainer);
			currentEle.alpha = 1;
			currentEle.stopDrag();
			/*判断拖动结果*/
			var radianDispoint:Point = getRadianDis(currentEle, currentEle.rotation);
			var targetPoint:Point = new Point(currentEle.x, currentEle.y);
			if (targetPoint) {
				if (multiArr.length != 0) {
					oppositeMoveOrCopy(curElePos, targetPoint, e.altKey ? 2 : 1); //群体拖动，群体相对移动或复制
				} else {
					setEle(currentEle, {commonData:{pos:targetPoint}}); //单个拖动，去目标点
				}
			} else {
				setEle(currentEle, {pos:curElePos, pivot:currentEle.pivot, rota:currentEle.rotation}); //回起点
			}
			setCurrentEle(currentEle);
		}

		/**
		 * 选区元素的相对移动或复制
		 * @param cur 起始点
		 * @param tar 目标点
		 * @param type 类型：1移动 2复制
		 *
		 */
		private function oppositeMoveOrCopy(cur:Point, tar:Point, type:int):void {
			var overX:int = tar.x - cur.x;
			var overY:int = tar.y - cur.y;
			if (type == 2) {
				setEle(currentEle, {commonData:{pos:cur}}); //群体相对复制时，先让被拖动的关键元素回它原点
			}
			for each (var ele:Element in multiArr) {
				if (type == 1) {
					setEle(ele, {commonData:{pos:new Point(ele.pos.x + overX, ele.pos.y + overY)}});
				} else {
					addEle({commonData:{eleName:ElementCodeOutput.getSampleNameByType(ele.type),
								pos:new Point(ele.pos.x + overX, ele.pos.y + overY),
								pivot:ele.pivot,
								rota:ele.rotation},
							typeData:ele.data.typeData});
				}
			}
		}

		private function onDragMove(e:MouseEvent):void {
			var radianDispoint:Point = getRadianDis(currentEle, currentEle.rotation);
			var point:Point = new Point(currentEle.x + currentEle.width / 2 - radianDispoint.x, currentEle.y + currentEle.height / 2 - radianDispoint.y);
		}

		/**上移当前元素 top为1即置顶，否则上移一层*/
		public function upEle(top:int = 0):void {
			if (!currentEle) {
				return;
			}
			if (top == 1) { //置顶
				eleLayer.setElementIndex(currentEle, eleLayer.numElements - 1);
			} else {
				if (eleLayer.getChildIndex(currentEle) == eleLayer.numElements - 1) {
					return;
				}
				if (eleLayer.getElementAt(eleLayer.getChildIndex(currentEle) + 1)) {
					eleLayer.swapElements(currentEle, eleLayer.getElementAt(eleLayer.getChildIndex(currentEle) + 1));
				}
			}
			setCurrentEle(currentEle);
		}

		/**下移元素 bottom为1即置底，否则下移一层*/
		public function downEle(bottom:int = 0):void {
			if (!currentEle) {
				return;
			}
			if (bottom == 1) { //置底
				eleLayer.setElementIndex(currentEle, 0);
			} else {
				if (eleLayer.getChildIndex(currentEle) == 0) {
					return;
				}
				if (eleLayer.getElementAt(eleLayer.getChildIndex(currentEle) - 1)) {
					eleLayer.swapElements(currentEle, eleLayer.getElementAt(eleLayer.getChildIndex(currentEle) - 1));
				}
			}
			setCurrentEle(currentEle);
		}

		/**方向键控制元素格子移动*/
		public function moveEle(direction:int):void {
			if (multiArr.length != 0) {
				for each (var ele:Element in multiArr) {
					moveEleByDirection(ele, direction);
				}
			} else if (currentEle) {
				moveEleByDirection(currentEle, direction);
			}
		}

		/**按方向格子移动*/
		private function moveEleByDirection(ele:Element, dir:int):void {
			var pt:Point = new Point();
			switch (dir) {
				case 37:
					pt = new Point(ele.pos.x - 1, ele.pos.y);
					break;
				case 38:
					pt = new Point(ele.pos.x, ele.pos.y - 1);
					break;
				case 39:
					pt = new Point(ele.pos.x + 1, ele.pos.y);
					break;
				case 40:
					pt = new Point(ele.pos.x, ele.pos.y + 1);
					break;
			}
			setEle(ele, {commonData:{pos:pt}});
		}

		/**
		 * 控制元素坐标偏移
		 * @param direction 方向 37-40代表上下左右四个方向， 0代表重置偏移量
		 * @param shiftKey 按下shift 移动幅度为5像素，否则为1像素
		 *
		 */
		public function pivotEle(direction:int, shiftKey:Boolean = false):void {
			var stepSize:int = shiftKey ? 5 : 1;
			if (multiArr.length != 0) {
				for each (var ele:Element in multiArr) {
					pivotEleByDirection(ele, direction, stepSize);
				}
			} else if (currentEle) {
				pivotEleByDirection(currentEle, direction, stepSize);
			}
		}

		/**按方向偏移*/
		private function pivotEleByDirection(ele:Element, dir:int, stepSize:int):void {
			switch (dir) {
				case 0:
					setEle(ele, {pivot:new Point(0, 0)}); // 按 R 重置偏移
					break;
				case 37:
					setEle(ele, {pivot:new Point(ele.pivot.x - stepSize, ele.pivot.y)});
					break;
				case 38:
					setEle(ele, {pivot:new Point(ele.pivot.x, ele.pivot.y - stepSize)});
					break;
				case 39:
					setEle(ele, {pivot:new Point(ele.pivot.x + stepSize, ele.pivot.y)});
					break;
				case 40:
					setEle(ele, {pivot:new Point(ele.pivot.x, ele.pivot.y + stepSize)});
					break;
			}
		}

		/**旋转元素 按下shift调大旋转幅度*/
		public function rotateEle(rota:int, shiftKey:Boolean = false):void {
			if (!currentEle) {
				return;
			}
			setEle(currentEle, {rota:currentEle.rotation - (shiftKey ? rota * 4 : rota)});
		}

		/**
		 * 设置元素坐标
		 * @param ele 元素
		 * @param pos 目标网格位置
		 * @param pivotPos 目标偏移量
		 * @param rota 目标偏转角度
		 */
		private function setPostion(ele:Element, _data:Object):void {
			setCurrentEle(ele);
		}

		/**获取一个元素旋转x度后的中心偏移距离，用point返回*/
		private function getRadianDis(ele:Element, rota:int):Point {
			var armLength:int = Math.sqrt(ele.width / 2 * ele.width / 2 + ele.height / 2 * ele.height / 2);
			var radian:Number = Math.atan2(ele.height, ele.width) + rota * Math.PI / 180;
			var thatW:Number = armLength * Math.cos(radian);
			var thatH:Number = armLength * Math.sin(radian);
			return new Point(ele.width / 2 - thatW, ele.height / 2 - thatH);
		}

		/**开始选区*/
		public function areaSelect():void {
			for (var i:int = 0; i < _eleData.length; i++) {
				_eleData[i].removeEventListener(MouseEvent.MOUSE_DOWN, dragEle);
				_eleData[i].removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, dragContainer);
				_eleData[i].addEventListener(MouseEvent.CLICK, addOrRidEle);
			}
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onAreaDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onAreaUp);
		}

		/**结束选区*/
		public function areaCancel():void {
			for (var i:int = 0; i < _eleData.length; i++) {
				_eleData[i].removeEventListener(MouseEvent.CLICK, addOrRidEle);
				_eleData[i].addEventListener(MouseEvent.MOUSE_DOWN, dragEle);
				_eleData[i].addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, dragContainer);
			}
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onAreaDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onAreaUp);
			onAreaUp(null);
		}

		/**选区画框侦听*/
		public function onAreaDown(e:MouseEvent):void {
			areaStartPoint = eleLayer.globalToLocal(new Point(e.stageX, e.stageY));
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onAreaMove);
		}

		public function onAreaMove(e:MouseEvent):void {
			editSprite.graphics.clear();
			editSprite.graphics.lineStyle(2, 0x00ff00);
			var point:Point = eleLayer.globalToLocal(new Point(e.stageX, e.stageY));
			var rectW:int = point.x - areaStartPoint.x;
			var rectH:int = point.y - areaStartPoint.y;
			editSprite.graphics.beginFill(0x00ff00, 0.1);
			editSprite.graphics.drawRect(areaStartPoint.x, areaStartPoint.y, rectW, rectH);
			areaHitTest();
		}

		private function onAreaUp(e:MouseEvent):void {
			editSprite.graphics.clear();
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onAreaDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onAreaUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onAreaMove);
		}

		/**选区碰撞检测*/
		private function areaHitTest():void {
			multiArr = [];
			for (var i:int = 0; i < _eleData.length; i++) {
				if (editSprite.hitTestObject(_eleData[i])) {
					var findBoo:Boolean = false;
					for (var j:int = 0; j < multiArr.length; j++) {
						if (multiArr[j] == _eleData[i]) {
							findBoo = true;
						}
					}
					if (!findBoo) {
						multiArr.push(_eleData[i]);
					}
				}
			}
			multiSelect();
		}

		/**多选元素*/
		private function multiSelect():void {
			focusSprite.graphics.clear();
			for (var i:int = 0; i < multiArr.length; i++) {
				focusSprite.graphics.lineStyle(1, 0x00ff00);
				var radianDisPoint:Point = getRadianDis(multiArr[i], Element(multiArr[i]).rotation);
				focusSprite.graphics.drawRect(multiArr[i].x - radianDisPoint.x, multiArr[i].y - radianDisPoint.y, multiArr[i].width, multiArr[i].height);
			}
		}

		/**按住ctrl点击单个元素，将该元素增加到选区数组或从中删除*/
		private function addOrRidEle(e:MouseEvent):void {
			var findBoo:Boolean = false;
			var mark:int = 0;
			for (var i:int = 0; i < multiArr.length; i++) {
				if (multiArr[i] == Element(e.currentTarget)) {
					findBoo = true;
					mark = i;
				}
			}
			if (!findBoo) {
				multiArr.push(e.currentTarget);
			} else {
				multiArr.splice(mark, 1);
			}
			multiSelect();
		}

		/**比对配置和当前库的元素差异*/
		public function compareConfigAndLib(arr:Array):void {
			tempConfig = arr;
			executeConfig(tempConfig);
		/*if (getConfigDiffList(tempConfig).length == 0) {
			executeConfig(tempConfig);
		} else {
			Alert.yesLabel = '是';
			Alert.cancelLabel = '否';
			Alert.show('缺失' + getConfigDiffList(tempConfig).length + '个库元素:\n' + getConfigDiffEle(tempConfig) + '是否应用该配置？', '加载完成', Alert.YES | Alert.CANCEL, eleLayer, closefun);
		}*/
		}

		private function closefun(e:CloseEvent):void {
			if (e.detail == 1) {
				executeConfig(tempConfig);
			}
		}

		/**获得配置与库不匹配的元素列表*/
		private function getConfigDiffList(arr:Array):Array {
			var lostArr:Array = [];
			for (var i:int = 0; i < arr.length; i++) {
				if (!eleLib || !eleLib[arr[i].name]) {
					var findBoo:Boolean = false;
					for (var j:int = 0; j < lostArr.length; j++) {
						if (arr[i].name == lostArr[j]) {
							findBoo = true;
						}
					}
					if (!findBoo) {
						lostArr.push(arr[i].name);
					}
				}
			}
			return lostArr;
		}

		/**比较一份配置和库中不匹配的元素名*/
		private function getConfigDiffEle(arr:Array):String {
			var str:String = "";
			var lostArr:Array = getConfigDiffList(arr);
			for (var k:int = 0; k < lostArr.length; k++) {
				str += lostArr[k] + "\n";
			}
			return str;
		}

		/**执行配置*/
		private function executeConfig(arr:Array):void {
			arr.sortOn("index", Array.NUMERIC);
			for (var i:int = 0; i < arr.length; i++) {
				addEle(arr[i]);
			}
		}

		/**当前选中元素*/
		private function get currentEle():Element {
			return _currentEle;
		}

		private function setCurrentEle(ele:Element):void {
			_currentEle = ele;
			lockOnEle();
		}

		/**
		 * 缩放当前元素
		 * @param size 放大还是缩小（由鼠标滚轮控制）
		 * @param dir 方向（按下ctrl为纵向，否则横向）
		 * @param bigStep 是否大幅度缩放（按下shift每次5像素，否则1像素）
		 *
		 */
		public function zoomCurrentEle(size:int, dir:Boolean, bigStep:Boolean):void {
			if (!currentEle) {
				return;
			}
			var step:Number = (size > 0 ? 1 : -1) * (bigStep ? 10 : 1);
			if (dir) {
				currentEle.height += step;
			} else {
				currentEle.width += step;
			}
			lockOnEle();
		}

		/**锁定某元素*/
		private function lockOnEle():void {
			if (!currentEle) {
				return;
			}
			var conAble:Boolean = currentEle.txtContent ? true : false;
			focusSprite.graphics.clear();
			focusSprite.graphics.lineStyle(1, 0x00ff00);
			var radianDisPoint:Point = getRadianDis(currentEle, currentEle.rotation);
			focusSprite.graphics.drawRect(currentEle.x - radianDisPoint.x, currentEle.y - radianDisPoint.y, currentEle.width, currentEle.height);
			nameTxtInput.text = currentEle.eleName;
			xTxtInput.text = currentEle.pos.x + "";
			yTxtInput.text = currentEle.pos.y + "";
			wTxtInput.text = currentEle.width + "";
			hTxtInput.text = currentEle.height + "";
			txtContentInput.text = currentEle.txtContent ? currentEle.txtContent : "";
			indexLabel.text = "Index：" + eleLayer.getElementIndex(currentEle);
			xTxtInput.focusEnabled = yTxtInput.focusEnabled = wTxtInput.focusEnabled = hTxtInput.focusEnabled = true;
		}

		/**取消选择元素*/
		public function cancelSelect():void {
			setCurrentEle(null);
			multiArr = [];
			focusSprite.graphics.clear();
			nameTxtInput.text = "";
			xTxtInput.text = "";
			yTxtInput.text = "";
			wTxtInput.text = "";
			hTxtInput.text = "";
			txtContentInput.text = "";
			indexLabel.text = "Index：";
			stage.focus = null;
			nameTxtInput.focusEnabled = xTxtInput.focusEnabled = yTxtInput.focusEnabled = wTxtInput.focusEnabled = hTxtInput.focusEnabled = false;
		}

		public function get eleData():Array {
			return _eleData;
		}
	}
}
