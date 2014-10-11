package com.joy.util
{
	import flash.display.BitmapData;
	import flash.errors.IOError;
	import flash.utils.ByteArray;
	import com.adobe.images.PNGEncoder;
	
	/**
	 * Util functions for saving data to a PNG image
	 * @author Damian Connolly
	 */
	public class DataImageUtils
	{
		
		/**
		 * Converts a data string to a PNG. As we're writing to RGB, this assumes that
		 * all characters in the String conform to the ASCII chart:
		 * (http://www.asciitable.com/ or http://stevehardie.com/2009/09/character-code-list-char-code/).
		 * If this isn't the case, then Base64 encode your string first
		 * @param data The data that we want to convert
		 * @return A ByteArray representing a PNG, or null, if the data was bad
		 */
		public static function toPNG( data:String ):ByteArray
		{
			// failsafe
			if ( data == null || data == "" )
			{
				trace( "3:Can't convert data to a PNG, as no data was passed" );
				return null;
			}
			
			// write our string to a ByteArray and compress it
			var rgb:ByteArray = new ByteArray;
			rgb.writeUTFBytes( data );
			rgb.compress();
			
			// as we're writing to a 32 bit PNG, we need to round it up
			// so that our ByteArray divides nicely by 4.
			// OR it *would* be 4, if flash returned the proper colour values
			// for non-opaque colours. Basically, if the alpha is less than 0xFF,
			// because the colours are pre-multiplied by the alpha, to get the
			// actual colour value back, flash makes an approximation, which can
			// be pretty wrong. E.g. setPixel32( 0, 0, 0x00ffffff ) =>
			// getPixel32( 0, 0 ); // 0x00000000 because the alpha is 0.
			// Because of this, we can't simply copy our ByteArray to a BitmapData,
			// rather we need to replace the alpha, which means writing out the
			// bytes by hand, so our ByteArray needs to be divisible by 3 (rgb)
			while ( ( rgb.length % 3 ) != 0 )
				rgb.writeByte( 0 ); // fill the remainder with NUL chars
			rgb.position = 0;
			
			// find the factors for our BitmapData - take our ByteArray
			// length / 3 (rgb) and get the biggest factors we can to make the
			// squarest image possible - NOTE: depending on the data, it's possible
			// that this can lead a skewed image, if it only has a small number of factors
			var numPixels:int           = rgb.length / 3; // number of pixels in our image, if ba = rgb
			var factors:Vector.<uint>     = DataImageUtils._getFactors( numPixels );
			var index:int               = factors.length / 2;
			var w:int                   = factors[index];
			var h:int                   = factors[index - 1];
			
			// check the size
			if ( w > 8191 || h > 8191 || ( w * h ) > 16777215 )
				trace( "2:The image size (" + w + "x" + h + ") is pretty big; you might run into some issues when treating it" );
			
			// create a new ByteArray, replacing all the alphas for our pixels with 255 
			// (so we get accurate colour values when reading it back in - see note above)
			var argb:ByteArray = new ByteArray;
			for ( var i:int = 0; i < numPixels; i++ )
			{
				var r:uint = rgb.readUnsignedByte();
				var g:uint = rgb.readUnsignedByte();
				var b:uint = rgb.readUnsignedByte();
				argb.writeUnsignedInt( ( r << 16 ) | ( g << 8 ) | b ); // alpha will be automatically 255
			}
			argb.position = 0;
			
			// create our BitmapData, and write our data
			var bmd:BitmapData = new BitmapData( w, h, false );
			bmd.setPixels( bmd.rect, argb );
			
			// create our PNG (using blooddy crypto)
			var png:ByteArray = PNGEncoder.encode( bmd );
			
			// clean up our memory, then return
			rgb.clear();
			argb.clear();
			bmd.dispose();
			return png;
		}
		
		
		
		/**
		 * 
		 * Converts a PNG BitmapData to a String
		 * @param png The BitmapData data for our PNG
		 * @return A String recovered from the PNG data, or null if our data was bad
		 */
		public static function fromPNG( png:BitmapData ):String
		{
			// failsafe
			if ( png == null || png.width == 0 || png.height == 0 )
			{
				trace( "3:Can't convert a PNG to data, as no BitmapData was passed" );
				return null;
			}
			
			// get our ByteArray data - NOTE: because flash only gives accurate colour
			// values if the alpha is 0xFF, we need to strip out all the alpha bytes
			var rgb:ByteArray   = new ByteArray;
			var argb:ByteArray  = png.getPixels( png.rect );
			argb.position       = 0;
			var numPixels:int   = argb.length / 4;
			for ( var i:int = 0; i < numPixels; i++ )
				rgb.writeBytes( argb, ( 4 * i ) + 1, 3 );
			
			// uncompress
			rgb.position = 0;
			
			try { rgb.uncompress(); }
			catch ( e:IOError ) { trace( "3:The recovered ByteArray couldn't be uncompressed, did you use toPNG()?" ); }
			
			// clean up our memory, then return
			var str:String = rgb.readUTFBytes( rgb.length );
			rgb.clear();
			argb.clear();
			return str;
		}
		
		/********************************************************************************/
		
		// gets all the factors for a number
		private static function _getFactors( n:uint ):Vector.<uint>
		{
			// if it's 0, then there's no factors
			if ( n == 0 )
				return new Vector.<uint>( 0, true );
			
			// if it's 1, then the only factor is itself
			var v:Vector.<uint> = null;
			if ( n == 1 )
			{
				v       = new Vector.<uint>( 1, true );
				v[0]    = 1;
				return v;
			}
			
			// find our factors
			v = new Vector.<uint>;
			v.push( 1 );    // 1 is always a factor
			v.push( n );    // our number itself is always a factor
			for ( var i:uint = 2; i * i <= n; i++ )
			{
				// if it divides evenly, then add the divisor and quotient
				if ( ( n % i ) == 0 )
				{
					v.push( i );
					v.push( n / i );
				}
			}
			return v.sort( Array.NUMERIC ); // sort before returning
		}
		
	}
	
}