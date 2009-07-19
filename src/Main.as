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
    public var floor:Bitmap;
    public var miniMap:Bitmap;
    public var center:Point;
    
    public var map:Map;
    public var grid:Grid;
    
    public function Main():void 
    {
      if (stage) init();
      else addEventListener(Event.ADDED_TO_STAGE, init);
    }
    
    private function init(e:Event = null):void 
    {
      stage.addEventListener(Event.ENTER_FRAME, enterFrame);
      
      map = new Map(this, floor = new Bitmap(), miniMap = new Bitmap());
      grid = new Grid(this);
      center = new Point(0, 0);
      
      stage.addChild(floor);
      stage.addChild(miniMap);
    }
    
    public function enterFrame(event:Event):void {
      tm.loadQueue();
      
      if (map.done) {
        map.moveScreen();
        map.render();
        map.renderMiniMap();
      }
      
      grid.render();
    }
  }
}