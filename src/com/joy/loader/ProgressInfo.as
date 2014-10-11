package com.joy.loader
{
	/**
	 * 加载进度信息 
	 * @user zhouhonghui
	 * @date 2014-8-12 上午11:58:11
	 **/
	public class ProgressInfo
	{
		private var _curLoaded:Number;
		private var _totalLoaded:Number;
		
		public function ProgressInfo(_cur:Number=0,_total:Number=0)
		{
			this._curLoaded=_cur;
			this._totalLoaded=_total;
		}

		public function get totalLoaded():Number
		{
			return _totalLoaded;
		}

		public function set totalLoaded(value:Number):void
		{
			_totalLoaded = value;
		}

		public function get curLoaded():Number
		{
			return _curLoaded;
		}

		public function set curLoaded(value:Number):void
		{
			_curLoaded = value;
		}

	}
}