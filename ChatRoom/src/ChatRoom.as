package { 
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.text.TextField;
	
	[SWF(frameRate = "30", backgroundColor = "0xffffff", width = 640, height = 480)]
	public class ChatRoom extends Sprite { 
		
		private var socket:Socket;
		private var text:TextField;
		
		public function ChatRoom(  ) { 
//			Security.allowDomain("*");
			text = new TextField();
			text.width = 400;
			text.height = 250;
			text.x = 100;
			text.y = 100;
			this.addChild(text);
			text.appendText("启动\n");
			
			init();
		}
		
		public function init():void {
			
			socket = new Socket(); 
			socket.addEventListener(Event.CONNECT, onConnect);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
			try{
				socket.connect("localhost", 8888); 
			} catch(e:IOErrorEvent){
				text.appendText("连接错误\n");
			}
		} 
		
		private function onConnect(e:Event):void { 
			text.appendText("连接成功\n");
		} 
		
		private function onError(e:IOErrorEvent):void {
			
		}
		
		private function onData(e:ProgressEvent):void {
			var str:String = socket.readUTF() + "\n";
			text.appendText(str);
		}
	} 
} 