package com.joy.UI.layer
{
	/**
	 * 提示层
	 * @user zhouhonghui
	 * @date 2014-8-1 上午11:55:25
	 **/
	public class TipLayer extends Layer
	{
		private static var _instance:TipLayer=new TipLayer();
		public function TipLayer()
		{
			super();
			if(_instance)
			{
				throw new Error("");
			}
		}
		public static function get instance():TipLayer
		{
			return _instance;
		}
	}
}