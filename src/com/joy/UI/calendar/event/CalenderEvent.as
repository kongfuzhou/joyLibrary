package com.joy.UI.calendar.event
{
	import flash.events.Event;
	
	/**
	 * @user zhouhonghui
	 * @date 2014-8-5 下午03:47:04
	 **/
	public class CalenderEvent extends Event
	{
		/**选择某个日期**/
		public static const SELECT_DATE:String="select_date";
		private var _calenderInfo:Object;
		public function CalenderEvent(type:String,calenderInfo:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_calenderInfo=calenderInfo;
		}

		public function get calenderInfo():Object
		{
			return _calenderInfo;
		}

		public function set calenderInfo(value:Object):void
		{
			_calenderInfo = value;
		}

	}
}