package com.joy.debug
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	
	/**
	 * @user zhouhonghui
	 * @date 2014-8-26 下午05:27:33
	 **/
	public class DebugSelectItem extends Sprite
	{
		
		private var _txt:TextField;
		public function DebugSelectItem()
		{
			super();
			_txt=new TextField();
			_txt.autoSize="left";
			this.addChild(_txt);
		}
		
		public function set field(val:*):void
		{
			if(val && val is DisplayObject && val.parent)
			{
				var disObj:DisplayObject=val as DisplayObject;
				this.graphics.clear();
				this.graphics.lineStyle(1,0xff0000);
				this.graphics.drawRect(0,0,disObj.width,disObj.height);
				disObj.parent.addChild(this);
				var p:Point=disObj.localToGlobal(new Point(disObj.x,disObj.y));
				this.x=disObj.x;
				this.y=disObj.y;
				_txt.text=""+this.x+","+this.y;
				_txt.x=0;
				_txt.y=-_txt.height;
				
			}else
			{
				if(this.parent)
				{
					this.parent.removeChild(this);
				}
			}
		}
		
	}
}