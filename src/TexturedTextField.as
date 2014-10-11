package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * 纹理效果的文本
	 * Creates a TextField that's textured by an image
	 */
	public class TexturedTextField extends Bitmap
	{
		/**************************************************************************************************/
		
		/**
		 * When using the texture, should we sample a rample position?
		 */
		public var useRandomTexturePos:Boolean = true;
		
		/**************************************************************************************************/
		
		private var m_text:TextField		= null;         // the TextField that we use to write our text
		private var m_texture:BitmapData	= null;         // the texture that we're going to texture our TextField with
		private var m_textBMD:BitmapData	= null;         // the BitmapData that we use to draw our TextField
		private var m_drawPoint:Point		= new Point;    // Point used in drawing the final BitmapData
		private var m_drawRect:Rectangle	= new Rectangle;// the Rectangle we use to determine which part of the texture to take
		private var m_loader:Loader			= null;			// the loader object we use to load in our image
		private var m_context:LoaderContext	= null;			// the loader context for our loader object
		
		/**************************************************************************************************/
		
		/**
		 * The text to display
		 */
		public function get text():String { return this.m_text.text; }
		public function set text( s:String ):void
		{
			this.m_text.text = s;
			this._redraw();
		}
		
		/**
		 * The TextFormat to use when rendering the text
		 */
		public function set textFormat( tf:TextFormat ):void
		{
			this.m_text.defaultTextFormat 	= tf;
			this.m_text.text				= this.m_text.text; // reset the text so the textformat takes effect
			this._redraw();
		}
		
		/**
		 * Is the font we're using embedded?
		 */
		public function set embedFonts( b:Boolean ):void
		{
			this.m_text.embedFonts = b;
			this._redraw();
		}
		
		/**
		 * If the TextField is a multiline TextField
		 */
		public function set multiline( b:Boolean ):void
		{
			this.m_text.multiline = b;
		}
		
		/**
		 * If the text is too long for the TextField, should it wrap?
		 */
		public function set wordWrap( b:Boolean ):void
		{
			this.m_text.wordWrap = b;
			this._redraw();
		}
		
		/**
		 * The width of the TextField in pixels
		 */
		override public function get width():Number { return this.m_text.width; }
		override public function set width( n:Number ):void
		{
			this.m_text.width = n;
			this._redraw();
		}
		
		/**
		 * The height of the TextField in pixels
		 */
		override public function get height():Number { return this.m_text.height; }
		override public function set height( n:Number ):void
		{
			this.m_text.height = n;
			this._redraw();
		}
		
		/**
		 * The texture that we want to use for this TextField. Can be either a BitmapData
		 * or a URL to load our texture from. NOTE: This won't call dispose() on any existing
		 * texture, so you'll need to clean it up yourself
		 */
		public function set texture( t:* ):void
		{			
			// if it's not a BitmapData or a String, don't do anything
			if ( t != null && !( t is BitmapData ) && !( t is String ) )
			{
				trace( "3:The texture object passed (" + t + ") isn't a BitmapData object or a URL" );
				return;
			}
			
			// if we already have a texture, kill it
			if ( this.m_texture != null )
				this.m_texture = null;
			
			// if it's null, do nothing
			if ( t == null )
				return;
			
			// if we already have a loader, stop it
			if ( this.m_loader != null )
				this._killLoader();
			
			// if it's a BitmapData object, just store it directly
			if ( t is BitmapData )
			{
				this.m_texture = t;
				this._redraw(); // redraw immediately (the loading will call redraw when it's done)
			}
			else
			{
				// create our loader and listeners
				this.m_loader = new Loader;
				this.m_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, this._onTextureLoad );
				this.m_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, this._onIOError );
				this.m_loader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, this._onSecurityError );
				
				// create our context if needed
				if ( this.m_context == null )
					this.m_context = new LoaderContext( true );
				
				// load the image
				try
				{
					this.m_loader.load( new URLRequest( t ), this.m_context );
				}
				catch ( e:SecurityError )
				{
					trace( "3:A Security error occured: " + e.errorID + ": " + e.message );
				}
			}
		}
		
		/**************************************************************************************************/
		
		/**
		 * Creates a new TexturedTextField
		 * @param texture The texture we want to use; either a BitmapData, or a url to load
		 */
		public function TexturedTextField( texture:* = null ) 
		{
			// create our textfield
			this.m_text				= new TextField;
			this.m_text.autoSize	= TextFieldAutoSize.LEFT;
			
			// set our texture
			this.texture = texture;
		}
		
		/**
		 * Destroys the TexturedTextField and clears it for garbage collection
		 * @param killTexture Should we call dispose() on the texture BitmapData object?
		 */
		public function destroy( killTexture:Boolean ):void
		{
			// kill the loader
			this._killLoader();
			
			// dispose of the BitmapDatas so we save memory immediately
			if ( killTexture )
				this.m_texture.dispose();
			this.m_textBMD.dispose();
			this.bitmapData.dispose();
			
			// null our objects
			this.m_text 		= null;
			this.m_texture		= null;
			this.m_textBMD		= null;
			this.m_drawPoint	= null;
			this.m_drawRect		= null;
			this.m_loader		= null;
		}
		
		/**************************************************************************************************/
		
		// redraws the text so any changes take place
		private function _redraw():void
		{
			// if we've no texture, just return
			if ( this.m_texture == null )
				return;
			
			// if our textfield is empty, just return
			if ( this.m_text.text == "" )
			{
				if ( this.bitmapData != null )
					this.bitmapData.fillRect( this.bitmapData.rect, 0x00000000 );
				return;
			}
			
			// get the width and height of our text
			var tw:int	= int( this.m_text.width + 0.5 ); // quick convert to int without clipping
			var th:int	= int( this.m_text.height + 0.5 );
			
			// reuse our previous BitmapData if we can, rather than always creating a new one
			if ( this.m_textBMD == null || this.m_textBMD.width < tw || this.m_textBMD.height < th )
			{
				// dispose immediately to save memory
				if ( this.m_textBMD != null )
					this.m_textBMD.dispose();
				this.m_textBMD = new BitmapData( tw, th, true, 0x00000000 );
			}
			else
				this.m_textBMD.fillRect( this.m_textBMD.rect, 0x00000000 ); // clear the bitmapdata of the old rendering
			
			// draw our text
			this.m_textBMD.draw( this.m_text, null, null, null, null, true );
			
			// set our draw rect position
			this.m_drawRect.x		= ( this.useRandomTexturePos ) ? Math.random() * ( this.m_texture.width - tw ) : 0.0;
			this.m_drawRect.y		= ( this.useRandomTexturePos ) ? Math.random() * ( this.m_texture.height - tw ) : 0.0;
			this.m_drawRect.width	= ( tw < this.m_texture.width ) ? tw : this.m_texture.width;
			this.m_drawRect.height	= ( th < this.m_texture.height ) ? th : this.m_texture.height;
			
			// make sure the draw rect x and y aren't minus
			if ( this.m_drawRect.x < 0.0 ) this.m_drawRect.x = 0.0;
			if ( this.m_drawRect.y < 0.0 ) this.m_drawRect.y = 0.0;
			
			// reset the draw point position
			this.m_drawPoint.x = 0.0;
			this.m_drawPoint.y = 0.0;
			
			// dispose of the previous bitmap if there is one to save memory
			if ( this.bitmapData != null )
				this.bitmapData.dispose();
			
			// create our bitmapdata and copy our pixels, using the text bmd as an alpha mask
			var doY:Boolean	= false; // do we need to move the y as well?
			this.bitmapData = new BitmapData( tw, th, true, 0xf7000000 );
			this.bitmapData.lock();
			while ( true )
			{
				// copy the pixels over
				this.bitmapData.copyPixels( this.m_texture, this.m_drawRect, this.m_drawPoint, this.m_textBMD, this.m_drawPoint );
				
				// if this needs to be done in multiple segments, it'll travel along the x,
				// then move down a bit and travel along the x again, until it's done
				
				// if our texture wasn't big enough, we need to do this in a few turns.
				// check do we need to do the y
				doY = ( this.m_drawPoint.y + this.m_drawRect.height < th );
				
				// do we need to do the x?
				if ( this.m_drawPoint.x + this.m_drawRect.width < tw )
					this.m_drawPoint.x += this.m_drawRect.width; // move along
				else if ( doY )
				{
					this.m_drawPoint.x = 0.0; // reset the x
					this.m_drawPoint.y += this.m_drawRect.height;
					doY = false;
				}
				else
					break; // it's fine, we've finished
			}
			
			this.bitmapData.unlock();
		}
		
		// called when our texture is loaded
		private function _onTextureLoad( e:Event ):void
		{
			// get the loader info and extract the bitmap from it
			var info:LoaderInfo = e.target as LoaderInfo;
			try
			{
				var bitmap:Bitmap = info.content as Bitmap; // accessing this will throw an error if we don't
				// have permission
			}
			catch ( err:SecurityError )
			{
				trace( "3:A Security error occured: " + err.errorID + ": " + err.message );
			}
			
			// if our bitmap is null, return
			if ( bitmap == null )
				return;
			
			// store our texture and clear the loader
			this.m_texture 		= bitmap.bitmapData;
			bitmap.bitmapData	= null;
			this._cleanUp( info );
			
			// redraw the text
			this._redraw();
		}
		
		// called when there's been an io error when loading our texture
		private function _onIOError( e:IOErrorEvent ):void
		{
			trace( "3:There was an io error: errorID: " + e.errorID + ", text: " + e.text );
			this._cleanUp( e.target as LoaderInfo );
		}
		
		// called when there's been a security error when loading our texture
		private function _onSecurityError( e:SecurityErrorEvent ):void
		{
			trace( "3:There was a security error: errorID: " + e.errorID + ", text: " + e.text );
			this._cleanUp( e.target as LoaderInfo );
		}
		
		// clean up the listeners for the texture loader
		private function _cleanUp( info:LoaderInfo ):void
		{
			info.addEventListener( Event.COMPLETE, this._onTextureLoad );
			info.addEventListener( IOErrorEvent.IO_ERROR, this._onIOError );
			info.addEventListener( SecurityErrorEvent.SECURITY_ERROR, this._onSecurityError );
			
			// clear our loader
			this.m_loader = null;
		}
		
		// kills the loader if there's a load in progress
		private function _killLoader():void
		{
			if ( this.m_loader == null )
				return;
			
			// close the loader and clean up
			this.m_loader.close();
			this._cleanUp( this.m_loader.contentLoaderInfo ); // removes the event listeners
		}
		
	}
	
}