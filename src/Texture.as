package {
  import flash.display.BitmapData;
  public class Texture {
    public var loaded:Boolean;
    public var ID:String;
    public var bitmap:BitmapData;
    public var callback:Function;
    public function Texture(ID_:String, callback_:Function = null) {
      loaded = false;
      ID = ID_;
      callback = callback_;
    }
  }
}