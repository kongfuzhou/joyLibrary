package com.joy.manager.timer
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	/**
	 * @user zhouhonghui
	 * @date 2014-8-4 上午11:33:15
	 **/
	public class TimerManage
	{
		private var _map:Dictionary=new Dictionary();
		private var _timer:Timer;
		private var _nowDate:Date;
		
		private static var _instance:TimerManage=new TimerManage();
		public function TimerManage()
		{
			if(_instance)
			{
				throw new Error("");
			}
			init();
		}

		public function get nowDate():Date
		{
			if(_nowDate==null)
			{
				_nowDate=new Date();
			}
			return _nowDate;
		}

		public function set nowDate(value:Date):void
		{
			_nowDate = value;
		}

		private function init():void
		{
			this._timer=new Timer(1000);
			this._timer.addEventListener(TimerEvent.TIMER,onTimerRun);
		}
		
		protected function onTimerRun(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			this._nowDate.time+=1000;
			for (var key:String in this._map) 
			{
				this._map[key]();
			}
			
		}
		
		public static function get instance():TimerManage
		{
			return _instance;
		}
		/**
		 *判断某个日期是否是今天 
		 * @param date
		 * @return 
		 * 
		 */		
		public function isToday(date:Date):Boolean
		{
			var flag:Boolean=(date.fullYear==this._nowDate.fullYear &&
								date.month==this._nowDate.month && date.date==this._nowDate.date);
			return flag;
		}
		/**
		 * 添加一个计时器 
		 * @param key
		 * @param handler
		 * 
		 */		
		public function add(key:String,handler:Function):void
		{
			if(TimerKeys.isKeyExist(key))
			{
				this._map[key]=handler;
			}
			
		}
		/**
		 *删除一个计时器 
		 * @param key
		 * 
		 */		
		public function remove(key:String):void
		{
			this._map[key]=null;
		}
		public function startup():void
		{
			if(this._timer && this._timer.running)
			{
				this._timer.reset();				
			}
			this._timer.start();
			this._nowDate=new Date();
		}
		public function shutDown():void
		{
			if(this._timer!=null && this._timer.running)
			{
				this._timer.stop();
			}
		}

	}
}