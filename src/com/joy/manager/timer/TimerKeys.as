package com.joy.manager.timer
{
	/**
	 * @user zhouhonghui
	 * @date 2014-8-4 上午11:36:20
	 **/
	public class TimerKeys
	{		
		private static var _keysList:Array=[NOW_DATE];
		public static var NOW_DATE:String="now_date";
		
		public function TimerKeys()
		{			
			
		}
		public static  function addKey(key:String):void
		{			
			if (_keysList.indexOf(key)==-1) 
			{
				_keysList.push(key);
			}
		}
		
		public static function isKeyExist(key:String):Boolean
		{
			return _keysList.indexOf(key)>-1;
		}
		
	}
}