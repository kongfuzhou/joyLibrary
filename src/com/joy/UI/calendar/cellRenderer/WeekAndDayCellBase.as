package com.joy.UI.calendar.cellRenderer
{
	import com.joy.UI.UICreator;
	import com.joy.UIComponent.cell.CellRenderer;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * @user zhouhonghui
	 * @date 2014-8-4 下午04:34:35
	 **/
	public class WeekAndDayCellBase extends CellRenderer
	{
		protected var _text:TextField;
		private var _w:Number=30;
		private var _h:Number=20;
		protected var fontSize:Number=20;
		
		public function WeekAndDayCellBase()
		{
			super();
			this.mouseChildren=false;
			this.buttonMode=true;
		}
		
		override protected function createView():void
		{
			this.graphics.beginFill(0xff0000,0);
			this.graphics.drawRect(0,0,_w,_h);
			this.graphics.endFill();
		}
		
		override public function set data(values:*):void
		{
			super.data=values;
			if(!_text)
			{
				_text=UICreator.getTextField("",0,0,_w,_h,new TextFormat(null,fontSize));
				_text.autoSize="center";
				this.addChild(_text);
			}
			_text.htmlText=values.toString();
		}
		
	}
}