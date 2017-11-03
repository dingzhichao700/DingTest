package { 
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.Socket;
	import flash.text.TextField;
	
	[SWF(frameRate = "30", backgroundColor = "0xffffff", width = 640, height = 480)]
	public class ChatRoomClient extends Sprite { 
		
		private var socket:Socket;
		private var text:TextField;
		
		public function ChatRoomClient(  ) { 
			init();
		}
		
		public function init():void {
			text = new TextField();
			text.width = 400;
			text.height = 250;
			text.x = 100;
			text.y = 100;
			this.addChild(text);
			
			socket = new Socket(); 
			socket.addEventListener(Event.CONNECT, onConnect);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
			socket.connect("localhost", 8888); 
		} 
		
		private function onConnect(e:Event):void { 
			trace("The socket is now connected...");   
		} 
		
		private function onData(e:ProgressEvent):void {
			var str:String = socket.readUTF() + "\n";
			text.appendText(str);
		}
	} 
} 