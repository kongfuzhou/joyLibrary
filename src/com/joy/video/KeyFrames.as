package com.joy.video 
{
	/**
	 * ...
	 * @author kongfuzhou
	 * @date   2014/5/26 19:45:57
	 */
	public class KeyFrames 
	{
		protected var _times :Array;
		protected var _filepositions :Array;
		public function KeyFrames() 
		{
			
		}
		
		public function setData(data:Object):void 
		{
			for (var name:String in data) 
			{
				if (this.hasOwnProperty(name)) 
				{
					this[name] = data[name];
				}
			}
		}
		
		public function get times():Array 
		{
			return _times;
		}
		
		public function set times(value:Array):void 
		{
			_times = value;
		}
		
		public function get filepositions():Array 
		{
			return _filepositions;
		}
		
		public function set filepositions(value:Array):void 
		{
			_filepositions = value;
		}
		
	}

}