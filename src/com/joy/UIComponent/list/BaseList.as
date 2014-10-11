
package com.joy.UIComponent.list
{
	import avmplus.getQualifiedClassName;
	import avmplus.getQualifiedSuperclassName;
	
	import com.joy.UIComponent.cell.CellRenderer;
	import com.joy.UIComponent.interFaces.ICellRenderer;
	import com.joy.UIComponent.interFaces.IDestroy;
	import com.joy.util.ClassObjectUtil;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	/**
	 * @user zhouhonghui
	 * @date 2014-8-1 下午05:44:09
	 **/
	public class BaseList extends Sprite implements IDestroy
	{
		protected var _gapX:Number=3;
		protected var _gapY:Number=3;
		/**cell容器**/
		protected var _cellContainer:Sprite;
		/**数据源**/
		protected var _dataProvider:Array;
		/**cell渲染类**/
		protected var _rendererClass:Class;
		protected var _selectIndex:int;
		protected var _rows:int=3;
		protected var _cols:int=3;
		protected var _selector:CellRenderer;
		protected var _cellList:Array;
		protected var _selectAble:Boolean=true;
		protected var _mutiSelected:Boolean=false;	
		protected var _mutiSelectors:Array;
		
		protected var _rowPosDict:Dictionary;
		protected var _colPosDict:Dictionary;
		
		
		private var _listClickHandler:Function;
		
		public function BaseList()
		{
			init();
		}
		public function get selectIndex():int
		{
			return _selectIndex;
		}
		
		public function get rows():int
		{
			return _rows;
		}
		public function get cols():int
		{
			return _cols;
		}
		/**
		 *所有渲染的格子
		 * @return 
		 * 
		 */		
		public function get cellList():Array
		{
			return _cellList;
		}
		public function set selectIndex(value:int):void
		{
			_selectIndex = value;
			this.setSelect(this._cellList[_selectIndex]);
		}
		/**
		 *是否可以多选  
		 * @return 
		 * 
		 */		
		public function get mutiSelected():Boolean
		{
			return _mutiSelected;
		}
		
		public function set mutiSelected(value:Boolean):void
		{
			_mutiSelected = value;
			if(!_mutiSelected)
			{
				_mutiSelectors=[];
			}
		}
		/**
		 *选中多个格子 
		 * @return 
		 * 
		 */		
		public function get mutiSelectors():Array
		{
			return _mutiSelectors;
		}
		
		public function set mutiSelectors(value:Array):void
		{
			_mutiSelectors = value;
		}
		/**
		 *点击列表的回调函数 
		 * @return 
		 * 
		 */		
		public function get listClickHandler():Function
		{
			return _listClickHandler;
		}
		/**
		 *是否可以选择格子 
		 * @return 
		 * 
		 */		
		public function get selectAble():Boolean
		{
			return _selectAble;
		}
		
		public function set selectAble(value:Boolean):void
		{
			_selectAble = value;
			/*if(_selectAble)
			{
				this.addEventListener(MouseEvent.CLICK,onListClick);
			}else
			{
				this.removeEventListener(MouseEvent.CLICK,onListClick);
			}*/
		}
		
		public function set listClickHandler(value:Function):void
		{
			_listClickHandler = value;
		}
		/**
		 *渲染器 
		 * @return 
		 * 
		 */		
		public function get rendererClass():Class
		{
			return _rendererClass;
		}

		public function set rendererClass(value:Class):void
		{
			if(value==CellRenderer || ClassObjectUtil.isASuperCs(value,CellRenderer))
			{				
				_rendererClass = value;
				this.renderer();
			}else
			{
				throw new Error("'rendererClass' must is CellRenderer or it's sub class.");
			}
			
		}
		public function get selector():CellRenderer
		{
			return _selector;
		}
		/**
		 * 数据提供者(建议先把其他属性都设置好后再设置该属性)
		 * @return 
		 * 
		 */		
		public function get dataProvider():Array
		{
			return _dataProvider;
		}

		public function set dataProvider(value:Array):void
		{
			_dataProvider = value;			
			renderer();
		}
		/**
		 *格子的垂直距离(建议在设置dataProvider之前设置 默认3) 
		 * @return 
		 * 
		 */		
		public function get gapY():Number
		{
			return _gapY;
		}

		public function set gapY(value:Number):void
		{
			_gapY = value;
			this.renderer();
		}
		/**
		 *水平方向的间隔 (建议在设置dataProvider之前设置 默认3) 
		 * @return 
		 * 
		 */		
		public function get gapX():Number
		{
			return _gapX;
		}

		public function set gapX(value:Number):void
		{
			_gapX = value;
			this.renderer();
		}
		/**
		 *设置列表的行列,(决定一次显示的条目,默认3*3)
		 * @param row
		 * @param col
		 * 
		 */		
		public function setList(row:int,col:int):void
		{
			this._rows=row;
			this._cols=col;
			this.renderer();
		}
		
		/**
		 *渲染列表 
		 * 
		 */		
		protected function renderer():void
		{
			// TODO Auto Generated method stub
			this.truncateCell();
			this._cellList=[];
			this._rowPosDict=null;
			this._colPosDict=null;
			this._rowPosDict=new Dictionary();
			this._colPosDict=new Dictionary();
			if(this._dataProvider)
			{				
				if(this._rendererClass==null)
				{
					this._rendererClass=CellRenderer;
				}
				var maxNum:int=this._cols*this._rows;
				var len:int=this._dataProvider.length>maxNum?maxNum:this._dataProvider.length;
				var cell:CellRenderer;
				var row:int; //行
				var col:int; //列
				var index:int;
				
				for (var i:int = 0; i < len; i++) 
				{
					cell = new this._rendererClass();
					cell.data=this._dataProvider[i];					
					row=i/this._cols;
					col=i%this._cols;
					
					if(this._rowPosDict[row]==null)
					{
						this._rowPosDict[row]=0;
						cell.x=0;
					}else
					{
						
						cell.x=this._rowPosDict[row];
					}
					this._rowPosDict[row]+=cell.width+this._gapX;
					
					if(this._colPosDict[col]==null)
					{
						this._colPosDict[col]=0;
						cell.y=0;
					}else
					{
						cell.y=this._colPosDict[col];						
					}
					this._colPosDict[col]+=cell.height+this._gapY;
					
					/*cell.x=(cell.width+this._gapX)*col;
					cell.y=(cell.height+this._gapY)*row;*/
					
					_cellList.push(cell);
					this._cellContainer.addChild(cell);
				}
				
			}			
			
		}
		/**
		 *清空当前渲染的cell 
		 * 
		 */		
		protected function truncateCell():void
		{
			while(_cellContainer.numChildren>0)
			{
				_cellContainer.removeChildAt(0);
			}
			if(_cellList!=null)
			{
				var cell:CellRenderer;
				while(_cellList.length>0)
				{
					cell=_cellList.shift() as CellRenderer;
					cell.destroy();
				}
			}
		}
		
		private function init():void
		{
			_cellContainer=new Sprite();
			this.addChild(_cellContainer);
			this.addEventListener(MouseEvent.CLICK,onListClick);
			_mutiSelectors=[];
			
		}
		
		protected function onListClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var cell:CellRenderer=this.getCell(event.target as DisplayObject);			
			setSelect(cell);
		}
		private function setSelect(cell:CellRenderer):void
		{
			if(cell)
			{
				
				if(cell.selected)
				{
					//取消的选中
					cell.selected=false;
					var index:int=this._mutiSelectors.indexOf(cell);
					if(index>-1)
					{
						this._mutiSelectors.splice(index,1);
					}
				}else
				{
					//不可以多选 取消上一个的选择状态
					if(this._selector && !this._mutiSelected) 
					{
						this._selector.selected=false;
					}
					this._selector=cell;
					this._selector.selected=true; //选择当前
					if(this._mutiSelected)
					{
						this._mutiSelectors.push(this._selector);
					}
					this._selectIndex=this._cellList.indexOf(cell);
					
				}
				if(this._listClickHandler!=null)
				{
					this._listClickHandler(cell);
				}
				
			}else
			{
				//点击了列表的其他地方
				if(this._selector) //取消上一个的选择状态
				{
					this._selector.selected=false;
				}
				this._selector=null;
			}
		}
		
		private function getCell(target:DisplayObject):CellRenderer
		{
			if(target is CellRenderer)
			{
				return target as CellRenderer;
			}else
			{
				var tParent:DisplayObjectContainer=target.parent;
				while(tParent)
				{
					if(tParent is CellRenderer)
					{
						return tParent as CellRenderer;
					}
					if(tParent==this)
					{
						return null;
					}
					if(tParent.parent!=null)
					{
						tParent=tParent.parent;
					}else
					{
						return null;
					}
					
				}
			}
			return null
		}
		
		public function destroy():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
			this.removeEventListener(MouseEvent.CLICK,onListClick);
		}
		
	}
}