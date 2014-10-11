package com.joy.loader
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	/**
	 * 主要加载文本、二进制类型数据
	 * @author zhouhonghui
	 * @date 2014-6-6
	 **/
	public class JURLoader extends BaseLoader
	{
		private var urlLoader:URLLoader;
		/**
		 * 主要加载文本、二进制类型数据
		 * @param urlOrByte 路径或者二进制文件
		 * @param vars		一些属性设置 例如 {auto:true,onComplete:Function,dataFormat:URLLoaderDataFormat.TEXT} 
		 * 
		 */		
		public function JURLoader(url:*=null,vars:Object=null,priority:int=0)
		{
			super(url,vars,priority);		
			
		}
				
		public override function load(url:*=null):void
		{
			super.load(url);
			if(!(this.urlOrByte is String))
			{
				throw new Error("not a available url");
			}
			
			if(!this.urlLoader)
			{
				this.urlLoader=new URLLoader();				
				this.vars && this.vars.dataFormat?this.urlLoader.dataFormat=this.vars.dataFormat:"";
				this.urlLoader.load(new URLRequest(this.urlOrByte));
				this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
				this.urlLoader.addEventListener(Event.COMPLETE,onComplete);
			}
			
		}
		public override function unLoad():void
		{
			removeEvent();
			this.urlLoader.close();
			
		}
		protected override function onComplete(e:Event):void
		{
			super.onComplete(e);
			this.removeEvent();
			if(this.vars && this.vars.onComplete!=null && (this.vars.onComplete is Function))
			{
				this.vars.onComplete(this.urlLoader.data)
			}
		}
		
		private function removeEvent():void
		{
			this.urlLoader.removeEventListener(Event.COMPLETE,onComplete);
			this.urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
		}
		
		public override function getByteProgress():ProgressInfo
		{
			var info:ProgressInfo=new ProgressInfo();
			info.curLoaded=this.urlLoader.bytesLoaded;
			info.totalLoaded=this.urlLoader.bytesTotal;
			return info;
		}
		
	}
}