package com.joy.UIComponent.events
{
	import flash.events.Event;
	
	/**
	 * 数字组件的数字改变
	 * @user zhouhonghui
	 * @date 2014-8-8 上午10:38:46
	 **/
	public class NumbericEvent extends Event
	{
		
		public static var NUMBER_CHANGE:String="number_change";
		
		public function NumbericEvent(type:String,num:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}