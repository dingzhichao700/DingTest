package
{
	import flash.events.Event;
	import flash.filesystem.File;

	/**
	 * 配置管理类 
	 * @author Administrator
	 * 
	 */	
	public class ConfigManager {
		private static var _instance:ConfigManager;
		public static function getInstance():ConfigManager {
			_instance ||= new ConfigManager();
			return _instance;
		}
		
		public function ConfigManager(){
		}
	}
}