package com.joy.UIComponent.tips 
{
	import com.joy.UIComponent.interFaces.ITip;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	/**
	 * ...
	 * @author zhouhonghui
	 * @date 2014/4/14 10:32:41
	 */
	public class TipsBase extends Sprite implements ITip
	{
		protected var _txt:TextField;
		protected var _bg:DisplayObject;
		protected var _data:*;
		
		public function TipsBase() 
		{
			drawBG();
		}
		
		protected function drawBG():void 
		{
			_bg = new Sprite();			
			(this._bg as Sprite).graphics.beginFill(0xffff00, 0.75);
			(this._bg as Sprite).graphics.drawRoundRect(0, 0, 130, 100, 10);
			(this._bg as Sprite).graphics.endFill();
			(this._bg as Sprite).scale9Grid = new Rectangle(15, 15, 100, 70);
			addChild(this._bg);
		}
		
		public function set data(value:*):void
		{
			_data = value;
			if (!_txt) 
			{
				_txt = new TextField();
				_txt.selectable = false;				
				_txt.autoSize = "left";
				addChild(_txt);
			}
			if (value is String) 
			{
				_txt.text = value;
				this._bg.visible = true;
				this._txt.visible = true;
			}else
			{
				this._bg.visible = false;
				this._txt.visible = false;
			}
			
		}
		
		
	}

}