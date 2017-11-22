package {
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.text.TextField;

	import control.EventBus;

	import fl.controls.Button;
	import fl.controls.TextInput;

	import tool.EventName;

	import utils.Fps;
	import utils.ResourceManager;


	[SWF(frameRate = "30", backgroundColor = "0xaaaaaa", width = 640, height = 480)]
	public class ChatRoom extends Sprite {

		private var socket:Socket;

		public function ChatRoom() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
//			Security.allowDomain("*");
			init();
		}

		public function init():void {
			new Modules();
			if(!ResourceManager.getInstance().getRes("mainUi")) {
				ResourceManager.getInstance().loadRes("mainUi", init);
				return;
			}
			var fps:Fps = new Fps();
			fps.x = 70;
			this.addChild(fps);
		}

		public function toConnect():void {
			socket = new Socket();
			socket.addEventListener(Event.CONNECT, onConnect);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
			try {
				socket.connect("localhost", port);
			} catch(e:IOErrorEvent) {
				text.appendText("连接错误\n");
			}
		}

		private function onConnect(e:Event):void {
			text.appendText("连接成功\n");
			var time:Date = new Date();
			EventBus.getInstance().dispatchMsg(EventName.LOGIN_SUCCESS, int(Math.random() * 10000), time.time);
		}

		private function onError(e:IOErrorEvent):void {
			if(e.errorID == 2031) {
				text.appendText("连接失败，端口错误");
			}
		}

		private function onData(e:ProgressEvent):void {
			var str:String = socket.readUTF() + "\n";
			text.appendText(str);
		}
	}
}
