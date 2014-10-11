package  com.joy.xml{
		
	/**
	 * XML管理类 
	 * @author kfz room
	 */
	public class XMLManage {

		public function XMLManage() {
			// constructor code
			throw new Error("you can't get an instance!");
		}
		/**
		 *把一个单一的xml(只有一层子节点并且子节点无属性) 
		 * @param xml
		 * @return
		 * 
		 * @example
		 * <root>
		 * 	<name>jack</name>
		 *  <age>20</age>
		 * </root>
		 * 
		 */		
		public static function simpleXmlToObj(xml:XML):Object
		{
			var ret:Object = { };
			var xmlList:XMLList = xml.children();	
			var len:int = xmlList.length();
			for (var i:int = 0; i < len; i++)
			{
				var pro:String = xmlList[i].name();
				ret[pro] = xmlList[i].toString();
			}
			return ret;
		}
		/**
		 *把XML转换成数组[{},{},...] 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function XmlToArray(xml:XML):Array
		{
			var xmlArray:Array = [];
			
			var firsLayerXml:XMLList = xml.children();			
			xmlArray = xmlListToX(firsLayerXml);
			return xmlArray;
			
		}
		
		private static function xmlListToX(xmlList:XMLList):Array 
		{
			var list:Array = [];
			
			var len:int = xmlList.length();
			for (var i:int = 0; i < len; i++) 
			{				
				var childLen:int = xmlList[i].child('*').length();
				var obj:Object={};
				var pro:String = xmlList[i].name();
				if (childLen>0) 
				{					
					var childList:XMLList = xmlList[i].children();
					var nodeKind:String = childList.nodeKind();
					obj = xmlListAttributeToObj(xmlList[i]);
					switch (nodeKind) 
					{
						case 'element':
							var tempArr:Array=xmlListToX(childList);
							obj['childrens'] = tempArr;
							obj[pro] = '';
							break;
						case "text":							
							obj[pro] = childList.toString();
							break;						
					}			
					list.push(obj);
					
				}else
				{
					obj = xmlListAttributeToObj(xmlList[i]);
					obj[pro] = xmlList[i].toString();
					list.push(obj);
				}
			}			
			
			return list;
		}
		
		/**
		 * 把没有子节点的xml节点转换成object
		 * @param	line
		 * @return
		 */
		private static function xmlListAttributeToObj(line:*):Object 
		{
			var lineObj:Object = { };			
			var attributes:XMLList = line.attributes();
			var len:int = attributes.length();						
			for (var i:int = 0; i < len; i++) 
			{
				//该节点属性的键值对				
				var pro:String = attributes[i].name();
				lineObj[pro] = attributes[i].toString();
			}
						
			return lineObj;
		}
		

	}
	
}
