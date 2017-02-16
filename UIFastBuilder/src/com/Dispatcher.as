package com {
	import flash.utils.Dictionary;

	/**
	 * 管理模块间通讯
	 * @author xuyang
	 *
	 */
	public class Dispatcher {
		private static var observers:Dictionary = new Dictionary; //KEY是消息名，值是数组，放函数
		private static var mapping:Dictionary = new Dictionary; //KEY是函数，值是类名和函数名

		public static function register(type:String, call:Function, module:String = null, method:String = null):void {
			var funcs:Array = observers[type];
			mapping[call] = {'module': module, 'method': method};
			if (funcs == null) {
				funcs = [];
				observers[type] = funcs;
			}
			if (funcs.indexOf(call) == -1) {
				funcs.push(call);
			}
		}

		public static function remove(type:String, call:Function):void {
			var funcs:Array = observers[type];
			if (funcs) {
				var index:int = funcs.indexOf(call);
				if (index != -1) {
					funcs.splice(index, 1);
				}
			}
		}
		public static function removeAll(type:String):void{
			var funcs:Array = observers[type];
			if (funcs) {
				funcs = null;
				delete observers[type];
			}
		}

		public static function dispatch(type:String, ...arg):void {
			var funcs:Array = observers[type];
			for each (var call:Function in funcs) {
				if (arg.length == 0 ||(arg.length == 1 && arg[0] == null)) {
					call.apply(null, null);
				} else {
					call.apply(null, arg);
				}
			}
		}

	}
}