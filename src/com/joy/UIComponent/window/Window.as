package com.joy.UIComponent.window
{
	
	import com.joy.UI.layer.Layer;
	import com.joy.UI.layer.ViewLayer;
	import com.joy.UIComponent.interFaces.IDragAble;
	import com.joy.UIComponent.interFaces.IWindow;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @user zhouhonghui
	 * @date 2014-8-1 上午11:51:39
	 **/
	public class Window extends Sprite implements IWindow,IDragAble
	{
		/**拖动条**/
		protected var dragRect:Sprite;
		protected var _winBg:DisplayObject;
		protected var _winBgContainer:Sprite;
		protected var _closeBtn:DisplayObject;
		protected var _closeBtnContainer:Sprite;
		
		protected var _winTitle:*;
		protected var _titleTxt:TextField;
		protected var titleContainer:Sprite;
		
		protected var _layer:Layer;
		protected var _dragRange:Object;
		private var _isDragAble:Boolean=true;
		
		public function Window()
		{			
			initWin();
			
		}
		
		private function initWin():void
		{			
			if(!this._layer)
			{
				this._layer=ViewLayer.instance;
			}
						
			createMustChild();
			createChild();
			configEvent();
		}
		
		private function configEvent(flag:Boolean=true):void
		{
			// TODO Auto Generated method stub
			if(flag)
			{
				this._closeBtnContainer.addEventListener(MouseEvent.CLICK,onMouseClick);
				this.dragRect.addEventListener(MouseEvent.MOUSE_DOWN,onDragHandler);
				this.dragRect.addEventListener(MouseEvent.MOUSE_UP,onDragRelease);
				this.dragRect.addEventListener(MouseEvent.MOUSE_OUT,onDragRelease);
			}else
			{
				this.dragRect.removeEventListener(MouseEvent.MOUSE_DOWN,onDragHandler);
				this.dragRect.removeEventListener(MouseEvent.MOUSE_UP,onDragRelease);
				this.dragRect.removeEventListener(MouseEvent.MOUSE_OUT,onDragRelease);
				this._closeBtnContainer.removeEventListener(MouseEvent.CLICK,onMouseClick);
			}
			
		}
		
		protected function onDragHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.drag();
		}
		
		protected function onDragRelease(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.release();
		}
		
		/**
		 *默认创建窗口的必要元素 
		 * 
		 */		
		private function createMustChild():void
		{
			// TODO Auto Generated method stub
			titleContainer=new Sprite();
			this._titleTxt=new TextField();
			this._titleTxt.autoSize="center";
			this._titleTxt.selectable=false;
			_closeBtnContainer=new Sprite();
			
			_winBgContainer=new Sprite();
			this.addChild(_winBgContainer);
			
			
			this._winBg=new Sprite();
			(this._winBg as Sprite).graphics.beginFill(0xcccccc);
			(this._winBg as Sprite).graphics.drawRoundRect(0,0,300,200,10,10);
			(this._winBg as Sprite).graphics.endFill();
			this._winBg.scale9Grid=new Rectangle(100,50,30,30);
			_winBgContainer.addChild(this._winBg);
			
			var temp:Sprite;
			this._closeBtn=new Sprite();
			temp=this._closeBtn as Sprite;
			temp.graphics.lineStyle(1,0xffffff);
			temp.graphics.beginFill(0x333333);
			temp.graphics.drawCircle(0,0,15);
			temp.graphics.endFill();
			
			this.addChild(titleContainer);
			
			this.dragRect=new Sprite();
			this.addChild(this.dragRect);
			this.setDragBar();
			this.dragRect.alpha=0;
			this.dragRect.buttonMode=true;
			
			this._closeBtnContainer.addChild(temp);
			temp.x=temp.width/2;
			temp.y=temp.height/2;
			this.addChild(this._closeBtnContainer);			
			this._closeBtnContainer.mouseChildren=false;
			this._closeBtnContainer.buttonMode=true;
			this.setCloseBtnPos();
			
			this.titleFormat=new TextFormat(null,15,0x0000ff,true);
			this.winTitle="标题";
			
		}
		private function setCloseBtnPos():void
		{
			var gapA:Number=5;
			this._closeBtnContainer.x=this._winBg.width-this._closeBtn.width-gapA;
			this._closeBtnContainer.y=gapA;
		}
		private function setDragBar():void
		{
			this.dragRect.graphics.beginFill(0);
			this.dragRect.graphics.drawRect(0,0,this._winBg.width,30);
			this.dragRect.graphics.endFill();
		}
		protected function onMouseClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			switch(event.currentTarget)
			{
				case this._closeBtnContainer:
					this.hide();
					break;
			}
			
		}
		private function setTitle():void
		{
			// TODO Auto Generated method stub
			while(titleContainer.numChildren>0)
			{
				titleContainer.removeChildAt(0);
			}
			if(this._winTitle is String)
			{
				this._titleTxt.text=this._winTitle;				
				this.titleContainer.addChild(this._titleTxt);
				this._titleTxt.x=0;
				this._titleTxt.y=0;				
			}else if(this._winTitle is DisplayObject)
			{
				this.titleContainer.addChild((this._winTitle as DisplayObject));
			}
			
			setTitlePos();
		}
		private function setTitlePos():void
		{
			this.titleContainer.y=5;
			this.titleContainer.x=(this._winBgContainer.width-this.titleContainer.width)/2;
		}
		protected function createChild():void
		{
			// TODO Auto Generated method stub
			
		}
		protected function reDrawWinBg(color:uint=0xcccccc):void
		{
			if(this._winBg is Sprite)
			{
				(this._winBg as Sprite).graphics.clear();
				(this._winBg as Sprite).graphics.beginFill(color);
				(this._winBg as Sprite).graphics.drawRoundRect(0,0,300,200,10,10);
				(this._winBg as Sprite).graphics.endFill();
				this._winBg.scale9Grid=new Rectangle(100,50,30,30);
			}
			
		}
		public function update(parmas:Object=null):void
		{
		}
		public function setSize(w:Number,h:Number):void
		{
			this._winBg.width=w;
			this._winBg.height=h;
			this.setDragBar();
			this.setTitlePos();
			this.setCloseBtnPos();
		}
		public function set winBg(value:DisplayObject):void
		{
			_winBg = value;
			this.setDragBar();
		}
		/**
		 *设置标题 
		 * @param val
		 * 
		 */		
		public function set winTitle(val:*):void
		{
			this._winTitle=val;
			setTitle();
			
		}
		/**
		 *设置标题的文本格式 
		 * @param format
		 * 
		 */		
		public function set titleFormat(format:TextFormat):void
		{
			this._titleTxt.defaultTextFormat=format;
		}
		/**
		 *设置拖动的范围 
		 * @param obj  {width:800,height:500,x:0,y:0}
		 * 
		 */		
		public function set dragRange(obj:Object):void
		{
			this._dragRange=obj;
		}
		/**
		 *是否可以拖动 
		 * @param val
		 * 
		 */		
		public function set isDragAble(val:Boolean):void
		{
			this._isDragAble=val;
			this.dragRect.visible=val;
		}
		/**
		 * 设置显示层 
		 * @param value
		 */		
		public function set layer(value:com.joy.UI.layer.Layer):void
		{
			_layer = value;
			/*this.hide();
			this.show();*/
		}
		/**
		 *开始拖动 
		 * 
		 */		
		protected function drag():void
		{
			if(this._isDragAble)
			{
				var rect:Rectangle;
				if(this._dragRange)
				{
					rect=new Rectangle(
						this._dragRange.x,
						this._dragRange.y,
						this._dragRange.width-this._winBg.width,
						this._dragRange.height-this._winBg.height);
				}
				this.startDrag(false,rect);
			}
			
		}
		/**
		 *结束拖动 
		 * 
		 */		
		protected function release():void
		{
			this.stopDrag();
		}
		/**
		 * 设置背景的九宫格 
		 * @param scale9Grid
		 * 
		 */		
		public function setWindowBgScale9Grid(scale9Grid:Rectangle):void
		{
			this._winBg.scale9Grid=scale9Grid;
		}
		public function removeFormParent():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		
		/**显示**/
		public function show():void
		{
			if(this._layer)
			{
				this._layer.addChild(this);
			}
			
		}
		/**隐藏**/
		public function hide():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}

	}
}