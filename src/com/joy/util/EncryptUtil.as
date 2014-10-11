package com.joy.util
{
	import flash.utils.ByteArray;

	/**
	 * 利用ByteArray对数据进行简单的加密和解密
	 * @user zhouhonghui
	 * @date 2014-8-8 下午05:16:03
	 **/
	public class EncryptUtil
	{
		private static var key:ByteArray;
		
		public function EncryptUtil()
		{
			
		}
		
		public static function setKey(_key:String="123456"):void
		{
			key=new ByteArray();
			key.writeUTF(_key);
			key.position=0;
		}
		/**
		 * 加密 
		 * @param data
		 * @return 
		 * 
		 */		
		public static function encrypt(data:*):ByteArray
		{
			if(key==null)
			{
				setKey();
			}
			var byte:ByteArray=new ByteArray();			
			byte.writeObject(data);			
			
			algorithm01(byte);
			byte.compress();
			
			return byte;
		}
		/**
		 * 解密 
		 * @param byte
		 * @return 
		 * 
		 */		
		public static function decode(byte:ByteArray):*
		{			
			byte.uncompress();			
			algorithm01(byte);	
			return byte.readObject();
		}
		
		private static function algorithm01(byte:ByteArray):void
		{
			if(key==null)
			{
				setKey();
			}
			var keyLen:int=key.length;
			var len:int=byte.length;			
			for (var i:int = 0; i < len; i++) 
			{
				if(i<keyLen)
				{
					byte[i]=byte[i]^key[i];
				}else
				{
					break;
				}
				
			}
			
			
		}
		
		
		
	}
}