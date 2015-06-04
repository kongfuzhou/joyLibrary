package com.joy.keyboardcontrol{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	public class KeyBoardControl {
		private var stage:Stage;
		private var _dict:Dictionary;
		private var _downList:Array;
		private var _upList:Array;
		
		private static var instance:KeyBoardControl;
		
		public function KeyBoardControl(stg:Singleton) {			
			// constructor code
			if (instance) 
			{
				throw new Error('singleton class!');
			}
		}
		
		public static function getInstance():KeyBoardControl 
		{
			if (!instance) 
			{
				instance = new KeyBoardControl(new Singleton());
			}
			return instance;
		}
		
		public function init(stage:Stage):void 
		{
			this.stage = stage;
			this._dict = new Dictionary(true);
			this._downList=[];
			this._upList=[];
			if (this.stage) 
			{
				this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
				this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpHandler);
			}
		}
		
		private function onKeyUpHandler(e:KeyboardEvent):void 
		{
			//this._dict[e.keyCode] = false;
			delete this._dict[e.keyCode];
			for each (var func:Function in this._upList) 
			{
				if(func!=null)
				{
					func(e.keyCode);
				}
			}
		}
		
		private function onKeyDownHandler(e:KeyboardEvent):void 
		{
			//trace('onKeyDownHandler e.keyCode='+e.keyCode);
			this._dict[e.keyCode] = true;
			for each (var func:Function in this._downList) 
			{
				if(func!=null)
				{
					func(e.keyCode);
				}
			}
			
		}
		public function addDownList(downFun:Function):void
		{
			this._downList.push(downFun);
		}
		
		public function addUpList(upFun:Function):void
		{
			this._upList.push(upFun);
		}
		
		
		/**
		 *是否按下了某个按键 
		 * @param keyCode
		 * @return 
		 * 
		 */		
		public function isKeyDown(keyCode:uint):Boolean 
		{
			if (this._dict[keyCode]!=null) 
			{
				return this._dict[keyCode];
			}
			
			return false;
		}
				
		/**
		 * 是否有按键按下 
		 * @return 
		 * 
		 */		
		public function isDown():Boolean 
		{
			return hasKeyDown();
		}
		
		private function hasKeyDown():Boolean
		{
			var flag:Boolean = false;
			for (var key:String in this._dict) 
			{				
				if(this._dict[key]==true)
				{
					flag=true;
					break;
				}				
			}			
			return flag;
		}
		
		public function destroy():void 
		{
			if (this.stage) 
			{
				this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
				this.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUpHandler);
			}
			instance = null;
			this._dict = null;
		}
		
		/*public function get dict():Dictionary 
		{
			return _dict;
		}*/
		

	}
	
}
class Singleton {
	
	public function Singleton():void 
	{
		
	}
	
}