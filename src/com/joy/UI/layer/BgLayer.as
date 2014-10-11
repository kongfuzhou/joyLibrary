package com.joy.UI.layer
{
	/**
	 * @user zhouhonghui
	 * @date 2014-8-1 上午11:55:37
	 **/
	public class BgLayer extends Layer
	{
		private static var _instance:BgLayer=new BgLayer();
		public function BgLayer()
		{
			super();
			if(_instance)
			{
				throw new Error("");
			}
			
		}
		public static function get instance():BgLayer
		{
			return _instance;
		}
		
	}
}