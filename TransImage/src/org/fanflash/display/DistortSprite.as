package org.fanflash.display {
	import com.adobe.protocols.dict.Definition;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashsandy.display.DistortImage;
	
	/**
	* 可变形的Sprite
	* @author   fanflash
	* @link     www.fanflash.cn
	* @version  1.0
	*/
	public class DistortSprite extends Sprite {
		
		private static var CONTROL_DOT_SIZE:int = 10;         //控制点的大小
		
		private var bmp:BitmapData; 
		private var pointList:Object;
		private var imageList:Object; 
		private var controlList:Array;
		private var disortImage:DistortImage;
		private var isShowControlDot:Boolean;
		private var controlDotBox:Sprite;
		private var pointDotBox:Sprite;
		private var drageBtn:Sprite;
		
		public var wPrecision:int;                            //水平精细度（横向被切割块数）
		public var hPrecision:int;                            //垂直精细度（纵向被切割块数）
		
		public function DistortSprite(dt:BitmapData = null, isShowControlDot:Boolean = false, hp:int = 14, vp:int = 14) {
			this.wPrecision = hp;
			this.hPrecision = vp;
			this.bitmapData = dt;
			this.showControlDot = isShowControlDot;
			this.isShowPoints = false;
			
			this.addEventListener(Event.ADDED_TO_STAGE, this.onLoad);
		}
		
		private function onLoad(e:Event) {
			
			var local:DistortSprite = this;
			stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent) {
				if (local.drageBtn != null) {
					local.drageBtn.stopDrag();
					local.drageBtn = null;
				}
				local.removeEventListener(Event.ENTER_FRAME, local.enterFrame);
				local.disortImage.smoothing = true;
				local.enterFrame(new Event(Event.ENTER_FRAME));
			})
		}
		
		/**
		 * 设置或获取图片
		 */
		public function set bitmapData(dt:BitmapData) {
			
			if (dt == null) {
				return;
			}
			
			this.bmp = dt;
			
			var bw:Number = this.bmp.width / this.wPrecision;
			var bh:Number = this.bmp.height / this.hPrecision;
			
			this.pointList = new Object();
			this.imageList = new Object();
			this.disortImage = new DistortImage(bw, bh, 2, 2);
			
			for (var x:int = 0; x <= this.wPrecision; x++ ) {
				for (var y:int = 0; y <= this.hPrecision; y++ ) {
					
					var name:String = x + "_" + y;
					var px:Number = x * bw;
					var py:Number = y * bh;
					this.pointList[name] = new SPoint(px, py);
					if (x == this.wPrecision || y == this.hPrecision) {
						continue;
					}
					
					this.imageList[name] = new ImageBlock(this.bmp, new Rectangle(px, py, bw, bh));
					this.addChild(this.imageList[name].shape);
				}
			}
			
			var wHalf:Number = this.bmp.width / 2;
			var hHalf:Number = this.bmp.height / 2;
			this.controlList = new Array();
			this.controlList[0] = new SPoint(0, 0);
			this.controlList[1] = new SPoint(wHalf, 0);
			this.controlList[2] = new SPoint(this.bmp.width, 0);
			this.controlList[3] = new SPoint(this.bmp.width, hHalf);
			this.controlList[4] = new SPoint(this.bmp.width, this.bmp.height);
			this.controlList[5] = new SPoint(wHalf, this.bmp.height);
			this.controlList[6] = new SPoint(0, this.bmp.height);
			this.controlList[7] = new SPoint(0, hHalf);	
			
			this.update();
		}
		
		public function get bitmapData():BitmapData {
			return this.bmp;
		}
		
		
		/**
		 * 设置是否要控制点
		 */
		public function  set showControlDot(dt:Boolean) {
			
			if (dt) {
				
				if (this.controlDotBox) {
					return;
				}
				
				this.controlDotBox = new Sprite();
				this.addChild(this.controlDotBox);
				
	    		var dot:Sprite;
		    	for (var i:int; i < 8; i++ ) {
		    		dot = this.addControlDot("dot" + i);
		    		dot.x = this.controlList[i].x;
		    		dot.y = this.controlList[i].y;
		    	}
				
			}else {
				if (this.controlDotBox) {
					this.removeChild(this.controlDotBox);
				}
			}
			
			this.isShowControlDot = dt;
		}
		
		public function get showControlDot():Boolean {
			return this.isShowControlDot;
		}
		
		
		/**
		 * 显示全部节点
		 */
		private var isShowPoints:Boolean;
		public function set showPoints(t:Boolean) {
			
			this.isShowPoints = t;
			
			if (t) {
				this.showPointsFun();
			}else {
				if (this.pointDotBox) {
					this.pointDotBox.visible = false;
				}
			}
		}
		
		public function get showPoints():Boolean {
			return this.isShowPoints;
		}
		
		private function showPointsFun() {
			var x:int;
			var y:int;
			
			if (!this.pointDotBox) {
				
				this.pointDotBox = new Sprite();
				this.addChild(this.pointDotBox);
				
				var dot:Shape;
				for (x=0; x <= this.wPrecision; x++ ) {
					for (y=0; y <= this.hPrecision; y++ ) {
						
						dot = new Shape();
						dot.name = x + "_" + y;
						dot.graphics.beginFill(0xff0000);
						dot.graphics.drawCircle( 0, 0, 3);
						this.pointDotBox.addChild(dot);
					}
				}
				
			    //调换层
				if (this.controlDotBox) {
					this.swapChildren(this.pointDotBox, this.controlDotBox);
				}			
			}
			
			this.pointDotBox.visible = true;
			var point:SPoint;
			var name:String;
			for (x=0; x <= this.wPrecision; x++ ) {
				for (y=0; y <= this.hPrecision; y++ ) {
					name = x + "_" + y;
					point = this.pointList[name];
					this.pointDotBox.getChildByName(name).x = point.x;
					this.pointDotBox.getChildByName(name).y = point.y;
				}
			}			
		}
		
		/**
		 * 更新图片
		 */
		public function update() {
			this.setTransform(this.controlList[0].x, this.controlList[0].y, this.controlList[1].x, this.controlList[1].y, this.controlList[2].x, this.controlList[2].y, this.controlList[3].x, this.controlList[3].y, this.controlList[4].x, this.controlList[4].y, this.controlList[5].x, this.controlList[5].y, this.controlList[6].x, this.controlList[6].y, this.controlList[7].x, this.controlList[7].y);
		}
		
		/**
		 * 指定图像八个点的位置，从像的左上角开始为p0，以顺时针方向计数，终点为P7
		 * @param	p0_x
		 * @param	p0_y
		 * @param	p1_x
		 * @param	p1_y
		 * @param	p2_x
		 * @param	p2_y
		 * @param	p3_x
		 * @param	p3_y
		 * @param	p4_x
		 * @param	p4_y
		 * @param	p5_x
		 * @param	p5_y
		 * @param	p6_x
		 * @param	p6_y
		 * @param	p7_x
		 * @param	p7_y
		 */
		public function setTransform(p0_x:Number, p0_y:Number, p1_x:Number, p1_y:Number, p2_x:Number, p2_y:Number, p3_x:Number, p3_y:Number, p4_x:Number, p4_y:Number, p5_x:Number, p5_y:Number, p6_x:Number, p6_y:Number, p7_x:Number, p7_y:Number) {
			
			if (this.bmp == null) {
				trace("你还没有设置bitmapData属性");
				return;
			}
			
			for (var i = 0; i < 8; i++ ) {
				this.controlList[i].x = arguments[i * 2];
				this.controlList[i].y = arguments[i * 2 + 1];
			}
			
			this.setYPoints(new SPoint(p0_x, p0_y), new SPoint(p7_x, p7_y), new SPoint(p6_x, p6_y), 0); 
			this.setYPoints(new SPoint(p2_x, p2_y), new SPoint(p3_x, p3_y), new SPoint(p4_x, p4_y), this.wPrecision);
			
			
			var x:int;
			var y:int;
			var t:Number;
			var p1:Point = new Point(p1_x, p1_y);
			var p2:Point = new Point(p5_x, p5_y);
			var p3:Point;
			var p4:SPoint;
			var p5:SPoint;
			
			t = 1 / this.hPrecision;
			for (y = 0; y <= this.hPrecision; y++ ) {
				
				p3 = Point.interpolate(p2, p1, y * t);
				p4 = this.pointList["0_" + y];
				p5 = this.pointList[this.wPrecision + "_" + y];
				this.setXPoints(p4, new SPoint(p3.x, p3.y), p5, y);
			}
			
			var lt:SPoint; 
			var rt:SPoint; 
			var lb:SPoint; 
			var rb:SPoint; 
			var imageBlock:ImageBlock; 
			for (x = 0; x < this.wPrecision; x++ ) {
				for (y = 0; y < this.hPrecision; y++ ) {
					
					lt = this.pointList[x + "_" + y]; 
					rt = this.pointList[(x + 1) + "_" + y]; 
					rb = this.pointList[(x + 1) + "_" +(y + 1)];
					lb = this.pointList[x + "_" + (y + 1)];
					
					imageBlock = this.imageList[x + "_" + y];
					imageBlock.shape.graphics.clear();
					this.disortImage.setTransform(imageBlock.shape.graphics, imageBlock.bitmapData, new Point(lt.x, lt.y), new Point(rt.x, rt.y), new Point(rb.x, rb.y), new Point(lb.x, lb.y));				
				}
			}
			
			if (this.isShowPoints) {
				this.showPointsFun();
			}
		}
		
		
		private function addControlDot(name:String):Sprite {
			
			var t:Sprite = new Sprite();
			var tx:Number = CONTROL_DOT_SIZE / 2;
			t.graphics.beginFill(0xff0000);
			t.graphics.drawRect( -tx, -tx, CONTROL_DOT_SIZE, CONTROL_DOT_SIZE);
			t.blendMode = BlendMode.INVERT;
			t.name = name;
			this.controlDotBox.addChild(t);
			
			var local:DistortSprite = this;
			t.addEventListener(MouseEvent.MOUSE_DOWN, function() {
				t.startDrag();
				local.drageBtn = t;
				local.disortImage.smoothing = false;
				local.addEventListener(Event.ENTER_FRAME, local.enterFrame);
			});
			
			return t;
		}
		
		private function enterFrame(e:Event) {
			var list:Array = new Array();
			var dot:Sprite;
			for (var i:int; i < 8; i++ ) {
				dot = Sprite(this.controlDotBox.getChildByName("dot" + i));
				list.push(dot.x);
				list.push(dot.y);
			}
			this.setTransform.apply(this, list);
		}
		
		private function setXPoints(p1:SPoint, p2:SPoint, p3:SPoint, y:int) {
			
			var t:Array = this.getBezierPoints(p1, p2, p3, this.wPrecision);
			var len:int = t.length;
			var name:String;
			for (var i:int; i < len; i++ ) {
				name = i + "_" + y;
				this.pointList[name].x = t[i].x;
				this.pointList[name].y = t[i].y;
			}
		}
		
		private function setYPoints(p1:SPoint, p2:SPoint, p3:SPoint, x:int) {
			
			var t:Array = this.getBezierPoints(p1, p2, p3, this.hPrecision);
			trace(t.length)
			var len:int = t.length;
			var name:String;
			for (var i:int; i < len; i++ ) {
				name = x + "_" + i;
				this.pointList[name].x = t[i].x;
				this.pointList[name].y = t[i].y;
			}
		}
		
		
		private function getBezierPoints(p1:SPoint, p2:SPoint, p3:SPoint, n:Number):Array {
			
			var points:Array = new Array();
			var i:Number = 0;
			var x:Number;
			var y:Number;
			var d:Number = 1 / n;
			
			var t:Number;
			var ta:Number;
			var tb:Number;
			var tc:Number;
			
			for (var j:int = 0; j < n; j++ ) {
				t = 1 - i;
				ta = t * t;
				tb = 2 * i * t;
				tc = i * i;
				x = ta * p1.x +tb * p2.x + tc * p3.x;
				y = ta * p1.y + tb * p2.y + tc * p3.y;
				points.push(new SPoint(x, y));
				i = i + d;				
			}
			
			points.push(new SPoint(p3.x, p3.y));
			return points;
		}		
	}
}


import flash.display.BitmapData;
import flash.display.Shape;
import flash.geom.Point;
import flash.geom.Rectangle;
class ImageBlock {
	
	public var shape:Shape;
	public var bitmapData:BitmapData;
	
	public function ImageBlock(bmp:BitmapData,rect:Rectangle) {
		
		this.shape = new Shape();
		this.bitmapData = new BitmapData(rect.width, rect.height, true, 0);
		
		this.bitmapData.copyPixels(bmp, rect, new Point());         
	}
}


class SPoint {
	public var x:Number;
	public var y:Number;
	public function SPoint(x:Number = 0, y:Number = 0) {
		this.x = x;
		this.y = y;
	}
}