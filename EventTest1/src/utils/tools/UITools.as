package utils.tools
{
	import flash.display.Sprite;

	public class UITools
	{
		public function UITools()
		{
		}
		
		/**
		 * 创建栅格矩形
		 * @param _color 		起始色
		 * @param _resterWidth 	宽度
		 * @param _resterHeight 高度
		 * @param _colorLevel 	层数
		 * @param _interval 	色比例跨度
		 * @return 
		 * 
		 */		
		public static function createResterRect(_color:int, _resterWidth:int, _resterHeight:int, _colorLevel:int, _interval:Number):Sprite{
			var sprite:Sprite = new Sprite();
			
			for(var i:int = 0; i <　_colorLevel; i ++){
				sprite.graphics.beginFill(resterColor(_color, (1-i*_interval)));
				sprite.graphics.drawRect(0, (_resterHeight/_colorLevel)*i, _resterWidth, _resterHeight/_colorLevel);
				sprite.graphics.endFill();
			}
			return sprite;
		}
		
		
		/**
		 * 获取一种颜色的栅格颜色 
		 * @param _color 原色
		 * @param _rate 比例(增加，例如0.1时0x302010会变成0x332211)
		 * @return 
		 * 
		 */		
		private static function resterColor(_color:int, _rate:Number):int {
			var R:int = _color/(256*256);
			var G:int = (_color - R*256*256)/256;
			var B:int = _color - R*(256*256) - G*256;
			if(_rate == 1){
				return _color;
			}
			
			var finalR:int = int(R*(_rate + (R/256)/14));
			var finalG:int = int(G*(_rate + (G/256)/14));
			var finalB:int = int(B*(_rate + (B/256)/14));
			var settledColor:int = finalR * (256*256) + finalG * 256 + finalB;
			return settledColor;
		}
	}
}