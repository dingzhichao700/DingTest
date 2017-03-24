package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import flashx.textLayout.accessibility.TextAccImpl;
	
	public class TestEmbedFont extends Sprite
	{
		private var _loader:Loader;
		private var tx:TextField;
		
		public function TestEmbedFont()
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loader.load(new URLRequest("testFont.swf"));
		}
		
		private function completeHandler(evt:Event):void {
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			
			var fontLibrary:Class=evt.target.applicationDomain.getDefinition("tscaiyun") as Class;
			var font:Font = (new fontLibrary()) as Font;
			Font.registerFont(fontLibrary);//注册字体

			tx =new TextField();
			tx.autoSize = TextFieldAutoSize.LEFT;
			var tf:TextFormat=new TextFormat(font.fontName,20,0xFF0000);
			//tx.embedFonts = true;//如果设置为false，那么下面的“和”字也会显示
			
			tx.text="啊哈哈哈哈";//“和”不会显示，因为我只注册了“确认取消”这四个字
			tx.setTextFormat(tf);
			addChild(tx);
		}
	}
}