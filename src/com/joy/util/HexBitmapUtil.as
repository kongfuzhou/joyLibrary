package com.joy.util
{
	import flash.utils.ByteArray;

	public class HexBitmapUtil
	{
		public function HexBitmapUtil()
		{
		}
		/**
		 *把一个16进制的图片数据字符串转换成ByteArray 
		 * @param hexStr 图片数据字符串
		 * @return 
		 * 
		 */		
		public static function hexToBinary(hexStr:String):ByteArray
		{
			var bmpByte:ByteArray=new ByteArray();
			var len:int=hexStr.length;
			var hex:String;
			for (var i:int = 0; i < len; i = i + 2)
			{
				hex = hexStr.substr(i, 2);
				var n:int = parseInt(hexStr, 16);				
				bmpByte.writeByte(n);
			}
			bmpByte.position=0;
			
			return bmpByte;
		}
		
	}
}