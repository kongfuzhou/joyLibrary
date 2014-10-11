package com.joy.UI.calendar
{
	/**
	 * 基础数据配置
	 * @user zhouhonghui
	 * @date 2014-8-4 上午10:49:03
	 **/
	public class CalendarConfig
	{
		public function CalendarConfig()
		{
		}
		public static function getWeekCnByDay(day:int):String
		{
			return "星期"+CalendarConfig.weekcn[day];
		}
		public static function get weekcn():Array
		{
			return ["日","一","二","三","四","五","六"];	
		}
		
	}
}