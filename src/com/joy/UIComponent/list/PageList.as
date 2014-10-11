package com.joy.UIComponent.list
{
	import com.joy.UIComponent.cell.CellRenderer;

	/**
	 * 有分页功能列表
	 * @user zhouhonghui
	 * @date 2014-8-2 上午11:21:11
	 **/
	public class PageList extends BaseList
	{		
		private var _curPage:int=1;
		public function PageList()
		{
			super();
		}
		
		/**
		 * 当前页 
		 * @return 
		 * 
		 */		
		public function get curPage():int
		{
			return _curPage;
		}

		public function set curPage(value:int):void
		{
			if(value<=this.pageCount && value>0)
			{
				_curPage = value;
				this.renderer();
			}
			
		}
		/**
		 * 总页数 
		 * @return 
		 * 
		 */		
		public function get pageCount():int
		{
			var pageNum:int=this._cols*this._rows;
			var pageC:int=Math.ceil(this._dataProvider.length/pageNum);
			return pageC;
		}
		/**
		 *分页渲染 
		 * 
		 */		
		protected override function renderer():void
		{
			if(this._dataProvider)
			{
				this.truncateCell();
				if(this._rendererClass==null)
				{
					this._rendererClass=CellRenderer;
				}
				var maxNum:int=this._cols*this._rows;
				
				var cell:CellRenderer;
				var row:int; //行
				var col:int; //列
				var index:int;
				
				var pageNum:int=this._cols*this._rows; //一页的数量				
				var startIndex:int=(this._curPage-1)*pageNum;
				var endIndex:int=startIndex+pageNum;
				var tempData:Array=this._dataProvider.slice(startIndex,endIndex);
				var len:int=tempData.length;
				for (var i:int = 0; i < len; i++) 
				{
					cell = new this._rendererClass();
					cell.data=tempData[i];					
					row=i/this._cols;
					col=i%this._cols;
					cell.x=(cell.width+this._gapX)*col;
					cell.y=(cell.height+this.gapY)*row;
					this._cellContainer.addChild(cell);
				}
				
			}
		}

		

	}
}