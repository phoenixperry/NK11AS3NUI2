package com.phoenixperry {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapDataCatcher {
		
		private static var bitmapDatasCache:Array = [];
		private static var extractionsCache:Array = [];
		private static const POINT:Point = new Point;
		public static var CACHE_MAX_SIZE:int = 50;
		private static var _extractionsCacheSize:int = 0;
		
		public function BitmapDataCatcher() {
		}
		
		public static function cacheBitmap(cacheId:String, bitmap:Bitmap, atlasXml:XML = null):void {
			cacheBitmapData(cacheId, bitmap.bitmapData, atlasXml);
		}
		
		public static function cacheBitmapData(cacheId:String, bitmapData:BitmapData, atlasXml:XML = null):void {
			// store the BitmapData, only extract it once it is requested
			bitmapDatasCache[cacheId] = [bitmapData, atlasXml];
		}
		
		/**
		 *  if in the atlas, the name is FISH_SWIM_004, pass FISH_SWIM, 4 to this method as texturePrefix and textureIndex
		 */
		public static function getBitmapData(cacheId:String, texturePrefix:String, textureIndex:int = 0):BitmapData {
			var i:int = 0;
			var infos:Array = bitmapDatasCache[cacheId];
			if (!infos || infos.length < 1) {
				return null;
			}
			var bitmapData:BitmapData = BitmapData(infos[0]);
			var atlasXml:XML = infos[1];
			if (!atlasXml) {
				// we have just been storing bitmapDatas
				return bitmapData;
			}
			
			for each (var subTexture:XML in atlasXml.SubTexture) {
				var name:String = subTexture.attribute("name");
				if (name.indexOf(texturePrefix) != 0) {
					continue;
				}
				if (i == textureIndex) {
					var extractionCacheId:String = cacheId + "__" + name;
					var fromCache:BitmapData = extractionsCache[extractionCacheId];
					if (fromCache) {
						return fromCache;
					}
					// we found the right texture, let's extract it
					var x:Number = parseFloat(subTexture.attribute("x"));
					var y:Number = parseFloat(subTexture.attribute("y"));
					var width:Number = parseFloat(subTexture.attribute("width"));
					var height:Number = parseFloat(subTexture.attribute("height"));
					var region:Rectangle = new Rectangle(x, y, width, height);
					// clean
					if (_extractionsCacheSize > CACHE_MAX_SIZE) {
						extractionsCache.length = 0;
					}
					// extract the right part of the Bitmap
					var extraction:BitmapData = new BitmapData(width, height, true, 0);
					extraction.copyPixels(bitmapData, region, POINT);
					extractionsCache[extractionCacheId] = extraction;
					_extractionsCacheSize++;
					return extraction;
				}
				i++;
			}
			return null;
		}
	}
} 