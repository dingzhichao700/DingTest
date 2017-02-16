package utils.tools.component.scrollScreen
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 拖曳视图 
	 * @author ding
	 * 
	 */	
	public class ScrollScreen extends Sprite
	{
		private const _speed:int = 10;
		private var _container:Sprite;
		private var _mask:Sprite;
		private var _area:Rectangle;
		private var _dataSource:Array;
		private var _item:Class;
		private var _verticalGap:int;
		private var _horizonGap:int;
		/**是否拖曳中*/
		private var _dragBoo:Boolean;
		/**是否忽略横向位移*/
		private var ignoreHori:Boolean = true;
		/**是否忽略纵向位移*/
		private var ignoreVer:Boolean;
		
		/**原点(四角，默认左上)*/
		private var protoPoint:Point;
		/**偏移点(根据此点来校准容器位置)*/
		private var offsetPoint:Point;
		/**鼠标跟随点(鼠标按下后至松开前，跟随鼠标)*/
		private var mousePoint:Point;
		/**点击点(鼠标在容器上按下的坐标)*/
		private var dropPoint:Point;
		/**原点*/
		private var protoRound:Shape;
		/**偏移点*/
		private var offsetPointRound:Shape;
		/**相对点*/
		private var mouseRound:Shape;
		/**相对点*/
		private var dropRound:Shape;
		
		public function ScrollScreen()
		{
			_container = new Sprite();
			addChild(_container);
			
			protoPoint = new Point();
			offsetPoint = new Point();
			mousePoint = new Point();
			dropPoint = new Point();
			
			protoRound = new Shape();
			protoRound.graphics.beginFill(0xFF0000);
			protoRound.graphics.drawCircle(0, 0, 5);
			addChild(protoRound);
			offsetPointRound = new Shape();
			offsetPointRound.graphics.beginFill(0xDD00DD);
			offsetPointRound.graphics.drawCircle(0, 0, 5);
			addChild(offsetPointRound);
			mouseRound = new Shape();
			mouseRound.graphics.beginFill(0x00FF00);
			mouseRound.graphics.drawCircle(0, 0, 5);
			addChild(mouseRound);
			dropRound = new Shape();
			dropRound.graphics.beginFill(0x0000FF);
			dropRound.graphics.drawCircle(0, 0, 5);
			addChild(dropRound);
			
			_container.addEventListener(MouseEvent.MOUSE_DOWN, drag_start);
			_container.addEventListener(Event.ENTER_FRAME, frameHandler);
		}
		
		private function drag_start(e:MouseEvent):void
		{
			if(!_dragBoo)
			{
				dropPoint.x = mouseX;
				dropPoint.y = mouseY;
				setDisplayToPoint(dropRound, dropPoint);
				_dragBoo = true;
			}
			_container.removeEventListener(MouseEvent.MOUSE_DOWN, drag_start);
			_container.stage.addEventListener(MouseEvent.MOUSE_UP, drag_complete);
		}
		
		private function drag_complete(e:MouseEvent):void
		{
			if(_dragBoo)
			{
				_dragBoo = false;
				offsetPoint.x = protoPoint.x;
				offsetPoint.y = protoPoint.y;
				setDisplayToPoint(offsetPointRound, offsetPoint);
			}
			_container.stage.removeEventListener(MouseEvent.MOUSE_UP, drag_complete);
			_container.addEventListener(MouseEvent.MOUSE_DOWN, drag_start);
		}
		
		/**设置显示区域*/		
		public function set area(rect:Rectangle):void {
			_area = rect;
			_mask = new Sprite();
			_mask.mouseEnabled = false;
			_mask.graphics.beginFill(0x000000, 0.3);
			_mask.graphics.drawRect(0, 0, _area.width, _area.height);
			_mask.graphics.endFill();
			_mask.x = _area.x; _mask.y = _area.y;
			this.addChild(_mask);
			_container.x = _area.x; _container.y = _area.y;
			_container.mask = _mask;
		}
		
		public function set dataSource(arr:Array):void {
			_dataSource = arr;
			setScrollData(_dataSource);
		}
		
		/**设置子组件*/
		public function set scrollRender(item:Class):void{
			_item = item;
		}
		
		/**设置子组件并初始化*/
		private function setScrollData(arr:Array):void {
			for(var i:int = 0; i < arr.length; i++){
				var item:ScrollRender = new _item();
				item.dataSource = arr[i] as Object;
				item.y = (item.height + _verticalGap) * i;
				_container.addChild(item);
			}
		}
		
		/**纵向间距*/
		public function set verticalGap(value:int):void{
			_verticalGap = value;
		}
		
		/**横向间距*/
		public function set horizonGap(value:int):void{
			_horizonGap = value;
		}
		
		/**帧频*/
		public function frameHandler(e:Event):void {
			if(_dragBoo){
				if(!ignoreHori){
					mousePoint.x = mouseX;
				} else {
					mousePoint.x = dropPoint.x;
				}
				if(!ignoreVer){
					mousePoint.y = mouseY;
				} else {
					mousePoint.y = dropPoint.y;
				}
				/*设置偏移点*/
				offsetPoint.x = (mousePoint.x - dropPoint.x)*0.7;
				offsetPoint.y = (mousePoint.y - dropPoint.y)*0.7;
				setDisplayToPoint(mouseRound, mousePoint);
				setDisplayToPoint(offsetPointRound, offsetPoint);
				setDisplayToPoint(_container, offsetPoint);
			} 
			else {
				if(_container.x != offsetPoint.x || _container.y != offsetPoint.y){
					var angle:Number = Math.atan2((offsetPoint.y - _container.y), (offsetPoint.x - _container.x));
					var distance:Number = Point.distance(offsetPoint, new Point(_container.x, _container.y));
//					var speed:Number = (distance > 100 ? _speed:_speed*(Math.sqrt(10000 - (distance-20)*(distance-100)))/100);
					var speed:Number;
					if(distance > 100){
						speed = _speed;
					} else {
						var xishu:Number = Math.sqrt(distance)/Math.sqrt(100);
						speed = _speed*xishu;
					}
					var xDis:int = speed * Math.cos(angle); 
					var yDis:int = speed * Math.sin(angle); 
					_container.y += abs(yDis) < abs(offsetPoint.y - _container.y) ? yDis : (offsetPoint.y - _container.y);
					_container.x += abs(xDis) < abs(offsetPoint.x - _container.x) ? xDis : (offsetPoint.x - _container.x);
				}
			}
		}
		
		/**将某显示对象移动到某点*/
		private function setDisplayToPoint(sprite:DisplayObject, point:Point):void{
			sprite.x = point.x;
			sprite.y = point.y;
		}
		
		private function abs(value:Number):Number{
			return Math.abs(value);
		}
	}
}