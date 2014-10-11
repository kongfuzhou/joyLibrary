package com.joy.UIComponent 
{
	import com.joy.UIComponent.interFaces.IDestroy;
	import com.joy.UIComponent.interFaces.ITip;
	import com.joy.UIComponent.interFaces.IToolTip;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author zhouhonghui
	 * @date 2014/4/11 19:15:54
	 */
	public class ZUIComponent extends Sprite implements IDestroy,IToolTip
	{
		protected var container:Sprite;
		protected var curShowSytle:DisplayObject;
		protected var styleList:Dictionary;
		protected var textField:TextField;
		protected var _tipData:*;
		protected var _tipRenderer:*;
		protected var _tipInstance:DisplayObject;
		
		protected var _defW:Number=50;
		protected var _defH:Number=25;
		
		public function ZUIComponent() 
		{
			init();
		}
		private function init():void 
		{
			this.styleList = new Dictionary();
			this.container = new Sprite();
			addChild(this.container);
			this.createSkin();	
			//this.setStyle(EStyleName.UP_SKIN, DefaultSkin.getSkin(EStyleName.UP_SKIN));
			this.style = EStyleName.UP_SKIN;
			addEvent();
			
			
		}
		protected function createSkin():void
		{
			createText();
		}
		protected function createText():void 
		{
			textField = new TextField();
			textField.selectable = false;
			textField.mouseEnabled = false;
			
		}
				
		protected function clearContainer():void 
		{
			while (this.container.numChildren>0) 
			{
				this.container.removeChildAt(0);
			}
		}
		
		
		protected function addEvent():void 
		{
			this.addEventListener(MouseEvent.CLICK, onClickHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER, onOverHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, onUpHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT, onOutHandler);
		}
		protected function removeEvt():void 
		{
			this.removeEventListener(MouseEvent.CLICK, onClickHandler);
			this.removeEventListener(MouseEvent.MOUSE_OVER, onOverHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onDownHandler);
			this.removeEventListener(MouseEvent.MOUSE_UP, onUpHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT, onOutHandler);
		}
		
		protected function onOutHandler(e:Event):void 
		{
			this.style = EStyleName.UP_SKIN;
			if (this._tipInstance && this._tipInstance.parent) 
			{
				this._tipInstance.parent.removeChild(this._tipInstance);
			}
		}		
		protected function onOverHandler(e:Event):void 
		{
			this.style = EStyleName.OVER_SKIN;
			
			if (this.tipData && this._tipRenderer) 
			{				
				if (this._tipRenderer is Class) 
				{
					var tr:* = new this._tipRenderer();
					if (tr is ITip) 
					{
						(tr as ITip).data = this.tipData;
						_tipInstance = tr;
					}
				}else if (this._tipRenderer is ITip)
				{
					(this._tipRenderer as ITip).data = this.tipData;
					_tipInstance = this._tipRenderer as DisplayObject;
				}
			}
			
		}
		
		protected function onUpHandler(e:MouseEvent):void 
		{
			this.style = EStyleName.UP_SKIN;
		}
		
		protected function onDownHandler(e:MouseEvent):void 
		{
			this.style = EStyleName.DOWN_SKIN;
		}
		
		protected function onClickHandler(e:MouseEvent):void 
		{
			this.style = EStyleName.CLICK_SKIN;		
		}
		/**
		 * 渲染容器
		 * @param	child
		 */
		protected function draw(child:DisplayObject):void 
		{
			this.container.addChild(child);
			if (this.container.contains(this.textField) && (this.textField.text!="" || this.textField.htmlText!="")) 
			{
				this.container.setChildIndex(this.textField,this.container.numChildren - 1);
			}
			
		}
		protected function setTxtPos():void
		{
			if(this.curShowSytle!=null && this.textField!=null)
			{
				this.textField.x=(this.curShowSytle.width-this.textField.width)/2;
				this.textField.y=(this.curShowSytle.height-this.textField.height)/2;
			}
			
		}
		public function set style(style:String):void 
		{
			switch (style) 
			{
				case EStyleName.CLICK_SKIN:
				case EStyleName.OVER_SKIN:
				case EStyleName.OUT_SKIN:
				case EStyleName.DOWN_SKIN:
				case EStyleName.UP_SKIN:					
					if (this.styleList[style]!=null && (this.styleList[style] is DisplayObject)) 
					{						
						curShowSytle && curShowSytle.parent?curShowSytle.parent.removeChild(curShowSytle):"";
						curShowSytle = this.styleList[style] as DisplayObject;
						//curShowSytle.width=this._defW;
						//curShowSytle.height=this._defH;
						draw(curShowSytle);
					}
					break;
				case EStyleName.TEXTFORMAT:
					this.textField.defaultTextFormat=this.styleList[style] as TextFormat;
					break;
				default:
			}
		}
		
		public function set label(value:String):void 
		{
			this.textField.text = value;
			if (value=="") 
			{
				this.textField.parent?this.textField.parent.removeChild(this.textField):'';
			}else
			{
				//this.textField.width = this.container.width;
				//this.textField.height = this.container.height;
				this.draw(this.textField);
			}
		}
		
		public function get label():String 
		{
			return this.textField.text;
		}
		/**
		 * 设置文本标签的属性
		 * @param	pro 任意属性 例如:{x:100,y:50,width:50}
		 */
		public function setTFProperty(pro:Object):void 
		{
			for (var name:String in pro) 
			{
				if (this.textField.hasOwnProperty(name)) 
				{
					this.textField[name] = pro[name];
				}
			}
		}
		
		public function setStyle(style:String,renderer:*):void 
		{
			this.styleList[style] = renderer;
			if(style==EStyleName.UP_SKIN || style==EStyleName.TEXTFORMAT)
			{
				this.style=style;
			}
		}
		
		public function get tipData():*
		{
			return this._tipData;
		}
		public function set tipData(value:*):void
		{
			this._tipData = value;
		}
		/**
		 * 必须要是实现ITip的显示对象类或实例才有效
		 */
		public function set tipRenderer(value:*):void
		{			
			this._tipRenderer = value;
		}
		/**
		 * 设置尺寸(不同组件设置不同,通过继承覆盖实现)
		 * @param w
		 * @param h
		 * 
		 */		
		public function setSize(w:Number,h:Number):void
		{
			this._defW=w;
			this._defH=h;
			this.curShowSytle.width=w;
			this.curShowSytle.height=h;
		}
		
		public function destroy():void 
		{
			if (this.parent) 
			{
				this.parent.removeChild(this);
			}
			this.removeEvt();
		}
		
		
	}

}