package  
{
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  
  /**
   * ...
   * @author keymone
   */
  public class Map 
  {
    private static const TILE_WIDTH:uint = 80;
    private static const TILE_HEIGHT:uint = 36;
    
    private static const TILE_OFFSET_X:uint = 32;
    private static const TILE_OFFSET_Y:uint = 24;
    
    private static const MAP_WIDTH:uint = MAP_SIZE * TILE_WIDTH - 16 * (MAP_SIZE - 1);
    private static const MAP_HEIGHT:uint = MAP_SIZE * TILE_HEIGHT + 12 * (MAP_SIZE - 1);
    
    private static const MAP_SIZE:uint = 25;
    
    private var levels:Array = [];
    
    private var m:Main;
    private var floor:Bitmap;
    private var miniMap:Bitmap;
    private var miniMapScale:Number;
    
    public var bitmapData:BitmapData;
    public var done:Boolean = false;
    
    public function Map(_m:Main, _floor:Bitmap, _miniMap:Bitmap, _miniMapScale:Number = 0.125):void {
      m = _m;
      m.tm.load("data/art/tiles/tepflr12", generate );
      
      floor = _floor;
      miniMap = _miniMap;
      miniMapScale = _miniMapScale;
      
      floor.bitmapData   = new BitmapData(m.stage.stageWidth, m.stage.stageHeight, true, 0xFFFFFF);
      miniMap.bitmapData = new BitmapData(MAP_WIDTH * miniMapScale, MAP_HEIGHT * miniMapScale, true, 0xFFFFFF);
    }
    
    public function generate():void {
      if (done)
        return;
      
      var terrain:Texture = m.tm.getTexture("data/art/tiles/tepflr12");
      
      if (!terrain.loaded)
        return;
      
      trace("Generating map " + MAP_WIDTH + "x" + MAP_HEIGHT);
      bitmapData = new BitmapData(MAP_WIDTH, MAP_HEIGHT, true);
      
      var mat:Matrix = new Matrix();
      mat.identity();
      
      var i:uint, j:uint;
      
      mat.translate(TILE_OFFSET_X * (MAP_SIZE - 1), 0);
      for (i = 0; i < MAP_SIZE; ++i) {
        for (j = 0; j < MAP_SIZE; ++j) {
          bitmapData.draw(terrain.bitmap, mat);
          mat.translate(TILE_OFFSET_X, TILE_OFFSET_Y);
        }
        mat.translate(-TILE_OFFSET_X * (MAP_SIZE + 1), -TILE_OFFSET_Y * (MAP_SIZE - 1));
      }
      
      done = true;
    }
  
    public function render():void {
      m.floor.bitmapData.copyPixels(bitmapData, position(), new Point(0, 0));
    }
    
    public function renderMiniMap():void {
      var mat:Matrix = new Matrix();
      mat.identity();
      mat.scale(miniMapScale, miniMapScale);
      miniMap.bitmapData.draw(bitmapData, mat);
      
      var pos:Rectangle = position();
      var x:uint = pos.x * miniMapScale, y:uint = pos.y * miniMapScale, 
          w:uint = pos.width * miniMapScale, h:uint = pos.height * miniMapScale;
      var i:uint, j:uint;
      for (i = x; i < x + w; ++i) {
        for (j = y; j < y + h; ++j) {
          miniMap.bitmapData.setPixel(x, j, 0xFF0000);
          miniMap.bitmapData.setPixel(i, y, 0xFF0000);
          
          miniMap.bitmapData.setPixel(x + w, j, 0xFF0000);
          miniMap.bitmapData.setPixel(i, y + h, 0xFF0000);
        }
      }
    }
    
    public function position():Rectangle {
      var cx:uint = m.center.x, cy:uint = m.center.y,
          wx:uint = 800, wy:uint = 600,
          sx:uint, sy:uint;
      sx = Math.max((MAP_WIDTH - wx) / 2  + cx, 0);
      sy = Math.max((MAP_HEIGHT - wy) / 2 + cy, 0);
      return new Rectangle(sx, sy, wx, wy);
    }
    
    public function moveScreen():void {
      var p:Rectangle = position();
      var d:int = 0;
      
      if (m.mouseX < 20) {
        d = Math.max(7 - p.x, 0);
        m.center.x -= 7 - d;
      } else if (m.mouseX > 780) {
        d = Math.max(7 - (MAP_WIDTH - p.x - p.width), 0);
        m.center.x += 7 - d;
      }
      
      if (m.mouseY < 20) {
        d = Math.max(5 - p.y, 0);
        m.center.y -= 5 - d;
      } else if (m.mouseY > 580) {
        d = Math.max(5 - (MAP_HEIGHT - p.y - p.height), 0);
        m.center.y += 5 - d;
      }
    }
  }  
}
