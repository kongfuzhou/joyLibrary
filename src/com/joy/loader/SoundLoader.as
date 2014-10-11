package com.joy.loader
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;

	/**
	 * MP3加载器
	 * @author zhouhonghui
	 * @date 2014-6-10
	 **/
	public class SoundLoader extends BaseLoader
	{
		private var sound:Sound;
		/**
		 * MP3加载器
		 * @param url     路径
		 * @param vars	  属性设置{autoPlay:false}
		 * @param priority
		 * 
		 */		
		public function SoundLoader(url:*="",vars:Object=null,priority:int=0)
		{
			super(url,vars,priority);
		}
		public override function load(url:*=null):void
		{
			super.load(url);
			sound=new Sound();
			sound.load(new URLRequest(this._urlOrByte));
			sound.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
			sound.addEventListener(Event.COMPLETE,onComplete);
		}
		public override function unLoad():void
		{
			this.removeEvent();
			sound.close();			
		}
		protected override function onComplete(e:Event):void
		{
			super.onComplete(e);
			this.removeEvent();
			if(this.vars)
			{
				for(var pro:String in this._vars)
				{
					if(this.sound.hasOwnProperty(pro))
					{
						this.sound[pro]=this._vars[pro];
					}
				}
				this.vars.autoPlay?sound.play():"";
				this.vars.onComplete?this.vars.onComplete(sound):"";
			}
		}
		private function removeEvent():void
		{
			sound.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
			sound.removeEventListener(Event.COMPLETE,onComplete);
		}
		
		public override function getByteProgress():ProgressInfo
		{
			var info:ProgressInfo=new ProgressInfo();
			info.curLoaded=this.sound.bytesLoaded;
			info.totalLoaded=this.sound.bytesTotal;
			return info;
		}
		
	}
}