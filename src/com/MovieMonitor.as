package  com{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;

	public class MovieMonitor extends Sprite {
		private var xml:XML;
		private var theText:TextField;
		private var fps:int = 0;
		private var ms:uint;
		private var lastTimeCheck:uint;
		private var maxMemory:Number = 0;
		private var fpsVector:Vector.<Number> = new Vector.<Number>();
		private var childrenCount:int;

		public function MovieMonitor():void {
			xml = <xml>
					<sectionTitle>帧率监控</sectionTitle>
					<sectionLabel>帧率: </sectionLabel>
					<framesPerSecond>-</framesPerSecond>
					<sectionLabel>帧率/分 </sectionLabel>
					<averageFPS>-</averageFPS>
					<sectionLabel>毫秒/帧:</sectionLabel>
					<msFrame>-</msFrame>
					<sectionTitle>内存监控</sectionTitle>
					<sectionLabel>播放器分配内存(MB): </sectionLabel>
					<directMemory>-</directMemory>
					<sectionLabel>历史最大内存(MB): </sectionLabel>
					<directMemoryMax>-</directMemoryMax>
					<sectionLabel>浏览器总内存(MB): </sectionLabel>
					<veryTotalMemory>-</veryTotalMemory>
					<sectionLabel>待回收内存(MB): </sectionLabel>
					<garbageMemory>-</garbageMemory>
					<sectionTitle>舞台监控</sectionTitle>
					<sectionLabel>宽: </sectionLabel>
					<widthPx>-</widthPx>
					<sectionLabel>高: </sectionLabel>
					<heightPx>-</heightPx>
					<sectionLabel>显示对象数: </sectionLabel>
					<nChildren>-</nChildren>
					<sectionTitle>播放器版本</sectionTitle>
					<version>-</version>
					<sectionTitle>操作系统</sectionTitle>
					<os>-</os>
				</xml>;
			var style:StyleSheet = new StyleSheet();
			style.setStyle("xml", {fontSize: "12px", fontFamily: "arial"});
			style.setStyle("sectionTitle", {color: "#FFAA00"});
			style.setStyle("sectionLabel", {color: "#CCCCCC", display: "inline"});
			style.setStyle("framesPerSecond", {color: "#FFFFFF"});
			style.setStyle("msFrame", {color: "#FFFFFF"});
			style.setStyle("averageFPS", {color: "#FFFFFF"});
			style.setStyle("directMemory", {color: "#FFFFFF"});
			style.setStyle("veryTotalMemory", {color: "#FFFFFF"});
			style.setStyle("garbageMemory", {color: "#FFFFFF"});
			style.setStyle("directMemoryMax", {color: "#FFFFFF"});
			style.setStyle("widthPx", {color: "#FFFFFF"});
			style.setStyle("heightPx", {color: "#FFFFFF"});
			style.setStyle("nChildren", {color: "#FFFFFF"});
			style.setStyle("version", {color: "#FFFFFF"});
			style.setStyle("os", {color: "#FFFFFF"});
			theText = new TextField();
			theText.autoSize = TextFieldAutoSize.LEFT;
			theText.styleSheet = style;
			theText.condenseWhite = true;
			theText.selectable = false;
			theText.mouseEnabled = false;
			theText.background = true;
			theText.backgroundColor = 0x000000;
			theText.mouseEnabled = false;
			theText.mouseWheelEnabled
			addChild(theText);
			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e:Event):void {
			var timer:int = getTimer();
			if (timer - 1000 > lastTimeCheck) {
				var vectorLength:int = fpsVector.push(fps);
				if (vectorLength > 60) {
					fpsVector.shift();
				}
				var vectorAverage:Number = 0;
				for (var i:Number = 0; i < fpsVector.length; i++) {
					vectorAverage += fpsVector[i];
				}
				vectorAverage = vectorAverage / fpsVector.length;
				xml.averageFPS = Math.round(vectorAverage);
				var directMemory:Number = System.totalMemory;
				maxMemory = Math.max(directMemory, maxMemory);
				xml.directMemory = (directMemory / 1048576).toFixed(3);
				xml.directMemoryMax = (maxMemory / 1048576).toFixed(3);
				xml.veryTotalMemory = (System["privateMemory"] / 1048576).toFixed(3);
				xml.garbageMemory = (System["freeMemory"] / 1048576).toFixed(3);
				xml.framesPerSecond = fps + " / " + stage.frameRate;
				xml.widthPx = stage.width + " / " + stage.stageWidth;
				xml.heightPx = stage.height + " / " + stage.stageHeight;
				childrenCount = 0;
				countDisplayList(stage);
				xml.nChildren = childrenCount;
				xml.version = Capabilities.version;
				xml.os = Capabilities.os;
				fps = 0;
				lastTimeCheck = timer;
			}
			fps++;
			xml.msFrame = (timer - ms);
			ms = timer;
			theText.htmlText = xml;
			
			if (this.parent && this.parent.getChildIndex(this) != this.parent.numChildren - 1) {
				this.parent.setChildIndex(this, this.parent.numChildren - 1);
			}
			
			this.visible = true;
			if (mouseX <= this.width && mouseY <= this.height) {
				this.visible = false;
			}
		}

		private function countDisplayList(container:DisplayObjectContainer):void {
			childrenCount += container.numChildren;
			for (var i:uint = 0; i < container.numChildren; i++) {
				if (container.getChildAt(i) is DisplayObjectContainer) {
					countDisplayList(DisplayObjectContainer(container.getChildAt(i)));
				}
			}
		}
	}
}