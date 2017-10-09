package com {

	/**
	 * 操作日志管理
	 * @author dingzhichao
	 *
	 */
	public class LogManager {

		private static var logArr:Array = [];
		private static var logIndex:int;

		public function LogManager() {
		}

		/**
		 * 增加日志
		 * @param arr 存放记录若干对象的操作日志(String)的数组
		 *
		 */
		public static function addLog(arr:Array):void {

		}

		/**撤销上一条日志*/
		public static function revokeOneLog():void {

		}

		/**重做上一条日志*/
		public static function redoOneLog():void {

		}
	}
}
