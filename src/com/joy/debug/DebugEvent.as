package com.joy.debug
{
	import flash.events.Event;
	
	/**
	 * @user zhouhonghui
	 * @date 2014-8-26 下午02:40:06
	 **/
	public class DebugEvent extends Event
	{
		public static const CLICK_DEBUG_ITEM:String="click_debug_item";
		public static const SELECT_DEBUG_ITEM:String="select_debug_item";
		public static const CANCEL_SELECT_ITEM:String="cancel_select_item";
		
		private var _item:DebugItem;
		public function DebugEvent(type:String,item:DebugItem, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_item=item;
		}

		public function get item():DebugItem
		{
			return _item;
		}

	}
}