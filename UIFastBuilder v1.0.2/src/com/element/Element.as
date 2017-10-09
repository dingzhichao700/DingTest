package com.element {
	import flash.geom.Point;
	
	import spark.components.Group;
	import spark.components.Image;
	import spark.primitives.*;

	/**
	 * 元素基类
	 * @author dingzhichao
	 *
	 */
	public class Element extends Group {

		/**元素名(作为实例名)*/
		private var _eleName:String;
		/**网格坐标点*/
		private var _pos:Point;
		/**坐标偏移量*/
		private var _pivot:Point;
		/**索引*/
		private var _index:int;
		/**角度*/
		private var _rota:int;
		/**类型数据*/
		private var _typeData:Object;

		public function Element() {
		}

		public function set data(_data:Object):void {
			if (_data == null) {
				return;
			}
			if (_data.hasOwnProperty("commonData")) {
				setCommonData(_data.commonData);
			}
			if (_data.hasOwnProperty("typeData")) {
				setTypeData(_data.typeData);
				_typeData = _data.typeData;
			}
		}

		/**设置通用数据*/
		private function setCommonData(data:Object):void {
			eleName = data.hasOwnProperty("eleName") ? data.eleName : eleName;
			pos = data.hasOwnProperty("pos") ? data.pos : (pos ? pos : new Point(0, 0));
			pivot = data.hasOwnProperty("pivot") ? data.pivot : (pivot ? pivot : new Point(0, 0));
			rota = data.hasOwnProperty("rota") ? data.rota : (rota ? rota : 0);
		}

		/**设置类型数据*/
		private function setTypeData(data:Object):void {
			ElementGenerator.generateByTypeData(this, data);
		}

		/**类型数据 由commonData、typeData拼接*/
		public function get data():Object {
			return {commonData:{eleName:_eleName, pos:_pos, pivot:_pivot, rota:_rota}, typeData:_typeData};
		}

		/**
		 ** 获取配置化数据
		 * e.g:
		 * <element>
		 *   <commonData name="btn1" x="585" y="268" index="0" pivotX="0" pivotY="0" rotation="0"/>
		 *	 <typeData type="button1" height="28" width="60" txtContent = "按钮1"/>
		 * </element>
		 *
		 */
		public function get configData():XML {
			var xml:XML = <element><commonData name = {eleName} x = {pos.x} y = {pos.y} index = {this.parent.getChildIndex(this)} pivotX = {pivot.x}  pivotY = {pivot.y} rotation = {rota}/></element>;
			/*将字典_typeData填充进XML的typeData节点*/
			for (var key:Object in _typeData) {
				xml.typeData.@[key] = _typeData[key];
			}
			return xml;
		}

		public function set eleName(name:String):void {
			_eleName = name;
		}

		public function get eleName():String {
			return _eleName;
		}

		public function get index():int {
			return _index;
		}

		public function set index(value:int):void {
			_index = value;
		}

		public function set pos(pt:Point):void {
			_pos = pt;
			this.x = pt.x;
			this.y = pt.y;
		}

		public function get pos():Point {
			return _pos;
		}

		public function set pivot(pt:Point):void {
			_pivot = pt;
		}

		public function get pivot():Point {
			return _pivot;
		}

		public function set rota(value:int):void {
			_rota = value;
			rotation = _rota;
		}

		public function get rota():int {
			return _rota;
		}
		
		/**获取类型数据typeData中的type字段，用于区分元素类型*/
		public function get type():String {
			if(_typeData.hasOwnProperty("type")){
				return _typeData.type;
			}
			return "";
		}
		
		override public function set width(value:Number):void {
			if (_typeData.hasOwnProperty("width")) {
				_typeData.width = value;
				setTypeData(_typeData);
			}
		}
		
		override public function get width():Number {
			if (_typeData.hasOwnProperty("width")) {
				return _typeData.width;
			}
			return 0;
		}
		
		override public function set height(value:Number):void {
			if (_typeData.hasOwnProperty("height")) {
				_typeData.height = value;
				setTypeData(_typeData);
			}
		}
		
		override public function get height():Number {
			if (_typeData.hasOwnProperty("height")) {
				return _typeData.height;
			}
			return 0;
		}

		/**
		 * 获取文本内容
		 * 来自 _typeData
		 * 部分组件包含（Button，TextFiedld）
		 *
		 */
		public function get txtContent():String {
			if (_typeData.hasOwnProperty("txtContent")) {
				return _typeData.txtContent;
			}
			return null;
		}
		
		/**
		 * 尝试设置文本内容
		 * 若_typeData没有txtContent字段，则不设置
		 * @param str 文本内容
		 * 
		 */		
		public function set txtContent(str:String):void {
			if (_typeData.hasOwnProperty("txtContent")) {
				_typeData.txtContent = str;
			}
			return;
		}
	}
}
