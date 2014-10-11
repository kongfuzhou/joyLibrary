package com.joy.loader
{
	import com.joy.loader.interFaces.ILoader;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	/**
	 * @author zhouhonghui
	 * @date 2014-6-6
	 **/
	public class BaseLoader implements ILoader
	{
		private var _priority:int;
		protected var _urlOrByte:*;
		protected var _vars:Object;

		public var endCall:Function;
		public function BaseLoader(_urlOrByte:*="",vars:Object=null,priority:int=0)
		{
			this._urlOrByte=_urlOrByte;
			this._vars=vars;
			this._priority=priority;
			if(this._vars && this._vars.auto) //构建时自动下载
			{
				this.load(this._urlOrByte);
			}
			
		}
		/**
		 *队里加载优先级 越大越优先加载
		 * @return 
		 * 
		 */		
		public function get priority():int
		{
			return _priority;
		}
		
		public function set priority(value:int):void
		{
			_priority = value;
		}
		/**
		 * 获取加载字节进度 
		 * @return ProgressInfo
		 * 
		 */		
		public function getByteProgress():ProgressInfo
		{
			return new ProgressInfo();
		}
		
		/**
		 *统一处理io错误 
		 * @param e
		 * 
		 */		
		protected function ioErrorHandler(e:IOErrorEvent):void
		{
			trace("流错误::",this._urlOrByte,e.text);
		}
		
		protected function onComplete(e:Event):void
		{
			if(this.endCall!=null)
			{
				this.endCall();
			}
		}
		public function unLoad():void
		{
		}
		public function load(_urlOrByte:*=null):void
		{
			this._urlOrByte=_urlOrByte;
		}
		/**
		 * 一些属性设置 例如 {auto:true,onComplete:Function,dataFormat:URLLoaderDataFormat.TEXT}  
		 * @return 
		 * 
		 */		
		public function get vars():Object
		{
			return this._vars;
		}
		
		public function get urlOrByte():*
		{
			return this._urlOrByte;
		}
	}
}