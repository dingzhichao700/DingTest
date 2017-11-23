package {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;

	import tool.EventName;
	import tool.GameBus;

	public class Connect {

		private var socket:Socket;
		private var _port:int;
		private static var _instance:Connect;

		public static function getInstance():Connect {
			_instance ||= new Connect;
			return _instance;
		}

		public function Connect() {
			socket = new Socket();
			socket.addEventListener(Event.CONNECT, onConnect);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurity);
			socket.timeout = 1000;
		}

		public function set port(value:int):void {
			this._port = value;
		}

		public function toConnect():void {
			try {
				socket.connect("localhost", _port);
			} catch(e:IOErrorEvent) {
				trace("连接错误\n");
			}
		}

		private function onConnect(e:Event):void {
			GameBus.getInstance().dispatchMsg(EventName.CONNECT_SUCCESS);
		}

		private function onError(e:IOErrorEvent):void {
			GameBus.getInstance().dispatchMsg(EventName.CONNECT_FAIL, e.text + "\n");
		}

		private function onSecurity(e:SecurityErrorEvent):void {
			GameBus.getInstance().dispatchMsg(EventName.CONNECT_FAIL, e.text + "\n");
		}

		private function onData(e:ProgressEvent):void {
			var str:String = socket.readUTF() + "\n";
		}
	}
}
