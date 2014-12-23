package com.joy.manager.timer
{
	/**
	 * @user zhouhonghui
	 * @date 2014-8-4 上午11:36:20
	 **/
	public class TimerKeys
	{		
		
		public static var NOW_DATE:String="now_date";
		
		public function TimerKeys()
		{			
			
		}
		public static  function get keysList():Array
		{
			return [NOW_DATE];
		}
		public static function isKeyExist(key:String):Boolean
		{
			return keysList.indexOf(key)>-1;
		}
		
	}
}