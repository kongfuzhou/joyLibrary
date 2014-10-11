package com.joy
{
	import com.joy.UI.layer.BgLayer;
	import com.joy.UI.layer.TipLayer;
	import com.joy.UI.layer.ViewLayer;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	/**
	 * @user zhouhonghui
	 * @date 2014-8-1 下午03:57:44
	 **/
	public class Global
	{
		public static var stage:Stage;
		public function Global()
		{
		}
		public static function init(stage:Stage):void
		{
			Global.stage=stage;
			Global.stage.addChild(BgLayer.instance);
			Global.stage.addChild(ViewLayer.instance);
			Global.stage.addChild(TipLayer.instance);
		}
		/**
		 * 相对于某个背景居中 (relative和ui有共同的父级)
		 * @param relative 被相对的显示对象
		 * @param ui
		 * 
		 */		
		public static function crenterUIRelativeBg(relative:DisplayObject,ui:DisplayObject):void
		{			
			ui.x=relative.x+(relative.width-ui.width)/2;
			ui.y=relative.y+(relative.height-ui.height)/2;
		}
			
		public static function centerUI(ui:DisplayObject):void
		{
			centerUIX(ui);
			centerUIY(ui);
		}
		public static function centerUIX(ui:DisplayObject):void
		{
			ui.x=(stage.stageWidth-ui.width)/2;
			
		}
		public static function centerUIY(ui:DisplayObject):void
		{			
			ui.y=(stage.stageHeight-ui.height)/2;
		}
		/**
		 *把UI移动到最右边 
		 * @param ui
		 * @param gap
		 */		
		public static function rightUI(ui:DisplayObject,gap:Number=0):void
		{
			ui.x=stage.stageWidth-ui.width-gap;
		}
		
		/**
		 *把UI移动到最底部
		 * @param ui
		 * 
		 */		
		public static function bottomUI(ui:DisplayObject):void
		{
			ui.y=stage.stageHeight-ui.height;
		}
		/**
		 * 清空某个容器 
		 * @param parent
		 * 
		 */		
		public static function clearChild(parent:DisplayObjectContainer):void
		{
			while(parent.numChildren>0)
			{
				parent.removeChildAt(0);
			}
		}
		
		
	}
}