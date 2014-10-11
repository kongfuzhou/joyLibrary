package  com.joy.xml
{
	/**
	 * 自动构建xml
	 * @author kongfuzhou
	 * @date   2014/5/16 14:40:46
	 */
	public class CreateXML 
	{
		/**richXml的节点 obj key**/
		public static const RICH_NODE_KEY:String = "node";
		/**richXml的节点属性 obj key**/
		public static const RICH_ATTRIBUTES_KEY:String = "attributes";
		
		public function CreateXML() 
		{
			throw new Error("");
		}
		/**
		 * 创建一个只有属性值没有节点值的XML
		 * @param	arr  	 [{id:10,name:"man",....},{id:10,name:"man",....}]
		 * @param	nodeName  节点名(统一的)
		 * @return  <root>
		 * 				<node attrib1="xx" attrib2="yy" />
		 * 				<node attrib1="xx" attrib2="yy" />
		 * 			</root>
		 * @example 
		 * var data:Array = [ { name:"a101", id:101 },{ name:"a102", id:102 } ];		
		 * var xml:XML = CreateXML.createNoPropertyXML(data,true);
		 */
		public static function createNoNodeValueXML(arr:Array,nodeName:String="item"):XML
		{
			var xml:XML = <root></root>;
			var xmlChild:XML;
			var ob:Object;
			var len:int = arr.length;			
			for (var i:int = 0; i < len; i++) 
			{				
				xmlChild =<{nodeName}></{nodeName}>;
				ob=arr[i];
				for (var name:String in ob) 
				{
					xmlChild.@[name] = ob[name]; //动态设置xml的属性名和属性值
				}				
				xml.appendChild(xmlChild);
			}
			
			return xml;
		}
		/**
		 * 创建一个只有节点值的xml
		 * @param	arr			[{id:10,name:"man",....},{id:10,name:"man",....}]
		 * @param	pNameAsNodeName T的时候会自动把 {id:10,name:"man",....} obj的属性名设置为节点名
		 * @param	nodeName    节点名(统一的)
		 * @return  <root>
		 * 				<node>nodeValue</node>
		 * 				<node>nodeValue</node>
		 * 			</root>
		 * @example 
		 * var data:Array = [ { name:"a101", id:101 },{ name:"a102", id:102 } ];		
		 * var xml:XML = CreateXML.createNoPropertyXML(data,true);
		 */
		public static function createNoPropertyXML(arr:Array,pNameAsNodeName:Boolean=false,nodeName:String="item"):XML 
		{
			var xml:XML = <root></root>;		
			var len:int = arr.length;
			var ob:Object;
			var xmlChild:XML;
			for (var i:int = 0; i < len; i++) 
			{
				ob = arr[i];
				if (pNameAsNodeName) 
				{
					for (var name1:String in ob) 
					{
						xmlChild =<{name1}>{ob[name1]}</{name1}>;// 动态设置节点名和节点值			
						xml.appendChild(xmlChild);
					}
				}else
				{
					for (var name2:String in ob) 
					{
						xmlChild =<{nodeName}>{ob[name2]}</{nodeName}>;// 动态设置节点名和节点值			
						xml.appendChild(xmlChild);
					}
				}				
				
			}
			
			return xml;
		}
		/**
		 * 创建一个丰富的xml (有节点值且有属性值)
		 * @param	arr				[{node:{nodeKey:value},attributes:{attrib1:xx,attrib2:yy,...}}]		 
		 * @param   nodeName  自定义的节点名(为""时以node:{nodeKey:value}的nodeKey作为节点名)
		 * @return  <root>
		 * 				<node attrib1="xx" attrib2="yy" >nodeValue</node>
		 * 				<node attrib1="xx" attrib2="yy" >nodeValue</node>
		 * 			</root>
		 * @example
		 * var data:Array = [ ];
		 * var obj1:Object = { };
		 * obj1[CreateXML.RICH_NODE_KEY] = {item:"v1.0.1" };
		 * obj1[CreateXML.RICH_ATTRIBUTES_KEY] = { id:"1", name : "man", age:23 };
		 * data.push(obj1);
		 * var obj2:Object = { };
		 * obj2[CreateXML.RICH_NODE_KEY] = {list:"v1.0.2" };
		 * obj2[CreateXML.RICH_ATTRIBUTES_KEY] = { id:"2", name : "girl", age:20 };
		 * data.push(obj2);
		 * var xml:XML = CreateXML.createRichXML(data);
		 */
		public static function createRichXML(arr:Array,nodeName:String=""):XML 
		{
			var xml:XML = <root></root>;		
			var len:int = arr.length;
			var node:Object;
			var attributes:Object;
			var loop:int = 0;
			var xmlChild:XML;
			for (var i:int = 0; i < len; i++) 
			{
				loop = 0;
				node = arr[i][CreateXML.RICH_NODE_KEY];				
				for (var nodeKey:String in node) 
				{
					if (loop==0) //只loop一个节点
					{
						if (nodeName!="") //自定义节点名
						{
							xmlChild =<{nodeName}>{node[nodeKey]}</{nodeName}>;
						}else
						{
							//nodeKey作为节点名
							xmlChild =<{nodeKey}>{node[nodeKey]}</{nodeKey}>;
						}
						
						loop++;
					}else
					{
						break;
					}
					
				}
				attributes = arr[i][CreateXML.RICH_ATTRIBUTES_KEY];
				for (var attrib:String in attributes) 
				{
					xmlChild.@[attrib] = attributes[attrib];//动态设置属性键值对
				}
				xml.appendChild(xmlChild);
			}
			
			return xml;
		}

	}
}