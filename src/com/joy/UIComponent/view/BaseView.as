package com.joy.UIComponent.view
{
	import com.joy.UIComponent.interFaces.IData;
	import com.joy.UIComponent.interFaces.IView;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	/**
	 * 视图组件(用来包装窗口中的分栏视图等)
	 * @user zhouhonghui
	 * @date 2014-8-1 下午05:05:58
	 **/
	public class BaseView extends Sprite implements IView,IData
	{
		protected var _data:*;
		protected var _parent:DisplayObjectContainer
				
		public function BaseView(_parent:DisplayObjectContainer)
		{
			this._parent=_parent;			
			createChild();
		}
		
		
		protected function createChild():void
		{
			
		}
		/**
		 * 渲染视图内容 
		 * 
		 */		
		public function update(params:Object):void
		{
			
		}
		
		public function setPosition(_x:Number,_y:Number):void
		{
			this.x=_x;
			this.y=_y;
		}
		
		public function get data():*
		{
			return _data;
		}
		public function set data(values:*):void
		{
			_data=values;
		}
		/**显示**/
		public function show():void
		{
			this._parent.addChild(this);
		}
		/**隐藏**/
		public function hide():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		
	}
}