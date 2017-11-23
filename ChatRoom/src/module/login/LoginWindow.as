package module.login {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	import fl.controls.Button;
	import fl.controls.TextInput;

	import tool.BaseWindow;

	public class LoginWindow extends BaseWindow {

		private var text:TextField;
		private var txtPort:TextInput;
		private var btn:Button;
		private var port:int;

		public function LoginWindow() {
			text = new TextField();
			text.width = 400;
			text.height = 250;
			text.x = 100;
			text.y = 150;
			text.appendText("启动\n");
			this.addChild(text);

			txtPort = new TextInput();
			txtPort.width = 50;
			txtPort.height = 25;
			txtPort.text = "8888";
			txtPort.x = 100;
			txtPort.y = 100;
			this.addChild(txtPort);

			btn = new Button();
			btn.label = "连接";
			btn.x = 160;
			btn.y = 100;
			btn.addEventListener(MouseEvent.CLICK, onClick);
			this.addChild(btn);
		}

		private function onClick(e:MouseEvent):void {
			port = int(this.txtPort.text);
			if(port > 65535) {
				text.appendText("端口超出范围\n");
				return;
			}
			Connect.getInstance().port = port;
			Connect.getInstance().toConnect();
		}

		public function showSuccess():void {
			text.appendText("连接成功\n");
		}

		public function showFail(str:String):void {
			text.appendText("连接失败：\n" + str);
			/*switch(type){
				case 0:
					text.appendText("连接失败：\n" +);
					break;
				case 2031:
					text.appendText("连接失败，端口错误\n");
					break;
			}*/
		}
	}
}
