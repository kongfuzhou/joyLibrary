package com.joy.util
{
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;

	/**
	 * @author zhouhonghui
	 * @date 2014-5-27
	 **/
	public class ColorUtil
	{
		public function ColorUtil()
		{
			throw new Error("");
		}
		/**
		 * 把一个16进制的颜色值转换成 ColorTransform
		 * @param val
		 * @return 
		 * 
		 */		
		public static function hexColorToColorTransform(val:String):ColorTransform
		{
			val = val.replace(/0x|#/ig, "");
			var colorTransform:ColorTransform = new ColorTransform();			
			var redVal:Number=Number(("0x"+val.substr(0,2)));
			var greenVal:Number=Number(("0x"+val.substr(2,2)));
			var blueVal:Number=Number(("0x"+val.substr(4,2)));
			colorTransform.redOffset = redVal;
			colorTransform.redMultiplier = 1;		
			colorTransform.greenOffset = greenVal;
			colorTransform.greenMultiplier = 1;
			colorTransform.blueOffset = blueVal;
			colorTransform.blueMultiplier = 1;
			
			return colorTransform;
		}
		/**
		 * 灰度滤镜
		 * @return
		 */
		public static function getGrayFilter():ColorMatrixFilter
		{
			var colorM:ColorMatrixFilter = new ColorMatrixFilter();
			
			var matrixs:Array = [];
			
			matrixs = matrixs.concat([0.33,0.33,0.33,0,-10]);
			matrixs = matrixs.concat([0.33,0.33,0.33,0,-10]);
			matrixs = matrixs.concat([0.33,0.33,0.33,0,-10]);
			matrixs = matrixs.concat([0,0,0,1,0]);
			
			colorM.matrix = matrixs;
			
			return colorM;
		}
		/**
		 * 去色滤镜
		 */
		public static function getDesaturateFilter():ColorMatrixFilter 
		{
			var colorM:ColorMatrixFilter = new ColorMatrixFilter();
			
			var matrixs:Array = [];
			
			matrixs = matrixs.concat([0.3086, 0.6094, 0.0820, 0, 0]);
			matrixs = matrixs.concat([0.3086, 0.6094, 0.0820, 0, 0]);
			matrixs = matrixs.concat([0.3086, 0.6094, 0.0820, 0, 0]);
			matrixs = matrixs.concat([0.3086, 0.6094, 0.0820, 0, 0]);
			
			colorM.matrix = matrixs;
			
			/*
				1）、首先了解一下去色原理：
				只要把RGB三通道的色彩信息设置成一样；
				即：R＝G＝B，那么图像就变成了灰色，并且，为了保证图像亮度不变，
				同一个通道中的R+G+B=1:如：0.3086+0.6094+0.0820＝1；
				2)之所以不平分是因为RGB给人的感觉是绿色最亮，红色次之，蓝色最暗。
				它们的比例大概是3：6：1；如果平分会导致图像亮度变暗
			 
			  */
			
			
			return colorM;
		}
		
		
		
		
	}
}