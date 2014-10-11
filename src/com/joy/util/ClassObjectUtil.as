package com.joy.util
{
	import avmplus.getQualifiedClassName;
	import avmplus.getQualifiedSuperclassName;
	
	import flash.net.registerClassAlias;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	public class ClassObjectUtil
	{
		
		public function ClassObjectUtil()
		{
			throw new Error("");
		}
		/**
		 *判断某个类是否实现了某个接口 
		 * @param cs    要判断的类
		 * @param inter 接口
		 * @return 
		 * 
		 */		
		public static function isImplements(cs:Class,inter:*):Boolean
		{
			var ret:Boolean=false;
			
			var xml:XML=describeType(cs);
			var interName:String=getQualifiedClassName(inter);
			var implementsInter:XMLList=xml.factory.child("implementsInterface");
			
			var len:int=implementsInter.length();
			var tempInterName:String;
			for (var i:int = 0; i < len; i++) 
			{
				tempInterName=implementsInter[i].@type;
				if(interName==tempInterName)
				{
					ret=true;
					break;
				}
			}
						
			return ret;
		}
		/**
		 *类b是否是类a的父类 
		 * @param a 子类
		 * @param b	父类
		 * @param domain
		 * @return 
		 * 
		 */		
		public static function isASuperCs(a:Class,b:Class,domain:ApplicationDomain=null):Boolean
		{
			var ret:Boolean=false;
			
			!domain?domain=ApplicationDomain.currentDomain:"";	
			var aName:String=getQualifiedClassName(a);	
			var bName:String=getQualifiedClassName(b);			
			var aSuperName:String=getQualifiedSuperclassName(a);
			//在该域中没有定义
			if(!domain.hasDefinition(bName) || !domain.hasDefinition(aName))
			{
				return ret;
			}
			var superCS:Class;
			var flag:Boolean = false;			
			while(aSuperName!=null)
			{
				if(bName==aSuperName)
				{
					ret=true;
					break;
				}
				try
				{
					superCS = domain.getDefinition(aSuperName) as Class;
				}catch (e:Error)
				{
					break;
				}
				
				aSuperName = getQualifiedSuperclassName(superCS);
				
			}
			
			return ret;
		}
		/**
		 * 复制引用
		 * @param ref
		 * @return 
		 * 
		 */		
		public static function copyObject(ref:*):Object
		{
			var typeName:String = getQualifiedClassName(ref);
			var packageName:String = typeName.split("::")[1];
			var type:Class = Class(getDefinitionByName(typeName));
			packageName == null?packageName = typeName:"";
			if(packageName!=null)
			{
				registerClassAlias(packageName,type);	
			}					
			var byte:ByteArray=new ByteArray();
			byte.writeObject(ref);
			byte.position=0;
			var copy:*= byte.readObject();			
			return copy;
		}
		/**
		 * 把一个obj的属性复制到另一个 
		 * @param targetObj  目标对象
		 * @param proObj	  属性表
		 * @param needDefind      是否需要预先定义的属性才赋值
		 */		
		public static function copyProperty(targetObj:Object,proObj:Object,needDefind:Boolean=true):void
		{
			for(var pro:String in proObj) 
			{
				if(needDefind)
				{
					if(targetObj.hasOwnProperty(pro))
					{
						targetObj[pro]=proObj[pro];
					}
				}else
				{
					targetObj[pro]=proObj[pro];
				}
				
			}
			
		}
		
		
		
	}
}