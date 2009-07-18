package {
  import flash.display.*;
  import flash.events.*;
  import flash.net.URLRequest;
  public class TextureManager {
    
    public var textures:Array;
    public var textureLoadQueue:Array;
    public var readyToLoadImage:Boolean;
    public var URLpath:String;
    public var textureTemp:Texture;
    
    public function TextureManager(URLpath_:String) {
      URLpath = URLpath_;
      textures = new Array();
      textureLoadQueue = new Array();
      readyToLoadImage = true;
    }
    
    public function load(imageID_:String):void {
      //Allocate a spot to identify if the texture is loaded
      textures[imageID_] = new Texture(imageID_);
      //Add to the load queue to download the image file
      textureLoadQueue.push(textures[imageID_]);
    }
    
    public function loadQueue():void {
      if (textureLoadQueue.length>0) {
        if (readyToLoadImage) {
          textureTemp = textureLoadQueue.shift();
          trace("Loading: "+textureTemp.ID);
          readyToLoadImage = false;
          var loader:Loader = new Loader();
          var urlReq:URLRequest = new URLRequest(URLpath+textureTemp.ID+".png");
          loader.contentLoaderInfo.addEventListener(Event.INIT,completedLoading);
          loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorLoading);
          loader.load(urlReq);
        } else {
          trace("Texture Loading...");
        }
      }
    }
    
    public function completedLoading(eventObj:Object):void{
      trace("Done Loading: " + textureTemp.ID);
      var loader:Loader = eventObj.target.loader;
      var info:LoaderInfo = loader.contentLoaderInfo;
      textureTemp.bitmap = Bitmap(loader.content).bitmapData;  
      textureTemp.loaded = true;
      readyToLoadImage = true;
    }
    public function errorLoading(eventObj:Object):void{
      trace("Error Loading Image: " + eventObj);
      readyToLoadImage = true;
    }
    public function getTexture(ID_:String):Texture {
      return textures[ID_];
    }
  }
}