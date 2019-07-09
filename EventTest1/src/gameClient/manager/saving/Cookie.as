package gameClient.manager.saving
{
	import flash.net.SharedObject;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	
	/**
	 * 本地缓存 
	 * @author 9ria
	 * 
	 */	
	public class Cookie
	{
		private var so:SharedObject;
		private var _name:String
		
		public function Cookie(file_name:String)
		{
			so = SharedObject.getLocal(file_name, "/");
			_name = file_name
		}
		
		/**添加数据*/
		public function flushData(key:String,value:*):void {
			if (so.data.cookie == null) {
				var obj:Object = {};
				obj[key] = value;
				so.data.cookie = obj;
			}
			else {
				so.data.cookie[key] = value;
			}
			trace(key + ":" + so.data.cookie[key]);
			flush();
		}
		
		/**删除数据值*/
		public function deleteData(key:String):void {
			if (judge(key)) {
				delete so.data.cookie[key];
				flush();
			}
		}
		
		/**获取数据名*/
		public function getName():String {
			return _name
		}
		
		/**获取数据值*/
		public function getData(key:String):* {
			if (judge(key)) {
				return so.data.cookie[key];
			}
			else {
				return null;
			}
		}
		
		/**清除缓存*/
		public function clearData():void {
			so.clear();
		}

		/**判断数据是否存在*/
		public function judge(key:String):Boolean {
			return so.data.cookie != undefined && so.data.cookie[key] != undefined
		}
		
		/**写入*/
		private function flush():void {
			if (so) {
				try 
				{
					so.flush();
				}
				catch (e:Error)
				{
					Security.showSettings();
					Security.showSettings( SecurityPanel.LOCAL_STORAGE );
				}
			}
		}
	}
}