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
    
    private static const MAP_SIZE:uint = 25;
    
    private var levels:Array = [];
    
    public var bitmapData:BitmapData;
    
    public var done:Boolean = false;
    
    public function generate(terrain:Texture):void {
      if (done) {
        return;
      }
      
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
    
    public function getBitmapDataAt(cx:uint, cy:uint, wx:uint, wy:uint):BitmapData {
      var bd:BitmapData = new BitmapData(wx, wy);
      var rsx:uint, rsy:uint;
      rsx = Math.max((MAP_WIDTH - wx) / 2  + cx, 0);
      rsy = Math.max((MAP_HEIGHT - wy) / 2 + cy, 0);
      bd.copyPixels(bitmapData, new Rectangle(rsx, rsy, wx, wy), new Point(0, 0));
      return bd;
    }
  }
  
}