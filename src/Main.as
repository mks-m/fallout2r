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
    
    private var map:Map = new Map();
    
    public function Main():void 
    {
      if (stage) init();
      else addEventListener(Event.ADDED_TO_STAGE, init);
    }
    
    private function init(e:Event = null):void 
    {
      stage.addEventListener(Event.ENTER_FRAME, enterFrame);
      
      tm.load("data/art/tiles/tepflr12");
      
      renderBuffer = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0xFFFFFF);
      miniMap = new BitmapData(160, 120, true, 0xFFFFFF);
      stage.addChild(new Bitmap(renderBuffer));
      stage.addChild(new Bitmap(miniMap));
    }
    
    public function enterFrame(event:Event):void {
      tm.loadQueue();
      
      if (tm.getTexture("data/art/tiles/tepflr12").loaded && !map.done) {
        map.generate(tm.getTexture("data/art/tiles/tepflr12"));
      }
      
      if (map.done) {
        renderBuffer.draw(map.getBitmapDataAt(0, 0, 800, 600));
        var m:Matrix = new Matrix();
        m.identity();
        m.scale(0.1, 0.1);
        miniMap.draw(map.bitmapData, m); 
      }
    }
  }
}