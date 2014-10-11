package com.joy.util 
{
	import adobe.utils.CustomActions;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	/**
	 * ...
	 * @author kongfuzhou
	 * @date   2014/6/7 10:02:41
	 */
	public class BitmapDataUtil 
	{
		
		public function BitmapDataUtil() 
		{
			throw new Error("you can't make an instance ");
		}
		/**
		 * 把一张序列位图数据切割成vector数据
		 * @param	source	位图数据源
		 * @param	seqInfo 切割信息  {rows:2,cols:2,width:50,height:100,max:(可选,切割多少张;默认rows*cols)}
		 * @return
		 */
		public static function copyBmpDataToVectSeq(source:BitmapData,seqInfo:Object):Vector.<BitmapData> 
		{
			var retSeq:Vector.<BitmapData> = new Vector.<BitmapData>();
			var rows:int = seqInfo.rows;
			var cols:int = seqInfo.cols;
			var width:Number = seqInfo.width;
			var height:Number = seqInfo.height;
			var max:int = seqInfo.max?seqInfo.max:rows*cols;
			var len:int = 0;
			var flag:Boolean=false;
			for (var i:int = 0; i < rows; i++) 
			{
				for (var j:int = 0; j < cols; j++) 
				{
					len = (i + 1) * (j + 1);
					if (len<=max)
					{
						//source
						source=new BitmapData(width, height);
						source.copyPixels(source, new Rectangle(j * width, i * height, width, height), new Point(0, 0));
						retSeq.push(source);
					}
					if (len==max) 
					{
						flag = true;
						break;
					}
				}
				if (flag) 
				{
					break;
				}
			}
			
			return retSeq;
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