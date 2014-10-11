package com.joy.UIComponent.input
{
	import com.joy.UI.UICreator;
	import com.joy.UIComponent.DefaultSkin;
	import com.joy.UIComponent.EStyleName;
	import com.joy.UIComponent.ZUIComponent;
	import com.joy.UIComponent.button.ZArrowButton;
	import com.joy.UIComponent.events.NumbericEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	/**
	 * @user zhouhonghui
	 * @date 2014-8-6 下午04:06:52
	 **/
	public class NumbericStep extends ZUIComponent
	{
		private var _curNum:Number;
		private var _minNum:Number=0;
		private var _maxNum:Number=100;		
		private var _btnContainer:Sprite;
		
		private var upBtn:ZArrowButton;
		private var downBtn:ZArrowButton;
		
		public function NumbericStep(num:Number=0)
		{
			super();
			this.curNum=num;
		}
		
		public function get minNum():Number
		{
			return _minNum;
		}

		public function set minNum(value:Number):void
		{
			_minNum = value;
		}

		public function get maxNum():Number
		{
			return _maxNum;
		}

		public function set maxNum(value:Number):void
		{
			_maxNum = value;
		}

		public function get curNum():Number
		{
			return _curNum;
		}

		public function set curNum(value:Number):void
		{
			if(value<=this._maxNum)
			{
				_curNum = value;
				this.label=_curNum.toString();
				this.dispatchEvent(new NumbericEvent(NumbericEvent.NUMBER_CHANGE,this._curNum));
			}
			
		}
		public override function set label(value:String):void
		{
			super.label=value;
			//_btnContainer.x=this.textField.x+this.textField.width;
			setTxtPos();
		}
		
		protected override function createSkin():void
		{
			super.createSkin();
			this.setStyle(EStyleName.UP_SKIN, DefaultSkin.getSkin(0x666600,25,20));
			this._defW=25;
			this._defH=20;
			//_btnContainer=new Sprite();
			//this.addChild(_btnContainer);
			
			var btnSize:Number=12;
			this.upBtn=new ZArrowButton();
			this.upBtn.direction=ZArrowButton.DIR_UP;
			this.upBtn.setSize(btnSize,btnSize);
			
			this.downBtn=new ZArrowButton();
			this.downBtn.direction=ZArrowButton.DIR_DOWN;
			this.downBtn.setSize(btnSize,btnSize);
			this.addChild(this.upBtn);
			this.addChild(this.downBtn);
			
			this.updateBtnPos();
			
			this.upBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			this.downBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			this.setSize(30,30)

		}
		private function updateBtnPos():void
		{
			var allH:Number=this.upBtn.height+this.downBtn.height+2;			
			this.upBtn.x=this.downBtn.x=this.curShowSytle.x+this.curShowSytle.width+2;			
			var d:Number=allH-this.curShowSytle.height;
			var upY:Number=-d/2;
			this.upBtn.y=upY;
			this.downBtn.y=this.upBtn.y+this.upBtn.height+2;
		}
		protected function clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			switch(event.currentTarget)
			{
				case this.upBtn:					
					this.setNumber(++this._curNum);		
					break;
				case this.downBtn:					
					this.setNumber(--this._curNum);
					break;
			}
		}
		protected override function createText():void
		{
			super.createText();
			textField.mouseEnabled = true;
			textField.selectable=true;
			this.textField.autoSize="left";
			this.textField.type=TextFieldType.INPUT;
			this.textField.restrict="0-9";
			this.textField.defaultTextFormat=new TextFormat(null,12,0xffffff);
			this.textField.addEventListener(Event.CHANGE,onInput);
				
		}
		
		protected function onInput(event:Event):void
		{
			// TODO Auto-generated method stub
			var num:Number=Number(this.textField.text);
			/*if(num>=this._maxNum)
			{
				this.label=this._maxNum.toString();
			}*/
			setNumber(num);
		}
		
		private function setNumber(num:Number):void
		{
			num<this._minNum?num=this._minNum:"";
			num>this._maxNum?num=this._maxNum:"";			
			if(num>=this._minNum && num<=this._maxNum)
			{				
				this.curNum=num;					
			}			
		}
		/**
		 *组件的真实宽高并不等于该设置的值 
		 * @param w
		 * @param h
		 * 
		 */		
		public override function setSize(w:Number, h:Number):void
		{
			super.setSize(w,h);
			this.updateBtnPos();
			setTxtPos();
		}
		public function getSetSizeVal():Object
		{
			return {w:this._defW,h:this._defH};
		}
		public override function destroy():void
		{
			super.destroy();
			this.upBtn.removeEventListener(MouseEvent.CLICK,clickHandler);
			this.downBtn.removeEventListener(MouseEvent.CLICK,clickHandler);
		}
		
		
	}
}