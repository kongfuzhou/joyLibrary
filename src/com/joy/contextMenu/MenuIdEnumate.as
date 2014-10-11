package com.joy.contextMenu 
{
	/**
	 * 右键菜单id枚举
	 * ...
	 * @author zhouhonghui
	 * @date 2014/4/23 15:00:20
	 */
	public class MenuIdEnumate 
	{
		public static const CM_ID_STAGE:String = "stage";
		
		public function MenuIdEnumate() 
		{
			throw new Error("");
		}
		
		/**
		 * 判断是否已经注册某id
		 * @param	id
		 * @return
		 */
		public static function exist(id:String):Boolean 
		{
			return MenuIdEnumate.cm_id_list.indexOf(id) != -1;
		}
		
		/**
		 * 已经注册的id列表
		 */
		public static function get cm_id_list():Array
		{
			//请在该类的上面定义id
			var arr:Array = [
				CM_ID_STAGE
			];
			return arr;
		}
		
	}

}