package com.joy.loader.events
{
	import flash.events.Event;

	/**
	 * @author zhouhonghui
	 * @date 2014-6-10
	 **/
	public class LoaderEvent extends Event
	{
		public static var QUEUE_START:String="queue_start";
		public static var QUEUE_PROGRESS:String="queue_progress";
		public static var QUEUE_COMPLETE:String="queue_complete";
		
		public var data:Object;
		public function LoaderEvent(type:String,data:Object=null,bubbles:Boolean=false,cancelabel:Boolean=false)
		{
			super(type,bubbles,cancelabel);
			this.data=data;
		}
	}
}