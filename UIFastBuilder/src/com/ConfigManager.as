package com {
	import com.element.Element;
	import com.element.ElementManager;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;

	/**
	 * 配置管理
	 * @author dingzhichao
	 *
	 */
	public class ConfigManager {
		/**配置的一次性数据，使用一次后废弃*/
		private var tempConfigData:Array;
		private var configFile:FileReference = new FileReference();
		private static var _instance:ConfigManager;

		public static function getInstance():ConfigManager {
			_instance ||= new ConfigManager();
			return _instance;
		}

		public function ConfigManager() {
		}

		/**导入配置*/
		public function importConfig():void {
			/*if (!MapManager.getInstance().isMapLoaded) {
				Alert.show("请先载入地图!", "警告");
				return;
			}*/
			var filter:FileFilter = new FileFilter('请选择配置文件', '*.xml');
			configFile.addEventListener(Event.SELECT, doLoadConfig);
			configFile.browse([filter]);
		}

		private function doLoadConfig(e:Event):void {
			configFile.addEventListener(Event.COMPLETE, doComplete);
			configFile.load();
		}

		private function doComplete(e:Event):void {
			convertXMLdata(XML(configFile.data.readUTFBytes(configFile.data.length)));
		}

		/**将XML数据转换成配置*/
		private function convertXMLdata(xml:XML):void {
			MapManager.getInstance().MAP_NAME = xml.@mapName;
			MapManager.getInstance().MAP_WIDTH = xml.@width;
			MapManager.getInstance().MAP_HEIGHT = xml.@height;
			Dispatcher.dispatch(ModuleComand.SET_WINDOW);
			tempConfigData = [];
			for each (var x:XML in xml.element) {
				var eleData:Object = {commonData:{eleName:String(x.commonData.@name), 
												  pos:new Point(int(x.commonData.@x), int(x.commonData.@y)), 
					 							  index:int(x.commonData.@index), 
												  pivot:new Point(int(x.commonData.@pivotX), int(x.commonData.@pivotY)), 
												  rota:Number(x.commonData.@rotation)}};
				var typeData:Object = {};
				var attNamesList:XMLList = x.typeData.@*;
				var length:int = attNamesList.length();
				for(var i:int = 0; i < length;i++) {
	                var attName:String = attNamesList[i].name().toString();
	                var attValue:String = attNamesList[i].toString();
	                typeData[attName] = attValue;
				}
				
				eleData.typeData = typeData;
					
				tempConfigData.push(eleData);
			}
			ElementManager.getInstance().compareConfigAndLib(tempConfigData);
		}

		/**导出配置*/
		public function exportConfig():void {
			/*if (!MapManager.getInstance().isMapLoaded) {
				Alert.show("请先载入地图再导入配置!", "警告");
				return;
			}*/
			if (ElementManager.getInstance().eleData.length == 0) {
				Alert.show("请放置元素后再导出配置!", "警告");
				return;
			}
			var data:XML = getConfigData();
			configFile = new FileReference();
			configFile.save(data, MapManager.getInstance().MAP_NAME + ".xml");
			configFile.addEventListener(Event.COMPLETE, completeHandler);
		}

		private function getConfigData():XML {
			var str:String = "<map></map>";
			var xml:XML = XML(str);
			xml.@mapName = MapManager.getInstance().MAP_NAME;
			xml.@width = MapManager.getInstance().MAP_WIDTH;
			xml.@height = MapManager.getInstance().MAP_HEIGHT;
			var eleData:Array = ElementManager.getInstance().eleData;
			for (var i:int = 0; i < eleData.length; i++) {
				xml.ele += Element(eleData[i]).configData;
			}
			return xml;
		}

		private function completeHandler(event:Event):void {
			Alert.show("打印成功", "提示");
		}
	}
}
