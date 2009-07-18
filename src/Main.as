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
      stage.addEventListener(Event.ENTER_FRAME, EnterFrame);
      
      tm.Load("data/art/tiles/tepflr12");
      
      renderBuffer = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0xFFFFFF);
      miniMap = new BitmapData(160, 120, true, 0xFFFFFF);
      stage.addChild(new Bitmap(renderBuffer));
      stage.addChild(new Bitmap(miniMap));
    }
    
    public function EnterFrame(event:Event):void {
      tm.LoadQueue();
      
      if (terrain.loaded && !map.done) {
        map.Generate(tm.GetTexture("data/art/tiles/tepflr12"));
      }
      
      if (map.done) {
        renderBuffer.draw(map.GetBitmapDataAt(0, 0, 800, 600));
        var m:Matrix = new Matrix();
        m.identity();
        m.scale(0.1, 0.1);
        miniMap.draw(map.bitmapData, m); 
      }
    }
  }
}