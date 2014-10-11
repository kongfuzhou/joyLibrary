package com.joy.loader 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;

	/**
	 * 显示对象加载器
	 * @author kongfuzhou
	 * @date   2014/5/27 17:23:01
	 */
	public class DisplayLoader extends BaseLoader
	{
		private var loader:Loader;
		private var doMain:ApplicationDomain;
		/**
		 * 显示对象加载器
		 * @param urlOrByte 路径或者压缩的ByteArray
		 * @param vars  {onComplete:Func}
		 * 
		 */		
		public function DisplayLoader(urlOrByte:*=null,vars:Object=null,priority:int=0) 
		{
			super(urlOrByte,vars,priority);
			init();
		}
		
		private function init():void 
		{
			this.loader = new Loader();
		}
		public override function load(urlOrByte:*=null):void 
		{
			super.load(urlOrByte);
			if (urlOrByte is ByteArray) 
			{
				this.loader.loadBytes(urlOrByte);
			}else if (urlOrByte is String)
			{
				this.loader.load(new URLRequest(urlOrByte));
			}
			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
		}
		
		protected override function onComplete(e:Event):void 
		{
			super.onComplete(e);
			this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			this.doMain=this.loader.contentLoaderInfo.applicationDomain;
			if (this._vars && this._vars.onComplete!=null && (this._vars.onComplete is Function)) 
			{
				this._vars.onComplete(this.loader.content,this.doMain);				
			}
		}
		/**
		 *获取SWF里面的类元件 
		 * @param className
		 * @return 
		 * 
		 */		
		public function getClass(className:String):Class
		{
			var cs:Class;
			if(this.doMain)
			{
				cs=this.doMain.getDefinition(className) as Class;
			}
			return cs;
		}
		public override function getByteProgress():ProgressInfo
		{
			var info:ProgressInfo=new ProgressInfo();
			info.curLoaded=this.loader.loaderInfo.bytesLoaded;
			info.totalLoaded=this.loader.loaderInfo.bytesTotal;
			return info;
		}
		
	}

}