package com.joy.UIComponent.button 
{
	import com.joy.UIComponent.DefaultSkin;
	import com.joy.UIComponent.EStyleName;
	import com.joy.UIComponent.ZUIComponent;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author zhouhonghui
	 * @date 2014/4/11 19:15:35
	 */
	public class ZButton extends ZUIComponent
	{
		
		public function ZButton() 
		{
			init();
		}
		
		private function init():void 
		{
			this.useHandCursor = true;
			this.mouseChildren = false;
			this.buttonMode=true;
		}
		override protected function createSkin():void
		{
			super.createSkin();
			this.setStyle(EStyleName.UP_SKIN, DefaultSkin.getSkin(DefaultSkin.defaultColor,50,30));
		}
		protected override function createText():void
		{
			super.createText();
			textField.mouseEnabled = false;
			textField.selectable=false;
			this.textField.autoSize="left";
			this.textField.type=TextFieldType.INPUT;			
			this.textField.defaultTextFormat=new TextFormat(null,12,0x000000);
			
			
		}
		override protected function draw(child:DisplayObject):void 
		{
			super.draw(child);
			
		}
		public override function setSize(w:Number, h:Number):void
		{
			super.setSize(w,h);
			this.setTxtPos();
		}
		public override function set style(style:String):void 
		{
			super.style = style;
		}
		public override function set label(value:String):void
		{
			super.label=value;
			this.setTxtPos();
		}
		
		
	}

}