package {
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import flash.system.fscommand;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import fl.controls.Button;
	import fl.controls.TextInput;
	
	[SWF(width = 720, height = 480, backgroundColor = "0xaaaaaa", frameRate = "60")]
	
	public class MenuPost extends Sprite {
		
		/**状态 1设置 2展示*/
		private var state:int;
		private var btnStart:Button;
		private var con:Sprite;
		
		private var so:SharedObject;
		private var dataObj:Object;
		private var itemList:Array;
		private var showText:TextField;
		private var inputNum:String;
		
		private var WIDTH:int = 720;
		private var HEIGHT:int = 480;
		private var SPEED:int = 5;
		private var STATE_SET:int = 1;
		private var STATE_SHOW:int = 2;
		
		public function MenuPost() {
			inputNum = "";
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onUp);
			state = STATE_SET;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var format:TextFormat = new TextFormat();
			format.font = "ht";
			format.size = 250;
			format.color = 0xffffff;
			showText = new TextField();
			showText.x = 100;
			showText.y = 50;
			showText.width = 2000;
			showText.height = 250;
			showText.defaultTextFormat = format;
			showText.htmlText = "";
			showText.visible = false;
			this.addChild(showText);
			
			con = new Sprite();
			this.addChild(con);
			
			btnStart = new Button();
			btnStart.width = 100;
			btnStart.height = 40;
			btnStart.label = "启动";
			btnStart.x = WIDTH - 150;
			btnStart.y = HEIGHT - 100;
			btnStart.addEventListener(MouseEvent.CLICK, toShow);
			con.addChild(btnStart);
			
			itemList = [];
			so = SharedObject.getLocal("mydata","/");
			var inputStyle:TextFormat = new TextFormat();
			format.font = "Georgia";
			format.size = 40;
			
			for(var i:int = 0; i < 20; i++){
				var text:TextField = new TextField();
				text.text = (i+STATE_SET) + ".";
				text.x = Math.floor(i/10)*220 + 20;
				text.y = 50 + Math.floor(i%10)*35;
				con.addChild(text);
				
				var html:TextInput = new TextInput();
				html.setSize(180, 20)
				html.x = Math.floor(i/10)*220 + 40;
				html.y = 50 + Math.floor(i%10)*35;
				html.setStyle("textFormat", inputStyle);
				html.htmlText = (so.data.menu && so.data.menu[i]) ? so.data.menu[i] : "无";
				con.addChild(html);
				itemList.push(html);
			}
		}
		
		private function saveMenu():void {
			var list:Array = [];
			dataObj = new Object();
			for(var i:int = 0; i < itemList.length; i++){
				list.push((itemList[i] as TextInput).text);
				dataObj[i+STATE_SET] = (itemList[i] as TextInput).text;
			}
			so.data.menu = list;
			so.flush();
		}
		
		private function toShow(e:MouseEvent):void {
			saveMenu();
			fscommand("fullscreen", "true");
			showText.x = 100;
			this.stage.addEventListener(Event.ENTER_FRAME, onFrame);
			state = STATE_SHOW;
			update();
		}
		
		private function onUp(e:KeyboardEvent):void {
			if(e.keyCode == 27) { //退出
				state = STATE_SET;
				this.stage.removeEventListener(Event.ENTER_FRAME, onFrame);
				update();
			} else {
				var number:int;
				switch(e.keyCode){
					case 48:
					case 96:
						plusNum(0);
						break;
					case 49:
					case 97:
						plusNum(1);
						break;
					case 50:
					case 98:
						plusNum(2);
						number = 2;
						break;
					case 51:
					case 99:
						plusNum(3);
						break;
					case 52:
					case 100:
						plusNum(4);
						break;
					case 53:
					case 101:
						plusNum(5);
						break;
					case 54:
					case 102:
						plusNum(6);
						break;
					case 55:
					case 103:
						plusNum(7);
						break;
					case 56:
					case 104:
						plusNum(8);
						break;
					case 105:
					case 97:
						plusNum(9);
						break;
					case 8:
						inputNum = "";
						break;
					case 13:
						if(state == STATE_SHOW && dataObj[inputNum]){
							showText.x = WIDTH;
							showText.htmlText = dataObj[inputNum];
							inputNum = "";
						} else {
							inputNum = "";
						}
						break;
				}
			}
		}
		
		private function plusNum(num:int):void {
			inputNum += num + "";
		}
		
		private function update():void {
			con.visible = state == STATE_SET;
			showText.visible = state == STATE_SHOW;
			if(state == STATE_SET){
				this.stage.color = 0xaaaaaa;
			} else {
				this.stage.color = 0x000000;
			}
		}
		
		private function onFrame(e:Event):void {
			showText.x -= SPEED;
			if(showText.x < -showText.textWidth){
				showText.x = WIDTH;
			}
		}
	}
}
