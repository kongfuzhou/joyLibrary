package  com.joy.contextMenu
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.NativeMenu;
	import flash.display.Stage;
	import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
    import flash.ui.ContextMenuBuiltInItems;
    import flash.events.ContextMenuEvent;
    import flash.events.ContextMenuEvent;
    import flash.display.Sprite;
    import flash.display.Shape;
    import flash.text.TextField;
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author zhouhonghui
	 * @date 2014/4/23 11:51:57
	 */
	public class RightContextMenu 
	{
		
		private var callBackMap:Dictionary;
		/**
		 * 注册列表
		 */
		private var registerMap:Dictionary;
		/**
		 * 舞台的右键菜单
		 */
		private var stageContextMenu:ContextMenu;
        
		private static var _instance:RightContextMenu;
		public function RightContextMenu() 
		{
			if (_instance) 
			{
				throw new Error("");
			}
			init();
		}
		
		private function init():void 
		{
			callBackMap = new Dictionary();
			registerMap = new Dictionary();
			stageContextMenu = new ContextMenu(); 
			stageContextMenu.hideBuiltInItems();
            stageContextMenu.addEventListener(ContextMenuEvent.MENU_SELECT, menuSelectHandler);
           
		}
		static public function get self():RightContextMenu 
		{
			if (!_instance) 
			{
				_instance = new RightContextMenu();
			}
			return _instance;
		}
		

        private function menuSelectHandler(event:ContextMenuEvent):void {
            trace("menuSelectHandler: " + event);
        }

        private function menuItemSelectHandler(event:ContextMenuEvent):void {            
			if (event.target is ContextMenuItem) 
			{
				if (this.callBackMap[event.target] && this.callBackMap[event.target] is Function) 
				{
					this.callBackMap[event.target]((event.target as ContextMenuItem).caption);
				}
			}
        }

		
		/**
		 * 为某个显示对象注册右键菜单
		 * @param	target 注册对象
		 * @param	cMenu  自定义的右键菜单
		 */
		public function register(target:DisplayObjectContainer,id:String="stage",cMenu:ContextMenu = null):void {
            if (MenuIdEnumate.exist(id)) 
			{
				if (id==MenuIdEnumate.CM_ID_STAGE) 
				{
					target.contextMenu = this.stageContextMenu;
				}else
				{
					if (cMenu==null) 
					{
						cMenu = new ContextMenu();
					}
					target.contextMenu = cMenu;
				}			
				registerMap[id] = target;
			}			
        }
		/**
		 * 为某个右键菜单添加项
		 * @param	menuLabel
		 * @param	id
		 * @param	selectCB
		 */
        public function addCustomMenuItems(menuLabel:String,id:String="stage",selectCB:Function=null):void {
            var item:ContextMenuItem = new ContextMenuItem(menuLabel);
			if (id==MenuIdEnumate.CM_ID_STAGE) 
			{
				stageContextMenu.customItems.push(item);				
			}else
			{
				if (this.registerMap[id]) 
				{
					var cMenu:ContextMenu = (this.registerMap[id] as DisplayObjectContainer).contextMenu as ContextMenu;
					cMenu.customItems.push(item);
				}
			}
            
			if (selectCB!=null) 
			{
				this.callBackMap[item] = selectCB;
				item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
			}
            
        }
		
		
	}

}