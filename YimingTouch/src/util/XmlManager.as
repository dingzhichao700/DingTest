package util {
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getTimer;

	public class XmlManager {

		private var _data:Object;
		private var callBack:Function;
		private var loadList:Array;

		private var startTime:int;
		private var curUrl:String;
		private static var _ins:XmlManager;

		public static function get ins():XmlManager {
			_ins ||= new XmlManager();
			return _ins;
		}

		public function XmlManager() {
			_data = {};
		}

		public function loadXml(arr:Array, _callBack:Function = null):void {
			loadList = arr;
			callBack = _callBack;
			startTime = getTimer();
			loadNext();
		}

		private function loadNext():void {
			if (loadList.length == 0) {
				trace("加载耗时：" + (getTimer() - startTime) / 1000 + "秒");
				if (callBack) {
					callBack();
				}
				return;
			}
			curUrl = loadList.pop();
			var XML_URL:String = "assets/xml/" + curUrl + ".xml";
			var myLoader:URLLoader = new URLLoader(new URLRequest(XML_URL));
			myLoader.addEventListener(Event.COMPLETE, xmlLoaded);
		}

		private function xmlLoaded(e:Event):void {
			var myXML:XML = new XML();
			myXML = XML(e.currentTarget.data);
			_data[curUrl] = myXML;
			loadNext();
		}

		public function getData(str:String):String {
			if (_data[str]) {
				return _data[str];
			}
			return str + ".xml未加载";
		}

	}
}
