package com.joy.debug
{
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.Singleton;
	
	/**
	 * 调试系统(方便各个开发者之间寻找不是自己写的模块在是哪个类)
	 * @user zhouhonghui
	 * @date 2014-8-26 上午11:32:06
	 **/
	public class JoyDebugSys extends Sprite
	{
		/**生成的信息背景颜色**/
		public static var itemBgColor:uint=0xdddddd;
		/**显示该系统的快捷键码**/
		public static var showKeyCode:uint=Keyboard.ESCAPE;
		/**选择组合快捷键**/
		public static var selectKeyCode:uint=Keyboard.ALTERNATE;
		
		private var _stage:Stage;
		private var _isAltDown:Boolean;
		private var _curInfoData:Array; //列表信息
		private var _itemList:Array; //显示在界面的信息
		private var _container:Sprite;
		private var _curClick:*;
		
		private var _isShow:Boolean=false;
		private var _selectedItem:DebugSelectItem;
		
		
		private var _selectKey:Boolean=true;
		
		private static var _instance:JoyDebugSys;
		
		public function JoyDebugSys(sgt:Singleton)
		{
			super();
			if(_instance)
			{
				throw new Error("DebugSys is Singleton!");
			}
			
		}
		/**
		 * 选择点击时 是否需要配合快捷键 
		 * @return 
		 * 
		 */				
		public function get selectKey():Boolean
		{
			return _selectKey;
		}

		public function set selectKey(value:Boolean):void
		{
			_selectKey = value;
		}

		public static function get instance():JoyDebugSys
		{
			if(!_instance)
			{
				_instance=new JoyDebugSys(new Singleton());
			}
			return _instance;
		}
		
		public function init(stage:Stage):void
		{
			if(this._stage==null)
			{
				this._stage=stage;
				_selectedItem=new DebugSelectItem();
				resetInfoData();
				this._itemList=[];
				_container=new Sprite();
				this.addChild(_container);
				this.addEvents();
			}
			
		}
		
		private function addEvents():void
		{
			this._stage.addEventListener(MouseEvent.CLICK,onClickStage);
			this._stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			this._stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			
			this.addEventListener(DebugEvent.CLICK_DEBUG_ITEM,onItemClick);
			this.addEventListener(DebugEvent.SELECT_DEBUG_ITEM,selectItem);
			this.addEventListener(DebugEvent.CANCEL_SELECT_ITEM,cancleSelectItem);
		}
		
		protected function cancleSelectItem(event:Event):void
		{
			// TODO Auto-generated method stub
			this._selectedItem.field=null;
		}
		
		protected function selectItem(event:DebugEvent):void
		{
			// TODO Auto-generated method stub
			if(!(event.item.info.field is String))
			{
				this._selectedItem.field=event.item.info.field;
			}
		}
		
		protected function onItemClick(event:DebugEvent):void
		{
			// TODO Auto-generated method stub
			if(!(event.item.info.field is String))
			{
				this.create(event.item.info.field,false);
			}			
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			switch(event.keyCode)
			{
				case Keyboard.ALTERNATE:
					this._isAltDown=false;
					break;
				case Keyboard.ESCAPE:
					
					break;
			}
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			switch(event.keyCode)
			{
				case Keyboard.ALTERNATE:
					_isAltDown=true;
					break;
				case showKeyCode:
					display();					
					break;
			}
		}
		
		protected function onClickStage(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var flag:Boolean=false;
			if(this._selectKey)
			{
				this._isAltDown?flag=true:"";
			}else
			{
				flag=true;
			}			
			
			if(flag && this._isShow && event.target is DisplayObject && 
				!(event.target is Stage) && 
				!(event.target is DebugItem))
			{
				create((event.target as DisplayObject));
			}	
			
		}
		/**
		 * 创建信息 
		 * @param target
		 * @param isGetPar 是否只显示父层
		 * 
		 */		
		private function create(target:*,isGetPar:Boolean=true):void
		{
			this.truncate();
			this._curClick=target;
			var temp:Array;
			temp=this.getParents((this._curClick as DisplayObject));
			var info:DebugInfo=new DebugInfo();
			info.field=this._curClick;
			temp.push(info);
			if(!isGetPar)
			{
				info.isParent=true;
				var childs:Array=this.getChildren((this._curClick as DisplayObjectContainer));
				temp=temp.concat(childs);
			}
			
			this._curInfoData=this._curInfoData.concat(temp);
			this.createInfos();
		}
		
		private function createInfos():void
		{
			var len:int=this._curInfoData.length;
			var item:DebugItem;
			var preX:Number=0;
			var posY:Number=0;
			var gapX:Number=3;
			var gapY:Number=3;
			var maxH:Number=0;
			for (var i:int = 0; i < len; i++) 
			{
				if(!(this._curInfoData[i] is DisplayObject))
				{
					//continue;
				}
				item=new DebugItem();
				item.info=this._curInfoData[i];
				item.id=i+1;					
				this._itemList.push(item);
				this._container.addChild(item);
				maxH<item.height?maxH=item.height:"";
				if(preX>this._stage.stageWidth-item.width)
				{
					//换行
					preX=0;
					posY+=gapY+maxH;
				}				
				item.x=preX;
				item.y=posY;				
				preX+=item.width+gapX;
				
			}
			
		}
		
		private function getParents(disObj:DisplayObject):Array
		{
			var ret:Array=[];
			var _p:DisplayObjectContainer=disObj.parent;
			var pName:String;
			var info:DebugInfo;
			while(_p)
			{
				info=new DebugInfo();
				info.field=_p;				
				ret.push(info);
				_p=_p.parent;
				if(_p==this._stage || _p is Stage)
				{
					info=new DebugInfo();
					info.field=_p;
					ret.push(info);
					break;
				}
			}
			ret=ret.reverse();
			
			return ret;
		}
		private function getChildren(disObj:DisplayObjectContainer):Array
		{
			var ret:Array=[];
			var info:DebugInfo;
			if(disObj!=null)
			{
				//ret.push(this._stage);
				var num:int=disObj.numChildren;
				for (var i:int = 0; i < num; i++) 
				{
					info=new DebugInfo();
					info.field=disObj.getChildAt(i);
					info.isSub=true;
					ret.push(info);
				}
			}						
			return ret;
		}
		
		private function truncate():void
		{
			resetInfoData();
			var item:DebugItem;
			while(this._itemList.length>0)
			{
				item=this._itemList.shift();
				item.destroy();
			}
			this._itemList=[];
			this._curClick=null;
			while(_container.numChildren)
			{
				_container.removeChildAt(0);
			}
		}
		
		private function resetInfoData():void
		{
			var info:DebugInfo=new DebugInfo();
			info.field="类查找系统::";
			this._curInfoData=[info];
		}
		
		private function display():void
		{
			// TODO Auto Generated method stub
			if(this._isShow)
			{
				this.hide();
			}else
			{
				this.truncate();
				this.createInfos();
				this.show();
			}
		}
		
		private function hide():void
		{
			if(this.parent)
			{
				this._isShow=false;
				this._isAltDown=false;
				this.parent.removeChild(this);
			}
		}
		
		private function show():void
		{
			this._isShow=true;
			this._stage.addChild(this);
			this.x=this.y=5;
		}
		
		public function destroy():void
		{
			
		}
		

	}
	
	
}
class Singleton
{
	public function Singleton():void
	{
		
	}
}