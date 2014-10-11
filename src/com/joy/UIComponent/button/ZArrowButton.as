package com.joy.UIComponent.button
{
	import com.joy.UI.UICreator;
	import com.joy.UIComponent.DefaultSkin;
	import com.joy.UIComponent.EStyleName;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * 带有一个小箭头的按钮
	 * @user zhouhonghui
	 * @date 2014-8-7 下午03:49:38
	 **/
	public class ZArrowButton extends ZButton
	{
		public static var DIR_LEFT:String="DIR_LEFT";
		public static var DIR_RIGHT:String="DIR_RIGHT";
		public static var DIR_UP:String="DIR_UP";
		public static var DIR_DOWN:String="DIR_DOWN";
		
		private var _direction:String;
		private var _arrow:DisplayObject;
		public function ZArrowButton()
		{
			super();
		}

		public function get direction():String
		{
			return _direction;
		}

		public function set direction(value:String):void
		{
			_direction = value;			
			this.setArrow();
		}
			
		public override function setSize(w:Number, h:Number):void
		{
			super.setSize(w,h);
			this.curShowSytle.width=w;
			this.curShowSytle.height=h;
			this.setArrowDefSkinByColor();
			this.direction=this.direction;
		}
		override public function setStyle(style:String, renderer:*):void
		{
			super.setStyle(style,renderer);
			this.setArrowDefSkinByColor();
		}
		/**
		 *设置箭头的皮肤 
		 * @param skin
		 * 
		 */		
		public function setArrowSkin(skin:DisplayObject):void
		{
			this.clearArrow();
			this._arrow=skin;
			this.addChild(this._arrow);
			var pos:Number=2;
			this._arrow.x=pos;
			this._arrow.y=pos;
			this.setArrow();
		}
		/**
		 *设置默认箭头的颜色 
		 * @param color
		 * 
		 */		
		public function setArrowDefSkinByColor(color:uint=0xaaaa00):void
		{
			this.clearArrow();
			var gap:Number=4;			
			var x1:Number=this.curShowSytle.width-gap;
			var y1:Number=(this.curShowSytle.height-gap)/2;
			_arrow=UICreator.getTriangleBtn(new Point(x1,y1),gap/2,gap/2,this,color);
		}
		private function clearArrow():void
		{
			if(_arrow && _arrow.parent)
			{
				_arrow.parent.removeChild(_arrow);
			}
		}
		/**
		 *根据箭头的方向设置坐标角度 
		 * 
		 */		
		private function setArrow():void
		{			
			var gap:Number=4;
			
			var x1:Number=this.curShowSytle.width-gap;
			var y1:Number=(this.curShowSytle.height-gap)/2;
			
			switch(this._direction)
			{
				case DIR_RIGHT:
					_arrow.rotationY=0;
					_arrow.x=_arrow.y=gap/2;					
					break;
				case DIR_LEFT:
					//_arrow=UICreator.getTriangleBtn(new Point(x1,y1),gap/2,gap/2,this);
					_arrow.rotationY=180;
					_arrow.x=gap/2+_arrow.width;					
					break;
				case DIR_UP:
					x1=(this.curShowSytle.height-gap);
					y1=(this.curShowSytle.width-gap)/2;
					//_arrow=UICreator.getTriangleBtn(new Point(x1,y1),gap/2,gap/2,this);
					_arrow.rotation=-90;
					_arrow.y=1+_arrow.height;		
					break;
				case DIR_DOWN:
					x1=(this.curShowSytle.height-gap);
					y1=(this.curShowSytle.width-gap)/2;
					//_arrow=UICreator.getTriangleBtn(new Point(x1,y1),gap/2,gap/2,this);
					_arrow.rotation=90;
					_arrow.x=1+_arrow.width;					
					break;
			}
		}
		
		override protected function createSkin():void
		{
			super.createSkin();
			this.setStyle(EStyleName.UP_SKIN,DefaultSkin.getSkin(0x444400,50,30));			
			this.direction=DIR_LEFT;
		}
		
		
		
		
	}
}