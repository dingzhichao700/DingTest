package utils.display.scrollScreen
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import utils.display.sprite.GSprite;
	import utils.event.EventUtils;

	/**
	 * 拖曳视图2
	 * @author ding
	 * 
	 */	
	public class ScrollScreen2 extends GSprite
	{
		/**视图宽度*/
		private var viewWidth:int;
		/**视图高度*/
		private var viewHeight:int;
		private var content:GSprite;
		private var _mask:GSprite;
		private var _area:Rectangle;
		private var targetY:int;
		/**显示数据*/
		private var _dataSource:Array;
		/**子项类*/
		private var _item:Class;
		/**横向间距*/
		private var _horizonGap:int;
		/**纵向间距*/
		private var _verticalGap:int;
		/**是否拖曳中*/
		private var _dragBoo:Boolean;
		/**是否忽略横向位移*/
		private var ignoreHori:Boolean = true;
		/**是否忽略纵向位移*/
		private var ignoreVer:Boolean;
		/**是否出界*/
		private var _outArea:Boolean;
		/**鼠标点击点*/
		private var dropPoint:Point;
		/**容器原先点*/
		private var prePoint:Point;
		/**容器当前点*/
		private var curPoint:Point;
		/**鼠标点击点*/
		private var dropRound:Shape;
		private var count:int;
		private var slipSpeed:Number;
		private var _items:Array;
		private var _dragAble:Boolean;
		
		public function ScrollScreen2()
		{
			content = new GSprite();
			addChild(content);
			
			dropRound = new Shape();
			dropRound.graphics.beginFill(0x0000FF);
			dropRound.graphics.drawCircle(0, 0, 5);
			addChild(dropRound);
		}
		
		/**开始拖动*/
		private function drag_start(e:MouseEvent):void
		{
			if(!_dragBoo){
				_dragBoo = true;
				dropPoint = new Point(mouseX - content.x, mouseY - content.y);
				setDisplayToPoint(dropRound, dropPoint);
			}
			EventUtils.removeEventListener(content, MouseEvent.MOUSE_DOWN, drag_start);
			EventUtils.addEventListener(content.stage, MouseEvent.MOUSE_UP, drag_complete);
		}
		
		/**结束拖动*/
		private function drag_complete(e:MouseEvent):void
		{
			if(_dragBoo){
				_dragBoo = false;
				curPoint = new Point(mouseX, mouseY);
				slipSpeed = (curPoint.y - prePoint.y)*0.35;
			}
			EventUtils.removeEventListener(content.stage, MouseEvent.MOUSE_UP, drag_complete);
			EventUtils.addEventListener(content, MouseEvent.MOUSE_DOWN, drag_start);
		}
		
		/**设置显示区域*/		
		public function set area(rect:Rectangle):void {
			_area = rect;
			_mask = new GSprite();
			_mask.mouseEnabled = false;
			_mask.graphics.beginFill(0x000000, 0.3);
			_mask.graphics.drawRect(0, 0, _area.width, _area.height);
			_mask.graphics.endFill();
			_mask.x = _area.x; _mask.y = _area.y;
			this.addChild(_mask);
			content.x = _area.x; content.y = _area.y;
//			content.mask = _mask;
			_mask.mouseEnabled = false;
			
			/*设置可拖曳，添加侦听*/
			dragAble = true;
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
			content.removeChildren();
			if(_items)
			{
				while(_items.length != 0)
				{
					var sprite:GSprite = _items.shift();
					sprite.dispose();
				}
			}
			
			_items = new Array();
			for(var i:int = 0; i < arr.length; i++){
				var item:ScrollRender = new _item();
				item.dataSource = arr[i] as Object;
				item.create();
				item.y = (item.height + _verticalGap) * i;
				content.addChild(item);
				_items.push(item);
			}
			viewWidth = content.width;
			viewHeight = content.height;
		}
		
		public function get items():Array {
			return _items;
		}
		
		/**纵向间距*/
		public function set verticalGap(value:int):void{
			_verticalGap = value;
		}
		
		/**横向间距*/
		public function set horizonGap(value:int):void{
			_horizonGap = value;
		}
		
		public function set dragAble(value:Boolean):void {
			_dragAble = value;
			if(!_dragAble){
				EventUtils.removeEventListener(this, MouseEvent.MOUSE_WHEEL, wheelHandler);
				EventUtils.removeEventListener(content, Event.ENTER_FRAME, frameHandler);
				EventUtils.removeEventListener(content, MouseEvent.MOUSE_DOWN, drag_start);
				EventUtils.removeEventListener(content.stage, MouseEvent.MOUSE_UP, drag_complete);
			} else {
				EventUtils.addEventListener(this, MouseEvent.MOUSE_WHEEL, wheelHandler);
				EventUtils.addEventListener(content, Event.ENTER_FRAME, frameHandler);
				EventUtils.addEventListener(content, MouseEvent.MOUSE_DOWN, drag_start);
				EventUtils.addEventListener(content.stage, MouseEvent.MOUSE_UP, drag_complete);
			}
		}
		
		/**帧频*/
		public function frameHandler(e:Event):void {
			/*是否拖曳中*/
			if(_dragBoo){
				
				if(!ignoreHori){
					content.x = mouseX - dropPoint.x;
				}
				if(!ignoreVer){
					if(outArea){
						content.y = (mouseY - dropPoint.y - targetY)*0.2 + targetY;
					} else { /*完全跟随鼠标*/
						content.y = mouseY - dropPoint.y;
					}
				}
				count++;
				if(count == 1){
					prePoint = new Point(mouseX, mouseY);
				} else if(count == 2){
					count -= 2;
				}
			} 
			else 
			{
				setSpeed();
			}
		}
		
		/*判断出界 和 回弹Y位置*/
		private function get outArea():Boolean {
			if(viewHeight < _area.height){
				if(content.y != 0){
					_outArea = true;
					targetY = 0;
				}
			}
			else if(content.y > 0){
				_outArea = true;
				targetY = 0;
			}
			else if(content.y + viewHeight < _area.height){
				targetY = _area.height - viewHeight;
				_outArea = true;
			} else {
				_outArea = false;
			}
			return _outArea;
		}
		
		/*计算速度*/
		private function setSpeed():void {
			if(outArea)
			{
				if(abs(targetY - content.y) > 1)
				{
					slipSpeed = (targetY - content.y)/10;
				} 
				else 
				{
					content.y = targetY;
					slipSpeed = 0;
					return;
				}
			}
			
			/*速度衰减，并移动*/
			if(slipSpeed != 0){
				slipSpeed *= 0.97;
				content.y += slipSpeed;
			}
		}
		
		/**滚动滚轮*/
		public function wheelHandler(e:MouseEvent):void {
			if(content.y > 0){
				return;
			} else if(content.y + viewHeight < _area.height){
				return;
			}
			slipSpeed += e.delta;
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