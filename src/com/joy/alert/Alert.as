package com.joy.alert
{
	import com.joy.Global;
	import com.joy.UI.layer.TipLayer;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.core.Singleton;
	
	/**
	 * @user zhouhonghui
	 * @date 2014-8-18 上午10:35:18
	 **/
	public class Alert extends Sprite
	{
		private var _text:TextField;
		
		private static var _instance:Alert;
		
		public function Alert(sgt:Singleton)
		{
			super();
			if(_instance)
			{
				throw new Error("");
			}
			initUI()
		}
		
		public static function get instance():Alert
		{
			if(!_instance)
			{
				_instance=new Alert(new Singleton());
			}
			return _instance;
		}

		private function initUI():void
		{
			// TODO Auto Generated method stub
			this._text=new TextField();
			//this._text.autoSize="left";
			this._text.selectable=false;
			this._text.multiline=true;
			this._text.wordWrap=true;
			this._text.width=200;
			this.addChild(this._text);
			
			this.addEventListener(MouseEvent.CLICK,onClick);
			this.setStyle();
		}		
		
		protected function onClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
			
		}
		public function setStyle(w:Number=300,h:Number=200,color:uint=0xcccccc):void
		{
			this.graphics.clear();
			this.graphics.beginFill(color);
			this.graphics.drawRoundRect(0,0,w,h,10,10);
			this.graphics.endFill();
		}
		public function showMe(info:String):void
		{
			this._text.text=info;
			this._text.x=(this.width-this._text.width)/2;
			this._text.y=(this.height-this._text.height)/2;
			TipLayer.instance.addChild(this);
			Global.centerUI(this);
		}
		
		
	}
}
class Singleton
{
	public function Singleton():void
	{
		
	}
}