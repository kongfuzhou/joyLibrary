package com.joy.UI.calendar
{
	import com.joy.UI.calendar.view.DayView;
	import com.joy.UI.calendar.view.WeekView;
	import com.joy.UI.calendar.view.YearView;
	import com.joy.manager.timer.TimerManage;
	import com.joy.util.DateUtil;
	
	import flash.display.Sprite;
	
	/**
	 * @user zhouhonghui
	 * @date 2014-8-1 下午04:52:58
	 **/
	public class Calendar extends Sprite
	{
		private var _weekView:WeekView;
		private var _dayView:DayView;
		private var _yearView:YearView;
		
		public var _curDate:Date;
		
		public function Calendar()
		{
			super();
			ceateChild();
		}
		
		private function ceateChild():void
		{
			var gap:Number=3;
			
			this._yearView=new YearView(this,this);
			this._yearView.show();			
			
			_weekView=new WeekView(this,this);
			_weekView.show();			
			_weekView.update(CalendarConfig.weekcn);
			_weekView.y=this._yearView.y+this._yearView.height+gap;
			
			_dayView=new DayView(this,this);
			_dayView.x=_weekView.x;
			_dayView.y=_weekView.y+_weekView.height+gap;
			_dayView.show();
			
			this._yearView.x=(this.width-this._yearView.width)/2;
			
		}
		
		/**
		 *更新显示的日期 
		 * @param date
		 * 
		 */		
		public function updateDay(date:Date):void
		{
			this._curDate=date;
			this._yearView.update(this._curDate);
			_dayView.update(getDayData(date));
		}
				
		/**
		 *获取月份显示的数据 
		 * @param nowDate
		 * @return 
		 * 
		 */		
		private function getDayData(nowDate:Date):Array
		{
			var len:int=42; //6*7 			
			var data:Array=new Array();				
			//上一个月的天数
			var preMonthDayNun:int=DateUtil.getPreMonthDayNum(nowDate.month,nowDate.fullYear);
			var nextMonthDayNum:int=DateUtil.getNextMonthDayNum(nowDate.month,nowDate.fullYear);
			var monthNum:int=DateUtil.getMonthDayNum(nowDate.month,nowDate.fullYear);
			var i:int;			
			var date1WeekDay:int=DateUtil.getMonthDate1Week(nowDate.month,nowDate.fullYear);
			
			var obj:Object;
			var preMonth:Date;
			if(nowDate.month==0)
			{
				preMonth=new Date(nowDate.fullYear,nowDate.month-1);
				preMonth.month=12;
				preMonth.fullYear=nowDate.fullYear-1;
			}
			//要从上月截取的天数
			for (i = 0; i < date1WeekDay; i++) 
			{
				preMonth=new Date(nowDate.fullYear,nowDate.month-1);
				preMonth.date=preMonthDayNun;
				obj={date:preMonth,day:preMonthDayNun};
				data.unshift(obj);
				preMonthDayNun--;				
			}
			var curMonth:Date;
			for (i = 1; i <= monthNum; i++) 
			{
				curMonth=new Date(nowDate.fullYear,nowDate.month);
				curMonth.date=i;
				obj={date:curMonth,day:i};
				data.push(obj);
			}
			//截取下个月的天数
			var n2:int=len-data.length;
			var nextMonth:Date;
			for (i = 1; i <= n2; i++) 
			{
				nextMonth=new Date(nowDate.fullYear,nowDate.month-1);
				nextMonth.date=i;
				obj={date:nextMonth,day:i};
				data.push(obj);
			}			
			return data;
		}
		
		
	}
}