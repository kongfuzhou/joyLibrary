package com.joy.UI.calendar.view
{
	import com.joy.UI.UICreator;
	import com.joy.UI.calendar.Calendar;
	import com.joy.util.DateUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @user zhouhonghui
	 * @date 2014-8-1 下午05:06:18
	 **/
	public class YearView extends BaseView
	{
		private var _date:Date;
		private var _text:TextField;
		private var leftBtn:Sprite;
		private var rightBtn:Sprite;
		private var _gap:Number=3;
		
		public function YearView(_parent:DisplayObjectContainer,calender:Calendar=null)
		{
			super(_parent,calender);
		}
		
		protected override function createChild():void
		{
			
			this._text=UICreator.getTextField("",_gap,2,100,25,new TextFormat(null,15),this);
			//this.addChild(this._text);
			leftBtn=this.getArrowsBtn(true);
			addChild(leftBtn);
			rightBtn=this.getArrowsBtn();
			addChild(rightBtn);
			
		}
		
		public override function update(params:Object):void
		{
			this._date=params as Date;
			this._text.text=DateUtil.getDate(this._date,"cn","ym");
			rightBtn.x=this._text.x+this._text.textWidth+_gap;
		}
		
		protected function onClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			switch(event.currentTarget)
			{
				case this.leftBtn:
					handlerChangeMonth("left");
					break;
				case this.rightBtn:
					handlerChangeMonth("right");
					break;
			}
		}
		private function handlerChangeMonth(dir:String="left"):void
		{
			if(!this._calender)
			{
				return;
			}
			var curMonth:int=this._date.month;
			var retMonth:int;
			var year:int=this._date.fullYear;
			if(dir=="left")
			{
				if(curMonth==0) //1月
				{
					retMonth=11; //去年11月
					year-=1;
				}else
				{
					retMonth=curMonth-1;
				}
			}else if(dir=="right")
			{
				if(curMonth==11) //12月
				{
					retMonth=0; //明年1月
					year+=1;
				}else
				{
					retMonth=curMonth+1;
				}
			}
			
			var tDate:Date=new Date(year,retMonth,1);
			this._calender.updateDay(tDate);
			
		}
		
		private function getArrowsBtn(isRev:Boolean=false,color:uint=0):Sprite
		{
			var btn:Sprite=new Sprite();
			btn.graphics.beginFill(color);
			var x2:Number=12;
			var y2:Number=12;
			var vertices:Vector.<Number>=new <Number>[0,0,x2,y2,0,y2*2]; //画一个等腰三角形
			
			btn.graphics.drawTriangles(vertices);
			if(isRev)
			{
				btn.rotationY=180;
			}
			btn.buttonMode=true;
			btn.addEventListener(MouseEvent.CLICK,onClick);
			return btn;
		}
		
	}
}