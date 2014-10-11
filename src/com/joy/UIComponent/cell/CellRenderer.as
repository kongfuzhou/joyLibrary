package com.joy.UIComponent.cell
{
	import com.joy.UIComponent.interFaces.ICellRenderer;
	import com.joy.UIComponent.interFaces.IDestroy;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * BaseList的渲染器父类，通常是继承该类来扩展渲染器
	 * @user zhouhonghui
	 * @date 2014-8-2 上午10:34:16
	 **/
	public class CellRenderer extends Sprite implements ICellRenderer,IDestroy
	{
		protected var _data:*;
		protected var _selected:Boolean=false;
		
		public function CellRenderer()
		{
			super();
			this.createView();
			init();
		}

		
		private function init():void
		{
			
		}
		
		/**
		 * 创建各种默认的显示对象 (一般会在子类重写该类)
		 * 
		 */		
		protected function createView():void
		{
			this.graphics.beginFill(0xff0000,0);
			this.graphics.drawRect(0,0,30,20);
			this.graphics.endFill();			
			
		}
		/**
		 * 渲染器的数据（通常是根据数据创建必要的显示对象）
		 * @return 
		 * 
		 */		
		public function get data():*
		{
			return this._data;
		}
		
		public function set data(values:*):void
		{
			this._data=values;			
			
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
		}
		
		public function destroy():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		
		
	}
}