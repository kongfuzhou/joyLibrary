package com.joy.UI.calendar.view
{
	import com.joy.UI.calendar.Calendar;
	import com.joy.UI.calendar.cellRenderer.WeekCellRenderer;
	import com.joy.UIComponent.list.TileList;
	
	import flash.display.DisplayObjectContainer;

	/**
	 * @user zhouhonghui
	 * @date 2014-8-1 下午05:07:46
	 **/
	public class WeekView extends BaseView
	{
		public function WeekView(_parent:DisplayObjectContainer,calender:Calendar=null)
		{
			super(_parent,calender);
		}
		
		override protected function createChild():void
		{
			this._list=new TileList();
			this._list.setList(1,7);
			this._list.rendererClass=WeekCellRenderer;
			this.addChild(this._list);
			
				
		}
		
	}
}