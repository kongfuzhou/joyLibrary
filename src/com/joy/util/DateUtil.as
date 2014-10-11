package com.joy.util 
{
	/**
	 * 时间日期工具类
	 * ...
	 * @author kongfuzhou
	 * @date   2014/5/29 17:25:26
	 */
	public class DateUtil 
	{
		
		public function DateUtil() 
		{
			throw new Error("");
		}
		/**
		 * 把毫秒时间戳转换成时间字符串
		 * @param	milSec
		 * @param	format 返回的格式 (可选格式:-,cn,:,/)
		 * @return
		 */
		public static function milSecToStr(milSec:Number,format:String=":"):String
		{
			return secToStr(milSec/1000);
		}
		/**
		 * 把秒时间戳转换成时间字符串
		 * @param	sec
		 * @param	format 返回的格式 (可选格式:-,cn,:,/)
		 * @return
		 */
		public static function secToStr(sec:Number,format:String=":"):String 
		{
			var ret:String = "";
			
			var d:int;
			var h:int;
			var m:int;
			var s:int;
			
			var dSec:int = 86400; //1天的秒
			var hSec:int = 3600;
			var mSec:int = 60;
						
			d = sec / dSec;
			var dt:int = sec % dSec;
			
			h = dt / hSec;
			var ht:int = dt % hSec;
			
			m = ht / mSec;			
			s = ht % mSec;
			
			if (d>0) 
			{
				//天只有中文格式
				ret = tnToStr(d) + " 天 " + tnToStr(h) + "时" + tnToStr(m) + "分" + tnToStr(s) + "秒";
			}else
			{
				ret =  tnToStr(h) + ":" + tnToStr(m) + ":" + tnToStr(s);
				if (format=="cn") 
				{
					ret = tnToStr(h) + "时" + tnToStr(m) + "分" + tnToStr(s) + "秒";
				}else if (format!=":")
				{
					ret=ret.replace(/-/ig,format);
				}				
			}
			
			return ret;
		}
		/**
		 * 返回时间日期字符串
		 * @param	date   时间日期 (默认返回本机系统时间)
		 * @param   format 格式,也就是年月日数字间的分隔符 (可选格式:cn(中文) 或其他任意字符,例如：- (yy-mm-dd h:i:s ) 或 / (yy/mm/dd h:i:s)) ...
		 * @param   needs  需要时间日期的哪一部分 (full:全部,ym:只要年月,ymd:只要年月日,hms:只要时分秒)
		 * @return
		 */
		public static function getDate(date:Date=null,format:String="cn",needs:String="full"):String
		{
			date==null?date = new Date():"";
			var ret:String = "";			
			var yy:int=date.getFullYear();
			var mm:int=date.getMonth()+1;			
			var dd:int=date.getDate();
			
			var ymdAry:Array = [yy,mm,dd];
			
			var h:int=date.getHours();
			var m:int=date.getMinutes();
			var s:int = date.getSeconds() + 1;
			
			var hmsAry:Array = [h,m,s];
			
			if (format=="cn") 
			{
				
				ret = yy + "年" + tnToStr(mm) + "月" + tnToStr(dd) + "日 " + tnToStr(h) + "时" + tnToStr(m) + "分" + tnToStr(s) + "秒";
				if (needs != "full")
				{
					if(needs=="ym")
					{
						ret = yy + "年" + tnToStr(mm) + "月";
					}else if (needs=="ymd") 
					{
						ret = yy + "年" + tnToStr(mm) + "月" + tnToStr(dd) + "日";						
					}else if (needs == "hms")
					{
						ret = tnToStr(h) + "时" + tnToStr(m) + "分" + tnToStr(s) + "秒";
					}
				}
			}else
			{
				if (needs=="full") 
				{
					ret = ymdAry.join(format);
					ret += " " + hmsAry.join(":");
					
				}else
				{
					//var retAry:Array = ret.split(" ");
					if(needs=="ym")
					{
						ymdAry.pop();
						ret = ymdAry.join(format);
					}else if (needs=="ymd") 
					{
						ret = ymdAry.join(format);
						
					}else if (needs == "hms")
					{
						ret = hmsAry.join(":");
					}else
					{
						//传其他字符等同于 full
						ret = ymdAry.join(format);
						ret += " " + hmsAry.join(":");
					}
				}
				
			}
			
			return ret;
		}
		
		private static function tnToStr(t:int):String 
		{
			return t >= 10?t.toString():"0" + t;
		}
		
		/**
		 * 把类似[2014-06-17 23:00:00.000]这样的时间字符串转换成时间对象
		 * @param str 类似 [2014-06-17 23:00:00.000]的时间日期字符串
		 * @return 
		 * 
		 */		
		public static function dateStrToDate(str:String):Date
		{
			var ary:Array = str.split(" ");
			if (ary.length>1 && ary[1]!="" && ary[1]!=" ") //只能这样模糊判断是否包括年月日时分秒
			{
				var index:int = str.lastIndexOf(".");
				str = str.substring(0, index);//把秒数后面的小点去掉 				
			}				
			str = str.replace(/[-._]/ig, '/');	
			//至少包括月、日和年,例如:2014/06/12
			var date:Date = new Date(str);
			
			return date; 
		}
		/**
		 * 根据当前年份和月份获取上一月份的天数  
		 * @param curMonth
		 * @param fullYear
		 * @return 
		 * 
		 */			
		public static function getPreMonthDayNum(curMonth:int,fullYear:int):int
		{
			curMonth+=1;
			var preMonthDayNun:int=0;
			if(curMonth==1 || curMonth==8)
			{
				preMonthDayNun=31; //去年的12月 7月 31天 
			}else if(curMonth==3)
			{
				//2月份
				if(fullYear%100==0 || fullYear%4==0)
				{
					//闰年
					preMonthDayNun=29;
				}else
				{
					preMonthDayNun=28;
				}
			}else
			{
				if(curMonth<=7) 
				{
					//双数表示当前月为小月，上一个月为大月
					curMonth%2==0?preMonthDayNun=31:preMonthDayNun=30;					
				}else if(curMonth>7)
				{
					curMonth%2==0?preMonthDayNun=30:preMonthDayNun=31;	
				}
			}
			return preMonthDayNun;
		}
		
		/**
		 * 根据当前年份和月份获取上一月份的天数  
		 * @param curMonth
		 * @param fullYear
		 * @return 
		 * 
		 */			
		public static function getNextMonthDayNum(curMonth:int,fullYear:int):int
		{
			curMonth+=1;
			var nextMonthDayNun:int=0;
			if(curMonth==12 || curMonth==7)
			{
				nextMonthDayNun=31; //明年的1月 今年的8月 31天 
			}else if(curMonth==1)
			{
				//2月份
				if(isLeapYear(fullYear))
				{
					//闰年
					nextMonthDayNun=29;
				}else
				{
					nextMonthDayNun=28;
				}
			}else
			{
				if(curMonth<=7)
				{
					//当前月是偶数,下一个月是奇数,奇数月为31天
					curMonth%2==0?nextMonthDayNun=31:nextMonthDayNun=30;					
				}else if(curMonth>7) //
				{
					//当前月是偶数,下一个月是奇数,奇数月为30天
					curMonth%2==0?nextMonthDayNun=30:nextMonthDayNun=31;	
				}
			}
			return nextMonthDayNun;
		}
		/**
		 *根据年份和月份获取当月天数 
		 * @param curMonth
		 * @param fullYear
		 * @return 
		 * 
		 */		
		public static function getMonthDayNum(curMonth:int,fullYear:int):int
		{
			curMonth+=1;
			var monthNum:int=0;
			if(curMonth==2)
			{
				//2月份
				if(isLeapYear(fullYear))
				{
					//闰年
					monthNum=29;
				}else
				{
					monthNum=28;
				}
			}else if(curMonth<=7)
			{
				curMonth%2==0?monthNum=30:monthNum=31;
			}else if(curMonth>=8)
			{
				curMonth%2==0?monthNum=31:monthNum=30;
			}
			return monthNum;
		}
		/**
		 *获取某年的某月的1号是星期几 
		 * @param month
		 * @param fullYear
		 * @return 
		 * 
		 */		
		public static function getMonthDate1Week(month:int,fullYear:int):int
		{			
			var date:Date=new Date(fullYear,month,1);
			
			return date.day;
		}
		/**
		 * 判断某年是否是闰年 
		 * @param year
		 * @return 
		 * 
		 */		
		public static function isLeapYear(year:int):Boolean
		{
			var ret:Boolean=year%400==0 || year%4==0 && year%100!=0;
			return ret;
		}
		
		
	}

}