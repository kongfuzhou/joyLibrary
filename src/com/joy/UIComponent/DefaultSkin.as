package com.joy.UIComponent 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author zhouhonghui
	 * @date 2014/4/11 19:42:29
	 */
	public class DefaultSkin 
	{
		public static var defaultColor:uint=0xaaaa00;
		/**
		 * 默认皮肤储存器(所有默认皮肤都是一个50*25的红色圆角长方形Bitmap)
		 */
		public function DefaultSkin() 
		{
			
		}
		
		public static function getDefaultSkin(style:String):Bitmap 
		{
			return getSkin(setColor(style));
		}
		/**
		 * 根据样式设置颜色
		 * @param	style
		 * @return
		 */
		private static function setColor(style:String):uint 
		{
			var color:uint = defaultColor;
			switch (style) 
			{
				case EStyleName.CLICK_SKIN:
					color = 0xffff00;
					break;
				case EStyleName.OVER_SKIN:
					color = 0x00ff00;
					break;
				case EStyleName.OUT_SKIN:
					color = 0x0000ff;
					break;
				case EStyleName.DOWN_SKIN:
					color = 0x0000ff;
					break;
				case EStyleName.UP_SKIN:					
					break;
			}
			return color;
		}
		
		public static function getSkin(color:uint,width:Number=50,height:Number=30):Bitmap
		{
			var b:Bitmap = new Bitmap();
			
			var s:Sprite = new Sprite();
			s.graphics.beginFill(color);
			s.graphics.drawRoundRect(0, 0, width, height, 5);
			s.graphics.endFill();
			
			var bd:BitmapData = new BitmapData(s.width, s.height,true,0);
			bd.draw(s);
			b.bitmapData = bd;
			
			return b;
		}
		
		
	}

}