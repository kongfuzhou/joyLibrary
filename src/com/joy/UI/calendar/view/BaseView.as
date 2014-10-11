package com.joy.UI.calendar.view
{
	import com.joy.UI.calendar.Calendar;
	import com.joy.UIComponent.interFaces.IData;
	import com.joy.UIComponent.interFaces.IUI;
	import com.joy.UIComponent.interFaces.IView;
	import com.joy.UIComponent.list.BaseList;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	/**
	 * @user zhouhonghui
	 * @date 2014-8-1 下午05:05:58
	 **/
	public class BaseView extends Sprite implements IView,IData
	{
		protected var _data:*;
		protected var _parent:DisplayObjectContainer
		protected var _list:BaseList;
		
		protected var _calender:Calendar;
		
		public function BaseView(_parent:DisplayObjectContainer,calender:Calendar=null)
		{
			this._parent=_parent;
			this._calender=calender;
			createChild();
		}
		/**
		 * 所属的calender创建者（主要用于组件内部相互调用)
		 * @return 
		 * 
		 */		
		public function get calender():Calendar
		{
			return _calender;
		}

		public function set calender(value:Calendar):void
		{
			_calender = value;
		}

		protected function createChild():void
		{
			_list=new BaseList();
		}
		/**
		 * 渲染视图内容 
		 * 
		 */		
		public function update(params:Object):void
		{
			this._list.dataProvider=params as Array;
		}
		
		public function get data():*
		{
			return _data;
		}
		public function set data(values:*):void
		{
			_data=values;
		}
		/**显示**/
		public function show():void
		{
			this._parent.addChild(this);
		}
		/**隐藏**/
		public function hide():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}

	}
}