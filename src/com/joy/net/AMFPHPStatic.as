package com.joy.net
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	/**
	 * ...
	 * @author kongfuzhou
	 * @date 2014/5/6 10:42:55
	 */
	public class AMFPHPStatic 
	{
		public static var url:String = "http://127.0.0.1/Amfphp2.2/Amfphp/";
		public static var entries:String = "Entries/enter";

		private var _onResult:Function;
		private var net:NetConnection;
		private static var _instance:AMFPHPStatic=new AMFPHPStatic();
		public function AMFPHPStatic() 
		{
			if (_instance) 
			{
				throw new Error();
			}
			init();
		}
		private static function get instance():AMFPHPStatic 
		{
			return _instance;
		}
		private function init():void 
		{
			net = new NetConnection();			
		}
		
		public function connect(classAndMethod:String,args:*,onResult:Function=null):void 
		{
			this._onResult = onResult;
			//var net:NetConnection = new NetConnection();
			//net.close();
			net.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);			
			net.connect(url);
			net.objectEncoding = ObjectEncoding.AMF3;
			net.call(classAndMethod,new Responder(onResultHandler, onStatusHandler),args);
			//net.call(classAndMethod,new Responder(onResultHandler, onStatusHandler));
		}
		
		private function onNetStatus(e:NetStatusEvent):void 
		{
			/*trace("onNetStatus .", e.info);
			for (var name:String in e.info) 
			{
				trace(name ,e.info[name]);
			}*/
		}
		private function onResultHandler(result:*):void 
		{
			//trace("onResultHandler ", result.data);
			
			//trace("onResultHandler ");
			if (this._onResult!=null) 
			{
				this._onResult(result);
			}
		}
		
		private function onStatusHandler(status:*):void 
		{
			trace("onStatus .");
		}
		
		public static function call(classAndMethod:String,args:*,onResult:Function=null):void 
		{
			AMFPHPStatic.instance.connect(classAndMethod, args, onResult);
		}
		
		
		
		
	}

}