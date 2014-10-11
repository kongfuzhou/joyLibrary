package com.joy.UI.calendar.view
{
	import com.joy.UI.calendar.Calendar;
	import com.joy.UI.calendar.cellRenderer.DayCellRenderer;
	import com.joy.UI.calendar.cellRenderer.WeekCellRenderer;
	import com.joy.UI.calendar.event.CalenderEvent;
	import com.joy.UIComponent.cell.CellRenderer;
	import com.joy.UIComponent.list.TileList;
	
	import flash.display.DisplayObjectContainer;

	/**
	 * @user zhouhonghui
	 * @date 2014-8-1 下午05:07:23
	 **/
	public class DayView extends BaseView
	{
		public function DayView(_parent:DisplayObjectContainer,calender:Calendar=null)
		{
			super(_parent,calender);
		}
		
		override protected function createChild():void
		{
			this._list=new TileList();
			this._list.setList(6,7);
			this._list.rendererClass=DayCellRenderer;
			this.addChild(this._list);			
			this._list.listClickHandler=listClick;
		}
		
		override public function update(params:Object):void
		{
			this._list.dataProvider=params as Array;
		
		}
		
		private function listClick(cell:CellRenderer):void
		{
			if(cell && this._calender)
			{
				//trace(cell.data.day,cell.data.date);
				this._calender.dispatchEvent(new CalenderEvent(CalenderEvent.SELECT_DATE,cell.data));
			}
			
		}
		
		
		
	}
}