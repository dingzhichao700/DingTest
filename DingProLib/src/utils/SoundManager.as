package utils {
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	/**
	 * 声音管理
	 * @author Administrator
	 *
	 */
	public class SoundManager {

		private var channel:SoundChannel;
		private var soundDic:Dictionary;

		private static var _instance:SoundManager;

		public static function getInstance():SoundManager {
			_instance ||= new SoundManager();
			return _instance;
		}

		public function SoundManager() {
			soundDic = new Dictionary();
		}

		/**
		 * 播放声音
		 * @param url 音效地址
		 * @param loop 是否循环
		 * @param handler 播完回调方法
		 *
		 */
		public function playSound(url:String, loop:Boolean = false, volume:Number = 1, handler:Function = null):void {
			var sd:Sound = new Sound();
			sd.load(new URLRequest(url));
			channel = sd.play();
			var trans:SoundTransform = new SoundTransform();
			trans.volume = volume;
			channel.soundTransform = trans;
			soundDic[channel] = [url,loop, volume, handler];
			channel.addEventListener(Event.SOUND_COMPLETE, onComplete);
		}

		private function onComplete(e:Event):void {
			if (soundDic[(e.currentTarget as SoundChannel)]) {
				var url:String = soundDic[(e.currentTarget as SoundChannel)][0];
				var isLoop:Boolean = soundDic[(e.currentTarget as SoundChannel)][1];
				var volume:Number = soundDic[(e.currentTarget as SoundChannel)][2];
				var handler:Function = soundDic[(e.currentTarget as SoundChannel)][3];
				if (handler) {
					handler();
				}
				if(isLoop){
					playSound(url, isLoop, volume, handler);
				}
				delete soundDic[(e.currentTarget as SoundChannel)];
			}
		}

	}
}
