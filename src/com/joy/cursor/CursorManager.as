package com.joy.cursor
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	/**
	 * 鼠标指针管理类,或者说鼠标跟随
	 * @user newlearn
	 * @date 2014-8-13 下午03:48:39
	 **/
	public class CursorManager
	{
		
		private static var _instance:CursorManager;
		
		private var _upStyleCursor:DisplayObject;
		private var _downStyleCursor:DisplayObject;
		private var _curCursor:DisplayObject;
		private var _cursorParent:DisplayObjectContainer;
		private var _stage:Stage;
		
		private var _hideNormal:Boolean=true;
		public function CursorManager(sgt:Sigleton)
		{
			if(_instance)
			{
				throw new Error("");
			}
			
		}
		/**
		 *是否隐藏系统光标 T隐藏(默认) 
		 * @return 
		 * 
		 */		
		public function get hideNormal():Boolean
		{
			return _hideNormal;
		}

		public function set hideNormal(value:Boolean):void
		{
			_hideNormal = value;
		}

		public static function get instance():CursorManager
		{
			if(!_instance)
			{
				_instance=new CursorManager(new Sigleton());
			}			
			return _instance;
		}
		/**
		 *光标的父层,不设置默认为stage 
		 * @param value
		 * 
		 */		
		public function set cursorParent(value:DisplayObjectContainer):void
		{
			_cursorParent = value;
		}

		/**
		 * 鼠标按下的光标形状 (先设置upStyleCursor再设置该属性)
		 * @return 
		 * 
		 */		
		public function get downStyleCursor():DisplayObject
		{
			return _downStyleCursor;
		}

		public function set downStyleCursor(value:DisplayObject):void
		{
			_downStyleCursor = value;
			
		}
		/**
		 * 鼠标弹起的光标形状 (重置该属性时会将downStyleCursor设置为NUll)
		 * @return 
		 * 
		 */		
		public function get upStyleCursor():DisplayObject
		{
			return _upStyleCursor;
		}

		public function set upStyleCursor(value:DisplayObject):void
		{
			this.curCursor=null;
			_upStyleCursor = value;
			this._curCursor=_upStyleCursor;
			this._downStyleCursor=null;
			
		}
		/**
		 *初始化
		 * @param stage
		 * 
		 */		
		public function init(stage:Stage):void
		{
			// TODO Auto Generated method stub
			this._stage=stage;
			this._stage.addEventListener(MouseEvent.MOUSE_MOVE,onMoveHandler);
			this._stage.addEventListener(MouseEvent.MOUSE_UP,onUpHandler);
			this._stage.addEventListener(MouseEvent.MOUSE_DOWN,onDownHandler);			
		}
		
		protected function onDownHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(this._downStyleCursor)
			{
				this.curCursor=this._downStyleCursor;
			}
			
		}
		
		protected function onUpHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(this._curCursor!==this._upStyleCursor)
			{
				this.curCursor=this._upStyleCursor;
			}
			
		}
		/**
		 *显示自定义指针 
		 * 
		 */		
		public function show():void
		{
			if(this._upStyleCursor)
			{
				if(this._hideNormal)
				{
					Mouse.hide();
				}				
				this.curCursor=this._upStyleCursor;
			}
					
		}
		/**
		 *隐藏自定义指针 
		 * 
		 */	
		public function hide():void
		{
			Mouse.show();
			this.curCursor=null;
		}
		/**
		 *销毁方法(执行过该方法后需要重新init和设置皮肤才能用) 
		 * 
		 */		
		public function destroy():void
		{
			this._stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMoveHandler);
			this._stage.removeEventListener(MouseEvent.MOUSE_UP,onUpHandler);
			this._stage.removeEventListener(MouseEvent.MOUSE_DOWN,onDownHandler);
			this.curCursor=null;
			this._cursorParent=null;
			this._downStyleCursor=null;
			this._upStyleCursor=null;
			_instance=null;
		}
		
		protected function onMoveHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(this._curCursor)
			{
				this.setCurStylePos();				
			}
		}
		
		private function setCurStylePos():void
		{
			this._curCursor.x=this._stage.mouseX;
			this._curCursor.y=this._stage.mouseY;
		}
		
		private function set curCursor(value:DisplayObject):void
		{
			if(this._curCursor && this._curCursor.parent)
			{
				this._curCursor.parent.removeChild(this._curCursor);
			}
			this._curCursor=value;
			if(this._curCursor!=null)
			{
				if(this._cursorParent)
				{
					this._cursorParent.addChild(this._curCursor);
				}else
				{
					this._stage.addChild(this._curCursor);
				}
				this.setCurStylePos();
				
			}else
			{
				this._downStyleCursor=null;
				this._upStyleCursor=null;
			}
		}
		
	}
}
class Sigleton{
	
	public function Sigleton():void
	{
		
	}

}