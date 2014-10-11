package  com.joy.net
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLVariables;
	import flash.net.URLLoader;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author zhouhonghui
	 */
	public class HttpRequestStatic 
	{
		
		private static var _instance:HttpRequestStatic;
		private var _onLinking:Boolean=false;
		private var callBack:Function;
		private var urlLoader:URLLoader;
		
		public function HttpRequestStatic() 
		{
			if (_instance) 
			{
				throw new Error("单例!");
			}
		}
		
		static public function get instance():HttpRequestStatic 
		{
			if (!_instance) 
			{
				_instance = new HttpRequestStatic();
			}
			return _instance;
		}
		
		public function get onLinking():Boolean 
		{
			return _onLinking;
		}
		
		/**
		 * http请求
		 * @param	url      要请求的http页面地址
		 * @param	vars	 要传过去的参数
		 * @param	method	 使用的请求方式(默认post)
		 * @param	callBack 请求成功后返回
		 */
		public function request(url:String,vars:Object,callBack:Function=null,method:String="post"):void 
		{
			if (this._onLinking) 
			{
				return;
			}
			this._onLinking = true;
			this.callBack = callBack;
			if (!urlLoader) 
			{
				urlLoader = new URLLoader();
			}
			var urlVars:URLVariables = new URLVariables();
			for (var name:String in vars) 
			{
				urlVars[name] = vars[name];
			}
			var req:URLRequest = new URLRequest(url);
			//req.contentType = "application/x-www-form-urlencoded";
			req.method = method;
			//req.contentType = "charset=utf-8";
			req.data = urlVars;
			//req.requestHeaders = [new URLRequestHeader("SOAPAction", "charset=utf-8")];
			//urlLoader.dataFormat = URLLoaderDataFormat.BINARY; 
			urlLoader.load(req);
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
			//urlLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onResponseStatus);
		}
		
		private function onResponseStatus(e:HTTPStatusEvent):void 
		{
			trace("onResponseStatus=",e.status);
		}
		
		private function onHttpStatus(e:HTTPStatusEvent):void 
		{
			trace("onHttpStatus=",e.status);
		}
		
		private function onComplete(e:Event):void 
		{
			this._onLinking = false;			
			var data:ByteArray = urlLoader.data as ByteArray;
			trace(" HttpRequest onComplete=",data, urlLoader.data);			
			if (this.callBack!=null) 
			{
				this.callBack(data);
			}
		}
		
		
		
	}
	
}