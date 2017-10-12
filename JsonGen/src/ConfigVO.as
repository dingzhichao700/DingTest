package {
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class ConfigVO {
		
		public var attrList:Array;
		
		public function ConfigVO() {
		}
		
		public function get keyList():Array { 
			var arr:Array = [];
			for(var i:int = 0; i < attrList.length;i++){
				arr.push(attrList[i].name);
			}
			return arr;
		}
		
		public static function makeConfig(path:String):ConfigVO {
			var xmlFile:File = new File(path); 
			var stream:FileStream = new FileStream(); 
			stream.open(xmlFile, FileMode.READ); 
			var xml:XML = XML(stream.readUTFBytes(stream.bytesAvailable)); 
			var vo:ConfigVO = new ConfigVO();
			vo.attrList = parseAttr(xml.file[0]..match[0]);
			return vo;
		}
		
		private static function parseAttr(str:String):Array {
			str = str.slice(1, str.length-1);
			var result:Array = [];
			var arr:Array = str.split(",");
			for(var i:int = 0; i < arr.length; i++){
				var obj:Object = new Object();
				var attr:String = arr[i];
				var head:String = attr.split(":")[0];//属性名
				var myPattern:RegExp = /([ 　]|\")/g;//去除双引号和空格
				head = head.replace(myPattern, "");
				var size:String = attr.split(":")[1];//属性类型：0数字，1字符
				obj.name = head;
				obj.size = size.charAt(size.length-1) == "\"" ? 1 : 0;
				result.push(obj);
			}
			return result;
		}
	}
}