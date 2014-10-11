package com.joy.animation 
{
	import com.joy.animation.interfaces.IAnimation;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	/**
	 * 播放位图序列
	 * @author kongfuzhou
	 * @date   2014/5/27 10:05:01
	 */
	public class BitmapSprite extends Sprite implements IAnimation
	{
		private var _curStatus:String;
		public var farmeRate:Number;		
		protected var _curFrame:int;
		protected var _totalFrames:int;
		protected var _isStop:Boolean;
		protected var _loop:Boolean = true;		
		protected var _playToggle:Boolean = false;
		
		private var maxFrame:int;
		private var minFrame:int=1;
		
		protected var _sequence:Vector.<BitmapData>;
		protected var _sequenceBmpd:BitmapData;
		protected var frameLabelMap:Dictionary;		
		private var timer:Timer;
		private var _seqInfo:Object;
		private var _onEnd:Function;		
		private var _frameScriptMap:Dictionary;
		/**状态信息**/
		private var statusMap:Dictionary;
		
		private var bodyBmp:Bitmap;
		
		/**
		 * 播放位图序列
		 * @param	farmeRate 帧频(自动刷新的timer会根据该参数执行)
		 */
		public function BitmapSprite(farmeRate:Number=30) 
		{
			super();
			this.farmeRate = farmeRate;
			init();			
		}
		
		private function init():void 
		{
			frameLabelMap = new Dictionary();
			_frameScriptMap = new Dictionary();
			statusMap = new Dictionary();
			this._curFrame = this.minFrame;
			bodyBmp = new Bitmap();
			addChild(bodyBmp);
		}
		
		private function onTimerRun(e:TimerEvent):void 
		{
			this.moving();
		}
		private function calTrueTotalFrames():void 
		{
			this._totalFrames = this._sequence.length;
			this.maxFrame = this._totalFrames;
		}
		/**
		 * 根据状态播放
		 * @param	status
		 */
		private function playByStatus(status:String):void 
		{
			var statusInfo:Object = this.statusMap[status];
			if (statusInfo) 
			{
				this.minFrame = statusInfo.stf;
				this.maxFrame = statusInfo.edf;
			}
		}
		private function moving():void 
		{			
			if (!this._isStop) 
			{
				if (this.minFrame<=this.maxFrame) 
				{				
					this.bodyBmp.bitmapData = this._sequence[this.minFrame-1];					
					if (this._frameScriptMap[this.minFrame]!=null) //执行注册的帧函数
					{
						this._frameScriptMap[this.minFrame](this);
					}
					this.minFrame++;					
					if (this.minFrame>this.maxFrame) //播放到最后一帧
					{
						if (this._onEnd!=null) 
						{
							this._onEnd(this);
						}
						//循环播放 
						if (this._loop) 
						{
							var statusInfo:Object = this.statusMap[this.curStatus];
							statusInfo?this.minFrame = statusInfo.stf:this.minFrame = 1;														
						}else
						{
							this.minFrame = this.maxFrame;
							this.stop();
						}
					}
					this._curFrame = this.minFrame;
					//trace("statusCurFrame ",statusCurFrame," this._curFrame ",this._curFrame);
				}
			}
		}
		/**
		 * 把序列图片存到vector
		 */
		private function copyToSeq():void 
		{
			
			var source:BitmapData;
			var rows:int = this._seqInfo.rows;
			var cols:int = this._seqInfo.cols;
			var width:Number = this._seqInfo.width;
			var height:Number = this._seqInfo.height;
			var max:int = this._seqInfo.max;
			var len:int = 0;
			for (var i:int = 0; i < rows; i++) 
			{
				for (var j:int = 0; j < cols; j++) 
				{
					len = (i + 1) * (j + 1);
					if (len<=max)
					{
						//source
						source = new BitmapData(width, height);
						//对不draw方法效率更高
						source.copyPixels(this._sequenceBmpd, new Rectangle(j * width, i * height, width, height), new Point(0, 0));
						this._sequence.push(source);
					}
				}
			}
		}
		/**
		 * 把位图信息draw到vector
		 */
		private function drawToSeq():void 
		{
			var source:BitmapData;
			var rows:int = this._seqInfo.rows;
			var cols:int = this._seqInfo.cols;
			var width:Number = this._seqInfo.width;
			var height:Number = this._seqInfo.height;
			var max:int = this._seqInfo.max;
			var len:int = 0;
			
			var m:Matrix=new Matrix();
			
			for (var i:int = 0; i < rows; i++) 
			{
				for (var j:int = 0; j < cols; j++) 
				{
					len = (i + 1) * (j + 1);
					if (len<=max)
					{
						//source
						source=new BitmapData(width, height,true,0);
						m.translate( -j * width, -i * height);
						source.draw(this._sequenceBmpd, m);//对不copyPixels效率低，因为用的Matrix
						this._sequence.push(source);
					}
				}
			}
			
		}
		
		private function tagHandler(tag:*,isPlay:Boolean):void 
		{
			if (tag is int) 
			{
				this.minFrame = tag;
				this._curFrame = this.minFrame;				
			}else if (tag is String)
			{
				if (this.frameLabelMap[tag]) 
				{
					this.minFrame = this.frameLabelMap[tag];
					this._curFrame = this.minFrame;	
				}else
				{
					return;
				}
			}else
			{
				throw new Error("tag must be an int or String vars ");
			}
			this.curStatus = "";
			if (isPlay) 
			{
				this.play();
			}else
			{
				this.stop();
			}
		}
		
		/**
		 * 播放到最后一帧触发的函数
		 */
		public function get onEnd():Function
		{
			return this._onEnd;
		}
		public function set onEnd(value:Function):void
		{
			this._onEnd = value;
		}
		/**
		 * 图片序列
		 */
		public function get sequence():Vector.<BitmapData>
		{
			return this._sequence;
		}
		
		public function set sequence(values:Vector.<BitmapData>):void
		{
			this._sequence = values;
			this.calTrueTotalFrames();			
		}
		public function get curFrame():int
		{
			return this._curFrame;
		}
		public function get totalFrames():int
		{
			return this._totalFrames;
		}
		/**
		 * 启用自带timer刷新
		 */
		public function get playToggle():Boolean 
		{
			return _playToggle;
		}
		
		public function set playToggle(value:Boolean):void 
		{
			_playToggle = value;
			if (_playToggle) 
			{
				if (!timer) 
				{					
					var delay:Number = 1000/this.farmeRate	; //
					timer = new Timer(150);
					timer.addEventListener(TimerEvent.TIMER, onTimerRun);
				}
				timer.reset();
				timer.start();
			}else
			{
				if (timer)
				{
					timer.stop();
				}
			}
			
		}
		
		public function get loop():Boolean 
		{
			return _loop;
		}
		
		public function set loop(value:Boolean):void 
		{
			_loop = value;
		}
		/**
		 * 当前状态的当前帧(非状态模式返回-1)
		 */
		public function get statusCurFrame():int
		{
			var statusInfo:Object = this.statusMap[this._curStatus];
			if (!statusInfo) 
			{
				return -1;
			}			
			var f:int = this._curFrame-statusInfo.stf+1;
			
			return f;
			
		}
		/**
		 * 设置状态模式动画
		 */
		public function get curStatus():String 
		{
			return _curStatus;
		}
		
		public function set curStatus(value:String):void 
		{
			_curStatus = value;
			this.playByStatus(_curStatus);
		}
		/**
		 * 停在某帧或帧标签（将会消除状态模式）
		 * @param	tag
		 */
		public function gotoAndStop(tag:*):void
		{
			this.tagHandler(tag,false);
			
		}
		/**
		 * 从某帧或帧标签开始播放（将会消除状态模式）
		 * @param	tag
		 */
		public function gotoAndPlay(tag:*):void 
		{
			this.tagHandler(tag,true);			
		}
		public function stop():void
		{
			this._isStop = true;
		}
		public function play():void
		{
			this._isStop = false;			
		}
		/**
		 * 刷新动画
		 */
		public function update():void
		{
			if (!this._playToggle) 
			{
				this.moving();
			}
		}
		/**
		 * 根据特定步长帧设置状态信息
		 * @param	status
		 * @param	stepFrame
		 */
		public function setStatusByStepFrame(status:Array,stepFrame:int):void 
		{
			var len:int = status.length;
			var stf:int;
			var endf:int;
			for (var i:int = 0; i < len; i++) 
			{
				stf = i * stepFrame+1;
				endf = stf + stepFrame-1;
				this.setStatusInfo(status[i], stf, endf);
			}
		}
		/**
		 * 设置状态信息
		 * @param	status
		 * @param	startFrame
		 * @param	endFrame
		 */
		public function setStatusInfo(status:String,startFrame:int,endFrame:int):void 
		{
			if (startFrame>=1 && endFrame<=this._totalFrames && endFrame-startFrame>=1) 
			{
				//stf:开始帧,enf:结束帧,spf:状态总帧
				this.statusMap[status] = {stf:startFrame,edf:endFrame,spf:endFrame-startFrame+1 };
			}			
		}
		
		/**
		 * 设置帧标签
		 * @param	label 标签
		 * @param	frame 帧
		 */
		public function setFrameLabel(label:String, frame:int):void
		{
			if (!this.frameLabelMap[label] && this._totalFrames>=frame) 
			{
				this.frameLabelMap[label] = frame;
			}
		}
		/**
		 * 设置序列源(横向切割)
		 * @param	bitmapData 序列图片
		 * @param	info	   必须信息	{rows:2,cols:2,max:10,width:50,height:100}
		 */
		public function setSequence(sequenceBmpd:BitmapData, seqInfo:Object):void
		{
			this._sequenceBmpd = sequenceBmpd;
			this._seqInfo = seqInfo;
			this._sequence = new Vector.<BitmapData>();
			var n:int = getTimer();
			this.copyToSeq();							
			//this.drawToSeq();
			this.sequence = this._sequence;			
		}		
		/**
		 * 添加帧执行函数
		 * @param	...args 帧,函数,帧,函数,....
		 * 特别说:回调函数会把本身作为参数传过去
		 */
		public function addFrameScript(...args):void
		{
			var len:int = args.length;
			var frame:int;
			var func:Function;
			for (var i:int = 0; i < len; i++) 
			{
				frame = args[i];
				if (frame<=this._totalFrames) 
				{
					i++;
					if (i<len)
					{
						func=args[i] as Function;
						func != null?this._frameScriptMap[frame] = func:"";
					}
				}				
			}
			
		}
		/**
		 * 垃圾回收
		 */
		public function destroy():void
		{
			if (this.timer) 
			{
				this.timer.removeEventListener(TimerEvent.TIMER, this.onTimerRun);
				this.timer = null;
			}
			if (this.parent) 
			{
				this.parent.removeChild(this);
			}
			this._frameScriptMap = null;
			this._sequence = null;
			this._sequenceBmpd = null;
			this.frameLabelMap = null;
			this._onEnd = null;
			this._seqInfo = null;
			this.statusMap = null;
		}
		
	}

}