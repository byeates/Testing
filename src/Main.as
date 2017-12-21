package
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    [SWF(width="1600", height="1000")]
    public class Main extends Sprite
    {
        [Embed("../../../ASSETS/Test/car-02.jpg")]
        private static const BLACK_CAR:Class;
        private var _blackCar:Bitmap;

        [Embed("../../../ASSETS/Test/banner.jpg")]
        private static const ALYSSA:Class;
        private var _alyssa:Bitmap;

        [Embed("../../../ASSETS/Test/car-6.jpg")]
        private static const RED_CAR:Class;
        private var _redCar:Bitmap;

        private var _asciiField:TextField;

        private const PADDING:int = 5;

        private const LIGHT_ASCII:String = "1";
        private const MEDIUM_ASCII:String = "5";
        private const DARK_ASCII:String = "8";

        private var format:TextFormat;

        public function Main()
        {
            trace( getFactorial( 5 ) == 120 ) ;
        }

        public function getFactorial( n )
        {
            return factorial( n );
        }

        public function factorial( n ):int
        {
            if ( n - 1 > 0 )
            {
                n *= factorial( n - 1 );
            }
            return n;
        }

        /** generate ascii art for a particular asset */
        private function generateAscii( asset:BitmapData ):void
        {
            if ( asset.height % 2 != 0 )
            {
                return;
            }

            for ( var column:int; column < asset.height; column += 2 )
            {
                var str:String = "";
                var tx:TextField = new TextField();
                tx.defaultTextFormat = format;
                tx.autoSize = TextFieldAutoSize.LEFT;

                for ( var row:int = 0; row < asset.width; row++ )
                {
                    var average:uint = ( asset.getPixel( row, column ) + asset.getPixel( row, column + 1 ) ) / 2;
                    if ( average < 0x666666 )
                    {
                        if ( average < 0x222222 )
                        {
                            str += DARK_ASCII;
                            //_asciiField.appendText( DARK_ASCII );
                        }
                        else
                        {
                            str += "5";
                            //_asciiField.appendText( "5" );
                        }
                    }
                    else if ( average < 0xAAAAAA )
                    {
                        if ( average < 0x777777 )
                        {
                            str += "0";
                            //_asciiField.appendText( "0" );
                        }
                        else
                        {
                            str += "3";
                            //_asciiField.appendText( "3" );
                        }
                    }
                    else
                    {
                        if ( average < 0xDDDDDD )
                        {
                            str += "7";
                        }
                        else if ( average < 0xEEEEEE )
                        {
                            str += "~";
                        }
                        else
                        {
                            str += LIGHT_ASCII;
                        }
                    }
                }
                tx.text = str;
                tx.y = column * 2;
                addChild( tx );
            }
        }

        private function randomizeSwap( e:MouseEvent ):void
        {
            var size:Number = Math.floor( (Math.random() * 90) + 10 );
            var quantity:int = (Math.random() * 40) + 4;
            swapMatrices( _blackCar, _redCar, size, size, quantity );
        }

        /** swaps sections of pixels between two bitmaps
         * @param a - first bitmap
         * @param b - second bitmap
         * @param subw - width of sub matrix sections
         * @param subh - height of sub matrix sections
         * @param subMatrices - number of matrices to draw
         * */
        private function swapMatrices( a:Bitmap, b:Bitmap, subw:Number, subh:Number, subMatrices:int ):void
        {
            var newA:BitmapData = new BitmapData( a.width, a.height, true, 0 );
            newA.draw( a );

            var newB:BitmapData = new BitmapData( b.width, b.height, true, 0 );
            newB.draw( b );

            var currentMatrix:int = 0;
            while ( currentMatrix < subMatrices )
            {
                var start:Point = new Point( Math.floor( Math.random() * (a.width - subw) ), Math.floor( Math.random() * ( a.height - subh ) ) );
                var end:Point = new Point( start.x + subw, start.y + subh );

                for ( var i:int = start.y; i < end.y; ++i )
                {
                    for ( var j:int = start.x; j < end.x; ++j )
                    {
                        var pixelA:uint = a.bitmapData.getPixel32( j, i );
                        var pixelB:uint = b.bitmapData.getPixel32( j, i );

                        newA.setPixel32( j, i, pixelB );
                        newB.setPixel32( j, i, pixelA );
                    }
                }
                ++currentMatrix;
            }

            var finalA:Bitmap = new Bitmap( newA );
            var finalB:Bitmap = new Bitmap( newB );

            addChild( finalA );

            finalB.x = finalA.width + PADDING;
            addChild( finalB );
        }
    }
}
