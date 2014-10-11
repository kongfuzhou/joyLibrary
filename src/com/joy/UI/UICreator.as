package com.joy.UI
{
	import com.joy.UIComponent.DefaultSkin;
	import com.joy.UIComponent.EStyleName;
	import com.joy.UIComponent.button.ZButton;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.controls.Text;

	/**
	 * @user zhouhonghui
	 * @date 2014-8-4 上午11:18:21
	 **/
	public class UICreator
	{
		public function UICreator()
		{
		}
		
		public static function getTextField(text:String="",x:Number=0,y:Number=0,w:Number=100,h:Number=30,format:TextFormat=null,parent:DisplayObjectContainer=null):TextField
		{
			var txt:TextField=new TextField();
			txt.selectable=false;
			txt.x=x;
			txt.y=y;			
			txt.width=w;
			txt.height=h;
			format?txt.defaultTextFormat=format:"";
			txt.htmlText=text;
			if(parent!=null)
			{
				parent.addChild(txt);
			}
			return txt;
		}
		public static function getLine(x:Number=0,y:Number=0,length:Number=300,degree:Number=1,color:uint=0xffff00):Sprite
		{
			var line:Sprite=new Sprite();
			line.graphics.lineStyle(degree,color);
			line.graphics.moveTo(0,0);
			line.graphics.lineTo(length,0);
			line.x=x;
			line.y=y;
			return line;
		}
		/**
		 * 获取一个Sprite按钮
		 * @param _text
		 * @param x
		 * @param y
		 * @param _parent
		 * @param w
		 * @param h
		 * @param color
		 * @return 
		 * 
		 */		
		public static function getNormalBtn(_text:String="",x:Number=0,y:Number=0,_parent:DisplayObjectContainer=null,w:Number=60,h:Number=25,color:uint=0xaaaa00):Sprite
		{			
			var _btnModel:Sprite=new Sprite();
			_btnModel.graphics.clear();
			_btnModel.graphics.beginFill(color);
			_btnModel.graphics.drawRoundRect(0,0,w,h,10,10);
			_btnModel.graphics.endFill();
			_btnModel.x=x;
			_btnModel.y=y;
			
			var txt:TextField=new TextField();
			
			txt.autoSize="left";
			
			txt.selectable=false;
			txt.mouseEnabled=false;
			_btnModel.addChild(txt);
			txt.defaultTextFormat=new TextFormat(null,12,0xffffff);
			txt.text=_text;			
			txt.x=(w-txt.width)/2;
			txt.y=(h-txt.height)/2;
			
			if(_parent!=null)
			{
				_parent.addChild(_btnModel);
			}
			_btnModel.buttonMode=true;
			return _btnModel;
		}
		/**
		 * 获取一个等腰三角形 
		 * @param p		三角形两腰的夹角顶点(x为三角形的高，y*2为三角形的底)
		 * @param color
		 * @return 
		 * 
		 */		
		public static function getTriangleBtn(p:Point,x:Number=0,y:Number=0,_parent:DisplayObjectContainer=null,color:uint=0xaaaa00):Sprite
		{
			var btn:Sprite=new Sprite();
			btn.graphics.beginFill(color);			
			var vectics:Vector.<Number>=new <Number>[0,0,p.x,p.y,0,p.y*2];			
			btn.graphics.drawTriangles(vectics);
			btn.graphics.endFill();
			btn.buttonMode=true;
			btn.x=x;
			btn.y=y;
			if(_parent!=null)
			{
				_parent.addChild(btn);
			}
			return btn;			
		}
		/**
		 *淡黄色背景 白色字 55*30的按钮 
		 * @return 
		 * 
		 */		
		public static function getYellowZButton(_parent:DisplayObjectContainer=null,_x:Number=0,_y:Number=0):ZButton
		{
			var _btn:ZButton=new ZButton();
			_btn.setStyle(EStyleName.UP_SKIN, DefaultSkin.getSkin(DefaultSkin.defaultColor,55,30));
			_btn.setStyle(EStyleName.OVER_SKIN,DefaultSkin.getSkin(0xbbbb00,55,30));
			_btn.setStyle(EStyleName.TEXTFORMAT,new TextFormat(null,12,0xffffff)); 
			_btn.x=_x;
			_btn.y=_y;
			if(_parent!=null)
			{
				_parent.addChild(_btn);
			}			
			
			return _btn;
		}
		
	}
}