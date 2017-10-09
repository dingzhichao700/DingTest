package utils.tools.component.sprite
{
	import flash.display.Sprite;

	public class Quad extends Sprite
	{
		public function Quad(_width:int, _height:int, _color:int, _alpha:Number = 1)
		{
			this.graphics.beginFill(_color);
			this.graphics.drawRect(0, 0, _width, _height);
			this.alpha = _alpha;
		}
	}
}