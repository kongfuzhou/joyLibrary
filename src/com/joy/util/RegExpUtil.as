package com.joy.util
{
	public class RegExpUtil
	{
		public function RegExpUtil()
		{
			throw new Error("");
		}
		
		public static function isPhoneNumber(str:String):Boolean
		{
			var ret:Boolean=false;
			return ret;
		}
		
		public static function isEmailAddress(str:String):Boolean
		{
			var ret:Boolean=false;
			return ret;
		}
		/**
		 *删除字符串中的重复字符 
		 * @param str
		 * @return 
		 * 
		 */		
		public static function removeReaptStr(str:String):String
		{
			str=str.replace(/(?s)(.)(?=.+\1)/g,"");
			
			/*
			
			(?s) 开启单行模式 DOTALL 让. 号匹配任意字符 
			(.) 任意字符 并捕获在第一组 
			(?=.*1) 这是断言, 表示后面内容将是 任意个字符加上第一组所捕获的内容 
			(?=.*1) 我的理解: 断言, 表示后面内容将是 任意个第一组所捕获的字符 
			*/
			
			return str;
		}
		
		
	}
}