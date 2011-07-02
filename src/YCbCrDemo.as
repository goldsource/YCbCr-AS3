package 
{
	
	import de.goldsource.utils.YCbCr;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class YCbCrDemo extends Sprite
	{		
		
		private var __loader:Loader;
		private var __loaderMask:Bitmap;
		private var __yChannel:Channel;
		private var __cbChannel:Channel;
		private var __crChannel:Channel;
		
		public function YCbCrDemo()
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			__loader = new Loader();
			__loaderMask = new Bitmap(new BitmapData(360,360,false,0x000000));		
			__loaderMask.x = __loaderMask.y = __loader.y = __loader.x = 0;
			__loader.mask = __loaderMask;			
			addChild(__loader);
			addChild(__loaderMask);
			
			__yChannel = new Channel("Y",0,360);
			__cbChannel = new Channel("Cb",120,360);
			__crChannel = new Channel("Cr",240,360);
			
			addChild(__yChannel);
			addChild(__cbChannel);	
			addChild(__crChannel);	
			
			__loader.contentLoaderInfo.addEventListener(Event.COMPLETE,__onLoaderComplete);
			__loader.load(new URLRequest("assets/img/dummyImage.jpg"));
		}
		
		private function __onLoaderComplete($e:Event):void{
			__loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,__onLoaderComplete);
			__splitBitmapChannels(Bitmap(__loader.content).bitmapData)
		}
		
		private function __splitBitmapChannels($bitmapData:BitmapData):void{	
			__yChannel.bitmapData.fillRect(__yChannel.bitmapData.rect,0);
			__cbChannel.bitmapData.fillRect(__yChannel.bitmapData.rect,0);
			__yChannel.bitmapData.fillRect(__yChannel.bitmapData.rect,0);
			for(var i:uint=0;i<$bitmapData.height;i++){
				for(var k:uint=0;k<$bitmapData.width;k++){
					var yCbCr:Vector.<uint> = YCbCr.vectorFromRGB($bitmapData.getPixel(k,i));
					__yChannel.bitmapData.setPixel(k,i,yCbCr[0] << 16 ^ yCbCr[0] << 8 ^ yCbCr[0]);
					__cbChannel.bitmapData.setPixel(k,i,yCbCr[1] << 16 ^ yCbCr[1] << 8 ^ yCbCr[1]);
					__crChannel.bitmapData.setPixel(k,i,yCbCr[2] << 16 ^ yCbCr[2] << 8 ^ yCbCr[2]);
				}
			}
			
		}
	}
}
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

internal class Channel extends Sprite{
	private var __screen:Bitmap;
	public function Channel($label:String,$x:uint,$y:uint){
		x = $x;
		y = $y;		
		__screen = new Bitmap(new BitmapData(360,360,false,0x000000),PixelSnapping.AUTO,true);
		__screen.scaleX = __screen.scaleY = .333;
		
		addChild(__screen);
		var label:Label = new Label($label);
		label.x =__screen.x + (__screen.width-label.width)/2;		
		label.y =__screen.y + (__screen.height-label.height)/2;
		addChild(label);
	}
	
	public function get bitmapData():BitmapData{
		return __screen.bitmapData;
	}
}

internal class Label extends TextField{
	public function Label($text:String){
		defaultTextFormat=new TextFormat("_sans",24,0xFFFFFF,true);
		width = height = 1;
		autoSize = TextFieldAutoSize.LEFT;
		text = $text;
	}
}