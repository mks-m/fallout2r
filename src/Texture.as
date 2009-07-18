package {
	import flash.display.BitmapData;
	public class Texture {
		public var loaded:Boolean;
		public var ID:String;
		public var bitmap:BitmapData;
		public function Texture(ID_:String) {
			loaded = false;
			ID = ID_;
		}
	}
}