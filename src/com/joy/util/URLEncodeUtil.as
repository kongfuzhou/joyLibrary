package com.joy.util
{
	import flash.utils.ByteArray;

	/**
	 * @user zhouhonghui
	 * @date 2014-8-6 下午02:40:47
	 **/
	public class URLEncodeUtil
	{
		public function URLEncodeUtil()
		{
			/*
			
			  
			 */
		}
		/**
		 *将gb2312的字符串进行URL编码 
		 * @param str
		 * @return 
		 * 
		 */		
		public static function urlencodeGB2312(str:String):String{
			var result:String ="";
			var byte:ByteArray =new ByteArray();
			byte.writeMultiByte(str,"gb2312"); //以 gb2312 作为字符集把字符串写入到字节流
			for(var i:int;i<byte.length;i++){
				//对字符进行URL编码
				result += escape(String.fromCharCode(byte[i]));
			}
			return result;
		}
		/**
		 * 将gb2312的字符串进行URL编码 (繁体中文)
		 * @param str
		 * @return 
		 * 
		 */		
		public static function urlencodeBIG5(str:String):String{
			var result:String ="";
			var byte:ByteArray =new ByteArray();
			byte.writeMultiByte(str,"big5");
			for(var i:int;i<byte.length;i++){
				result += escape(String.fromCharCode(byte[i]));
			}
			return result;
		}
		public static function urlencodeGBK(str:String):String{
			var result:String ="";
			var byte:ByteArray =new ByteArray();
			byte.writeMultiByte(str,"gbk");
			for(var i:int;i<byte.length;i++){
				result += escape(String.fromCharCode(byte[i]));
			}
			//   trace(result);
			return result;
		}
		
	}
}