package com.joy.air.util
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	/**
	 * @user zhouhonghui
	 * @date 2014-8-1 上午10:54:39
	 **/
	public class FileHelper
	{
		
		public static const PATH_APP:String="app:/";
		/**
		 *字符串文本类型 
		 */		
		public static const CONTENT_TEXT:String="text";
		/**
		 *序列化对象类型 
		 */		
		public static const CONTENT_OBJECT:String="object";
		
		public function FileHelper()
		{
			throw new Error("");
		}
		public static function getFileContentByUrl(url:String,type:String="text"):*
		{
			return getFileContent(new File(url),type);
		}
		public static function writeFileByUrl(url:String,contents:*):void
		{
			writeFile(new File(url),contents);
		}
		
		/**
		 * 读取文件内容 
		 * @param file
		 * @param type
		 * @return 
		 * 
		 */		
		public static function getFileContent(file:File,type:String="text"):*
		{
			var fileStream:FileStream=new FileStream();
			try{
				fileStream.open(file,FileMode.READ);
				switch(type)
				{
					case CONTENT_TEXT:
						return fileStream.readUTFBytes(fileStream.bytesAvailable);
						break;
					case CONTENT_OBJECT:
						return fileStream.readObject();
						break;
				}						
				
			}catch(e:Error)
			{
				trace(e);
			}finally
			{
				fileStream.close();
			}
			return null;
		}
		/**
		 *写文件 
		 * @param file
		 * @param contents
		 * @example 
		 *  var file:File=new File(File.applicationDirectory.resolvePath("mapData/map.json").nativePath);
		 *  writeFile(file,"mapJson");
		 *  写文件时要绝对路径，所以再定义file的时候只写 
		 * file=File.applicationDirectory.resolvePath("mapData/map.json");会报错
		 */		
		public static function writeFile(file:File,contents:*):void
		{
			var fileStream:FileStream=new FileStream();
			try{
				fileStream.open(file,FileMode.WRITE);
				if(contents is String)
				{
					fileStream.writeUTFBytes(contents);
				}else
				{
					fileStream.writeObject(contents);
				}				
				
			}catch(e:Error)
			{
				trace(e);
			}finally
			{
				fileStream.close();
			}
		}
		/**
		 * 保存图片 
		 * @param file
		 * @param pngByte
		 * 
		 */		
		public static function savePng(file:File,pngByte:ByteArray):void
		{
			var fileStream:FileStream=new FileStream();
			try{
				fileStream.open(file,FileMode.WRITE);
				fileStream.writeBytes(pngByte,0,pngByte.length);
			}catch(e:Error)
			{
				trace(e);
			}finally
			{
				fileStream.close();
			}
		}
		
		public static function deleteFile(file:File):void
		{
			try
			{
				file.deleteFile();
			}catch(e:Error)
			{
				trace(e);
			}
		}
		
		
	}
}