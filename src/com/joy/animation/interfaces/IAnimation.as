package com.joy.animation.interfaces 
{
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public interface IAnimation 
	{
		function get sequence():Vector.<BitmapData>;
		function set sequence(values:Vector.<BitmapData>):void;
		function get curFrame():int;
		function get totalFrames():int;
		function get playToggle():Boolean;
		function set playToggle(value:Boolean):void;
		function get loop():Boolean;
		function set loop(value:Boolean):void;		
		function get onEnd():Function;
		function set onEnd(value:Function):void;
		function get curStatus():String;
		function set curStatus(value:String):void;
		function get statusCurFrame():int;
		
		function setSequence(bitmapData:BitmapData,info:Object):void;
		function gotoAndStop(tag:*):void;
		function gotoAndPlay(tag:*):void;
		function setFrameLabel(label:String,frame:int):void;
		function stop():void;
		function play():void;
		function addFrameScript(...args):void;
		function update():void;
		function setStatusByStepFrame(status:Array, stepFrame:int):void;
		function setStatusInfo(status:String, startFrame:int, endFrame:int):void;
		function destroy():void;
	}
	
}