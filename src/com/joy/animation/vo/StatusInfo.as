package com.joy.animation.vo 
{
	/**
	 * ...
	 * @author kongfuzhou
	 * @date   2014/6/10 9:56:25
	 */
	public class StatusInfo 
	{
		private var _stf:int;
		private var _edf:int;
		private var _spf:int;
		public function StatusInfo() 
		{
			
		}
		public function set data(vlaues:Object):void 
		{
			for (var pro:String in vlaues) 
			{
				if (this.hasOwnProperty(pro))
				{
					this[pro] = vlaues[pro];
				}
			}
		}
		/**
		 * 状态的开始帧
		 */
		public function get stf():int 
		{
			return _stf;
		}
		
		public function set stf(value:int):void 
		{
			_stf = value;
		}
		/**
		 * 状态结束帧
		 */
		public function get edf():int 
		{
			return _edf;
		}
		
		public function set edf(value:int):void 
		{
			_edf = value;
		}
		/**
		 * 状态所占的帧数
		 */
		public function get spf():int 
		{
			return _spf;
		}
		
		public function set spf(value:int):void 
		{
			_spf = value;
		}
		
	}

}