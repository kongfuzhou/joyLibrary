package com.joy.debug
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @user zhouhonghui
	 * @date 2014-8-26 上午11:56:58
	 **/
	public class DebugItem extends Sprite
	{
		private var _txt:TextField;
		private var _field:*;
		private var _id:int;
		private var _info:DebugInfo;
		
		public function DebugItem()
		{
			super();
			initItem();
			
		}
		
		public function get info():DebugInfo
		{
			return _info;
		}

		public function set info(value:DebugInfo):void
		{
			_info = value;
			this.field=_info.field;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
			
		}

		private function initItem():void
		{
			// TODO Auto Generated method stub
			this.buttonMode=true;
			this.mouseChildren=false;
			this.addEventListener(MouseEvent.CLICK,onClick);
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			JoyDebugSys.instance.dispatchEvent(new DebugEvent(DebugEvent.CANCEL_SELECT_ITEM,this));
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			JoyDebugSys.instance.dispatchEvent(new DebugEvent(DebugEvent.SELECT_DEBUG_ITEM,this));
		}
		
		protected function onClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub			
			JoyDebugSys.instance.dispatchEvent(new DebugEvent(DebugEvent.CLICK_DEBUG_ITEM,this));
		}
		
		private function get field():*
		{
			return _field;
		}

		private function set field(value:*):void
		{
			_field = value;
			var _name:String;
			if(_field is String)			
			{
				_name=_field as String;
			}else
			{
				_name=getQualifiedClassName(_field);
				var arr:Array=_name.split("::");
				arr.length>1?_name=arr[1]:"";
				this._info.isParent?_name+="_容器":"";
				this._info.isSub?_name+="_内容":"";
				_name+=" ->>";
				
			}
			this.text=_name;			
			setBgAndPos();
		}
		
		private function set text(val:String):void
		{
			if(!_txt)
			{
				_txt=new TextField();
				_txt.selectable=false;
				_txt.autoSize="left";
				this.addChild(_txt);
			}
			_txt.text=val;
		}
		
		private function setBgAndPos():void
		{
			// TODO Auto Generated method stub
			this.graphics.beginFill(JoyDebugSys.itemBgColor);
			this.graphics.drawRect(0,0,this._txt.width+10,this._txt.height+10);
			this.graphics.endFill();
			this._txt.x=(this.width-this._txt.width)/2;
			this._txt.y=(this.height-this._txt.height)/2;
		}		
		
		public function destroy():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
			this.removeEventListener(MouseEvent.CLICK,onClick);
			this.removeEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
		}
		

	}
}