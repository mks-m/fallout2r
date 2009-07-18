package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.ui.*;
	import flash.utils.*;
	
	/**
	 * ...
	 * @author keymone
	 */
	public class Main extends Sprite 
	{
		public var tm:TextureManager = new TextureManager("");
		public var renderBuffer:BitmapData;
		public var miniMap:BitmapData;
		public var terrain:Texture;
		public var tickFPS:uint, fps:uint;
		public var fpsText:TextField = new TextField();
		public var intervalFPS:Timer;
		
		private var map:Map = new Map();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			stage.addEventListener(Event.ENTER_FRAME, EnterFrame);
			
			tm.Load("data/art/tiles/tepflr12");
			terrain = tm.GetTexture("data/art/tiles/tepflr12");
			
			renderBuffer = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0xFFFFFF);
			miniMap = new BitmapData(160, 120, true, 0xFFFFFF);
			stage.addChild(new Bitmap(renderBuffer));
			stage.addChild(new Bitmap(miniMap));
			
			intervalFPS = new Timer(1000, 0);
            intervalFPS.addEventListener("timer", UpdateFPS);
            intervalFPS.start();
			
			fpsText.x = 10;
			fpsText.y = 10;
			fpsText.autoSize = TextFieldAutoSize.LEFT;
			fpsText.text = "FPS: 0/30";
			stage.addChild(fpsText);
		}
		
		public function EnterFrame(event:Event):void {
			tm.LoadQueue();
			
			//Clear the buffer
			if (terrain.loaded && !map.done) {
				map.Generate(terrain);
			}
			
			if (map.done) {
				renderBuffer.draw(map.GetBitmapDataAt(0, 0, 800, 600));
				var m:Matrix = new Matrix();
				m.identity();
				m.scale(0.1, 0.1);
				miniMap.draw(map.bitmapData, m);
				
			}
			
			fpsText.text = "FPS: " + fps.toString() + "/30";
			tickFPS++;
		}
		
		public function UpdateFPS(event:TimerEvent):void {
            fps = tickFPS;
			tickFPS = 0;
        }
		
	}
	
}