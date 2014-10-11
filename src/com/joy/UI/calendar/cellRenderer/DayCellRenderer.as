package com.joy.UI.calendar.cellRenderer
{
	import com.joy.UI.UICreator;
	import com.joy.UIComponent.cell.CellRenderer;
	import com.joy.manager.timer.TimerManage;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * @user zhouhonghui
	 * @date 2014-8-4 下午03:06:05
	 **/
	public class DayCellRenderer extends WeekAndDayCellBase
	{
		private var _font:String="黑体";
		public function DayCellRenderer()
		{
			super();
		}
		override public function set data(values:*):void
		{
			this._data=values;
			if(!_text)
			{
				_text=UICreator.getTextField("",0,0,30,30,new TextFormat(_font,20,0x0000ff));
				_text.autoSize="center";
				this.addChild(_text);
			}
			
			if(this.isToday())
			{
				_text.defaultTextFormat=new TextFormat(_font,fontSize,0xff0000);
			}
			_text.text=this._data.day.toString();
			
		}
		public override function set selected(value:Boolean):void
		{
			super.selected=value;
			if(!this.isToday())
			{
				if(value)
				{
					_text.defaultTextFormat=new TextFormat(_font,fontSize,0x00ff00);
					_text.text=this._data.day.toString();
				}else
				{
					_text.defaultTextFormat=new TextFormat(_font,fontSize,0x0000ff);
					_text.text=this._data.day.toString();
				}
				
			}
			
		}
		
		private function isToday():Boolean
		{
			var now:Date=TimerManage.instance.nowDate;
			var date:Date=this._data.date;
			return now.fullYear==date.fullYear &&
				now.month==date.month && 
				now.date==this._data.day;
		}
		
		
	}
}