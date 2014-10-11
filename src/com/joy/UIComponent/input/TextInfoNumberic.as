package com.joy.UIComponent.input
{
	import com.joy.UI.UICreator;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * @user zhouhonghui
	 * @date 2014-8-8 上午10:23:18
	 **/
	public class TextInfoNumberic extends Sprite
	{
		private var _numStep:NumbericStep;
		private var _text:TextField;
		
		public function TextInfoNumberic()
		{
			super();
			init();
		}
		private function init():void
		{
			this._text=UICreator.getTextField("",0,0,100,30,new TextFormat(null,12,0xffffff),this);
			this._text.autoSize="left";
			
			_numStep=new NumbericStep();
			this.addChild(_numStep);
			this._numStep.setSize(30,30);
		}
		public function setNumPosY(_y:Number=0):void
		{
			this._numStep.x=this._text.x+this._text.width;
			this._numStep.y=_y;
		}
		
		public function set textFromat(value:TextFormat):void
		{
			this._text.defaultTextFormat=value;
		}
		
		public function get text():String
		{
			return this._text.text;
		}
		
		public function set text(values:String):void
		{
			this._text.text=values;
			this.setNumPosY();
			
		}
		public function get maxNum():Number
		{
			return this._numStep.maxNum;
		}
		public function set maxNum(num:Number):void
		{
			this._numStep.maxNum=num;
		}
		public function get minNum():Number
		{
			return this._numStep.minNum;
		}
		public function set minNum(num:Number):void
		{
			this._numStep.minNum=num;
		}
		
		public function get curNum():Number
		{
			return this._numStep.curNum;
		}
		public function set curNum(num:Number):void
		{
			this._numStep.curNum=num;
		}
		
		public function setTextPos(_x:Number,_y:Number):void
		{
			this._text.x=_x;
			this._text.y=_y;
		}
		
		public function setNumSize(w:Number,h:Number):void
		{
			this._numStep.setSize(w,h);
			
		}
		
		
	}
}