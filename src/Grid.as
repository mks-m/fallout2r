package  
{
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  
  /**
   * ...
   * @author keymone
   */
  public class Grid 
  {
    private var m:Main;
    private var hex:Texture;
    
    public function Grid(_m:Main):void {
      m = _m;
      m.tm.load("data/art/interface/grid");
      hex = m.tm.getTexture("data/art/interface/grid");
    }
    
    public function render():void {
      if (!hex.loaded)
        return;
      
      var r:Rectangle = m.map.position();
      var p:Point = positionToHex(new Point(r.x + m.mouseX, r.y + m.mouseY));
      var mat:Matrix = new Matrix();
      mat.identity();
      mat.translate(p.x - r.x, p.y - r.y);
      m.floor.bitmapData.draw(hex.bitmap, mat, null, null, null, true);
    }
    
    private static function positionToHex(p:Point):Point {
      var col:int = p.x / 16;
      var row:int = p.y / 13;
      var diagonal:Array = [
        [3,3,3,2,2,2,2,1,1,1,1,1,0,0,0],
        [0,0,1,1,1,1,1,2,2,2,2,2,3,3,3]
      ];

      if( p.y % 13 < diagonal[(row+col) % 2][p.x % 16] ) {
        row--;
      }
      
      if (row % 2 == 0) {
        col -= col % 2;
      } else if (col % 2 == 0) {
        col--;
      }
      
      return new Point(col * 16, row * 13);
    }
  }
}
