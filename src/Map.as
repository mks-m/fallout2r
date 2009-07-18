package  
{
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
    
    private static const MAP_SIZE:uint = 10;
    
    private var levels:Array = [];
    private var m:Main;
    
    public var bitmapData:BitmapData;
    public var done:Boolean = false;
    
    public function Map(_m:Main):void {
      m = _m;
      m.tm.load("data/art/tiles/tepflr12");
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
      
      /*
      for (i = 16; i < MAP_WIDTH; i += 16) {
        for (j = 0; j < MAP_HEIGHT; ++j) {
          bitmapData.setPixel(i, j, 0);
        }
      }
      
      for (i = 0; i < MAP_WIDTH; ++i) {
        for (j = 13; j < MAP_HEIGHT; j+=13) {
          bitmapData.setPixel(i, j, 0);
        }
      }
      */
      
      done = true;
    }
  
    public function render():void {
      m.floor.bitmapData.copyPixels(bitmapData, position(), new Point(0, 0));
    }
    
    public function renderMiniMap():void {
      //var mat:Matrix = new Matrix();
      //mat.identity();
      //mat.scale(0.1, 0.1);
      //m.miniMap.bitmapData.draw(bitmapData, mat); 
    }
    
    public function position():Rectangle {
      var cx:uint = m.center.x, cy:uint = m.center.y,
          wx:uint = 800, wy:uint = 600,
          sx:uint, sy:uint;
      sx = Math.max((MAP_WIDTH - wx) / 2  + cx, 0);
      sy = Math.max((MAP_HEIGHT - wy) / 2 + cy, 0);
      return new Rectangle(sx, sy, wx, wy);
    }
  }  
}
