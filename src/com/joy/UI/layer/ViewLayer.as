package com.joy.UI.layer
{
	/**
	 * 视图层
	 * @user zhouhonghui
	 * @date 2014-8-1 上午11:55:05
	 **/
	public class ViewLayer extends Layer
	{
		private static var _instance:ViewLayer=new ViewLayer();
		public function ViewLayer()
		{
			if(_instance)
			{
				throw new Error("");
			}
		}

		public static function get instance():ViewLayer
		{
			return _instance;
		}
		

	}
}