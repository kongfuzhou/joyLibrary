package com.joy.loader
{
	import com.joy.loader.events.LoaderEvent;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * 队列加载器,一个加载完再加载另外一个
	 * @author zhouhonghui
	 * @date 2014-6-10
	 **/
	public class QueueLoader extends EventDispatcher
	{
		public static var _instance:QueueLoader;
		private var queue:Array;
		private var isStart:Boolean=false;
		private var _max:int=10;
		private var _total:int;
		private var _current:int=0;
		private var urlMap:Dictionary;
		private var nameMap:Dictionary;
		private var idMap:Dictionary;
		private var _isComplete:Boolean=false;
		//已经加载完成的
		private var isLoadedList:Array;
		private var curloader:BaseLoader
		
		public function QueueLoader()
		{
			if(_instance)
			{
				throw new Error("");
			}
			init();
		}
		
		private function init():void
		{
			urlMap=new Dictionary();
			nameMap=new Dictionary();
			idMap=new Dictionary();
			isLoadedList=[];
		}
		
		public static function get instance():QueueLoader
		{
			if(!_instance)
			{
				_instance=new QueueLoader();
			}
			
			return _instance;
		}
		/**
		 * 添加一个加载器 
		 * @param loader
		 * @return 
		 * 
		 */		
		public function add(loader:BaseLoader):BaseLoader
		{
			if(!queue)
			{
				queue=[];
			}else if(this._total<=this._max)
			{
				this._total++;
				queue.push(loader);
				queue.sortOn("priority",Array.DESCENDING);
				this.urlMap[loader.urlOrByte]=loader;
				if(loader.vars)
				{
					loader.vars.id?this.idMap[loader.vars.id]=loader:"";
					loader.vars.name?this.nameMap[loader.vars.name]=loader:"";
				}
				
				return loader;
			}
			
			return null;
		}
		/**
		 *开始加载 		 
		 */		
		public function start():void
		{
			if(queue && queue.length>0) //队里没加载完
			{				
				
				curloader=queue.shift() as BaseLoader;
				curloader.endCall=endCall;
				curloader.load(curloader.urlOrByte);
				if(!isStart) //加载第一个
				{
					isStart=true;
					_isComplete=false;
					this.dispatchEvent(new LoaderEvent(LoaderEvent.QUEUE_START,{max:this._total,current:this._current}));
				}
				this._current++;
				this.dispatchEvent(new LoaderEvent(LoaderEvent.QUEUE_PROGRESS,{max:this._total,current:this._current}));
			}else
			{
				if(isStart) //完成加载
				{
					_isComplete=true;
					isStart=false;
					this.isLoadedList.push(_isComplete);
					this.dispatchEvent(new LoaderEvent(LoaderEvent.QUEUE_COMPLETE,{max:this._total,current:this._current}));
				}
				
			}
		}
		/**
		 * 获取一个Laoder 
		 * @param urlOrIdOrName url地址或id或名
		 * @return 
		 * 
		 */		
		public function getLoader(urlOrIdOrName:*):BaseLoader
		{
			if(this.urlMap[urlOrIdOrName])
			{
				return this.urlMap[urlOrIdOrName] as BaseLoader;
			}
			if(this.idMap[urlOrIdOrName])
			{
				return this.idMap[urlOrIdOrName] as BaseLoader;
			}
			if(this.nameMap[urlOrIdOrName])
			{
				return this.nameMap[urlOrIdOrName] as BaseLoader;
			}
			return null;
		}
		/**
		 *根据链接获取Loader 
		 * @param url
		 * @return 
		 * 
		 */		
		public function getLoaderByUrl(url:String):BaseLoader
		{
			return this.urlMap[url] as BaseLoader;
		}
		/**
		 *根据ID获取Loader 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getLoaderById(id:*):BaseLoader
		{
			return this.idMap[id] as BaseLoader;
		}
		/**
		 *根据名称获取Loader 
		 * @param name
		 * @return 
		 * 
		 */		
		public function getLoaderByName(name:String):BaseLoader
		{
			return this.nameMap[name] as BaseLoader;
		}
		
		public function clear():void
		{
			var len:int=queue.length;
			var loader:BaseLoader;
			for (var i:int = 0; i < len; i++) 
			{
				loader=queue[i];
				loader.unLoad();
			}
			isStart=false;
			queue=[];
			init();
		}
		private function endCall():void
		{
			start();
		}
		
		
	}
}