package
{
    
    import com.wowzers.input.SmartHelper;
    import com.wowzers.utils.Operate;
    import com.wowzers.utils.wowzExpressions;
    import com.wowzers.utils.wowzScriptUtils;
    import com.wowzers.utils.wowzTweenMax;
    import com.wowzers.utils.checking.Check;
    import com.wowzers.utils.fractions.Fraction;
    
    import flash.display.Sprite;
    
    import Testing.TestFunc;
    
    public class _test extends Sprite
    {
        public function _test()
        {      
            //TESTround();
            //TESTfracToString();
            //TESTgetSlope();
            //TESTfracMath();
            /*TESTcompareExpressions();*/
			//TestEvaluations();
			/*TESTround();*/
			
			//TESTSolve();
            //wowzExpressions.factorExpression("(4x + 20)");
            //Test();
            var tm:TestFunc = new TestFunc(Test);
            tm.loop(1000);
        }
        
        public function Test():void{
            var array:Array = [];
            var i:int;
            var n:int;
            for ( ; i < 10; i++ ) {
                array[i] = 0; 
            }
            for ( i=0; i < array.length; i++ ) {
                array[ Math.floor( Math.random() * array.length ) ] += 1;
            }
            for ( i = 0; i < array.length; i++ ){
                n += array[i];
            }
            trace(n);
        }
        
        public function TESTSPEEDmap():void{
            var expectedVars:Array = new Array("3","3","ba","18");
            var expressionVars:Array = new Array("3","3","ab","18");
            var sortString:Function = function(element:String, index:int, array:Array):String { return element.search(/[a-zA-Z][a-zA-Z]+/) != -1? element.split("").sort().join("") : element; }
            expectedVars = expectedVars.map(sortString);
            expressionVars = expressionVars.map(sortString);
            trace(expectedVars.toString());
            trace(expressionVars.toString());
        }
        
        public function TESTSPEEDloop():void{
            var expectedVars:Array = new Array("3","3","ba","18");
            var expressionVars:Array = new Array("3","3","ab","18");
            var i:int = 0;
            for(; i < expectedVars.length; i++){
                if(expectedVars[i].search(/[a-zA-Z][a-zA-Z]+/) != -1)
                    expectedVars[i] = expectedVars[i].split("").sort().join("");
            }
            i = 0;
            for(; i < expressionVars.length; i++){
                if(expressionVars[i].search(/[a-zA-Z][a-zA-Z]+/) != -1)
                    expressionVars[i] = expressionVars[i].split("").sort().join("");
            }
            trace(expectedVars.toString());
            trace(expressionVars.toString());
        }
        
        public function TESTcompareExpressions():void{
            var tf:TestFunc = new TestFunc(wowzExpressions.compareExpressions);
            
            tf.unitTest(false, "4{1}{2}+-3 {2}{3}=-{2}{3}", "4.5+-3.6666=-0.6666666", true, true);
            tf.unitTest(false, "1*-1 {10}{37}x=5*5.5y", "1 * -1.270x=5*5.5y", true, true);
            tf.unitTest(true, "-{3}{2}x + 2", "-1.5x + 2", true, true);
            tf.unitTest(true, "-{3}{4}x + 1{1}{2}", "-0.75x + 1.5", true, true);
            tf.unitTest(true, "2x+2","2+x2");
            tf.unitTest(true, "9x-2+4=4","4+9x-2=4");
            tf.unitTest(true, "9x-2+4=4","4=4+9x-2");
            tf.unitTest(true, "7.7*2.3","2.3*7.7");
            tf.unitTest(true, "7r + 4y - 1","4y + 7r - 1");
            tf.unitTest(true, "7r + 4y - 1","4y + 7r - 1");
            tf.unitTest(true, "1*7r + 1*4y - 1","1*4y + 1*7r - 1");
            tf.unitTest(true, "10/20a + 7","7 + a10/20");
            tf.unitTest(true, "3^3 * ab - 18","ba * 3^3 - 18");
            tf.unitTest(true, "ab + ac + ad","ba + ca + da");
            tf.unitTest(true, "2ab * 9cy","9cy * ab2");
            tf.unitTest(true, "2ab > 17cy","17cy < ab2");
            tf.unitTest(true, "1/a > 2/b","2/b < 1/a");
            tf.unitTest(true, "3+y-7h", "-7h + 3+y");
            tf.unitTest(true, "10--m", "m--10");
            tf.unitTest(true, "s-11", "-11+s");
            tf.unitTest(true, "ab","ba");
            tf.unitTest(true, "3(3x - 5)", "9x - 15");
            tf.unitTest(true, "3(3x - 5) = 4x + 20", "4x + 20 = 3(3x - 5)");
            tf.unitTest(false, "3(3x - 5) = 4x + 20", "(6x + 20) = 3(3x - 5)");
            tf.unitTest(true, "98-x+2x", "1(98-x)+1(2x)");
            tf.unitTest(true, "98-x+2x", "(98-x)+(2x)");
            tf.unitTest(false, "3(3x-5)+(4x+20)", "3(3x-5)=(4x+20)");
            tf.unitTest(true, "3(3x-5)=(4x+20)", "3(3x-5)=(4x+20)");
            tf.unitTest(true, "3(3x-5)+(4x+20)", "3(3x-5)+(4x+20)");
        }
		
		public function TestEvaluations():void {
			var tf:TestFunc = new TestFunc( wowzScriptUtils.ifLogic );
			tf.unitTest( true, " 12 == 12 && -1 != 3 " );
			tf.unitTest( true, " 1 == 1 && 0 != 3 " );
			tf.unitTest( true, "167 == 167 && 0 != 75" );
			tf.unitTest( true, "167 == 167 && 0 == 0" );
			tf.unitTest( false, "167 == 167 && 2 == 0" );
			tf.unitTest( true, "'cat' == 'dog' || 'cat' == 'cat'" );
			tf.unitTest( false, "'cat' == 'dog' && 'cat' == 'cat'" );
			tf.unitTest( true, "'cat' == 'dog' && 'cat' == 'cat' || 'dog' == 'dog'" );
			tf.unitTest( true, "'a' == 'a' || 'Hello' == 'Hello' || ('hello' != 'Hello')" );
		}
        
        public function TESTfracMath():void{
            var tf:TestFunc = new TestFunc(Operate.operateFraction);
            
            //Adding
            tf.unitTest("-{1}{3}","1/3","+","- 2/3");
            tf.unitTest("{3}{5}","2/5","+","1/5");
            tf.unitTest("-{3}{4}","-{1}{4}","+","-{2}{4}");
            
            //Subtracting
            tf.unitTest("-{1}{3}","1/3","-","2/3");
            tf.unitTest("{6}{7}","1/7","-","- 5/7");
            tf.unitTest("{1}{4}","-{1}{4}","-","-{2}{4}");
            tf.unitTest("{7}{3}","1 5/3","-","1/3");
            
            //Multiplying
            tf.unitTest("-{2}{9}","1/3","*","- 2/3");
            tf.unitTest("{2}{9}","1/3","*","2/3");
            tf.unitTest("{2}{9}","- 1/3","*","- 2/3");
            
            //Dividing
            tf.unitTest("-{12}{5}","3/5","/","- 1/4");
            tf.unitTest("{12}{5}","3/5","/","1/4");
            tf.unitTest("{12}{5}","- 3/5","/","- 1/4");
        }
        
        public function TESTfracToString():void{
            var func:Function = new Fraction("5 0/1").toString;
            var tf:TestFunc = new TestFunc(func);
            tf.unitTest("5", "latex");
            tf.unitTest("5", "wowzers");
            tf.unitTest("5", "normal");
            
            func = new Fraction("2/0").toString;
            tf = new TestFunc(func);
            tf.unitTest("0", "latex");
            tf.unitTest("0", "wowzers");
            tf.unitTest("0", "normal");
            
            func = new Fraction("6{2}{3}").toString;
            tf = new TestFunc(func);
            tf.unitTest("6\\frac{2}{3}", "latex");
            tf.unitTest("6{2}{3}", "wowzers");
            tf.unitTest("6 2/3", "normal");
            
            func = new Fraction("0/1").toString;
            tf = new TestFunc(func);
            tf.unitTest("0", "latex");
            tf.unitTest("0", "wowzers");
            tf.unitTest("0", "normal");
            
            func = new Fraction("-\\frac{2}{1}").toString;
            tf = new TestFunc(func);
            tf.unitTest("-\\frac{2}{1}", "latex");
            tf.unitTest("-{2}{1}", "wowzers");
            tf.unitTest("- 2/1", "normal");
            
            func = new Fraction("1").toString;
            tf = new TestFunc(func);
            tf.unitTest("1", "latex");
            tf.unitTest("1", "wowzers");
            tf.unitTest("1", "normal");
            
            func = new Fraction("2/2").toString;
            tf = new TestFunc(func);
            tf.unitTest("\\frac{2}{2}", "latex");
            tf.unitTest("{2}{2}", "wowzers");
            tf.unitTest("2/2", "normal");
            
            func = new Fraction("2_1/2").toString;
            tf = new TestFunc(func);
            tf.unitTest("2\\frac{1}{2}", "latex");
            tf.unitTest("2{1}{2}", "wowzers");
            tf.unitTest("2 1/2", "normal");
            
            func = new Fraction("-6{2}{3}").toImproperString;
            tf = new TestFunc(func);
            tf.unitTest("-\\frac{20}{3}", "latex");
            tf.unitTest("-{20}{3}", "wowzers");
            tf.unitTest("- 20/3", "normal");
        }
        
		public function TESTround():void{
			var tf:TestFunc = new TestFunc(round);
			tf.unitTest(4.33, 4.325, 2);
			tf.unitTest(4.3, 4.325, 1);
			tf.unitTest(4.33, 4.325, 2);
			tf.unitTest(5, 4.9, 0);
			tf.unitTest(5, 4.99999, 0);
			tf.unitTest(1.28, 1.275, 2);
			tf.unitTest(2.28, 2.275, 2);
			tf.unitTest(2.3490250924, 2.349025092443, 10);
			tf.unitTest(2.3490250925, 2.349025092483, 10);
			tf.unitTest(.1, .1, 2);
			tf.unitTest(.05, .05, 2);
			tf.unitTest(.01, .005, 2);
			tf.unitTest(0.6, 0.55, 1);
			tf.unitTest(0.56, 0.555, 2);
		}
		
		public function TESTSolve():void {
			//var tf:TestFunc = new TestFunc( wowzExpressions.solveEquation );
			var tf:TestFunc = new TestFunc( SmartHelper.smartStringToNumber );
			tf.unitTest( null, "{1}{}" );
			/*tf.unitTest( 4, "2*2" );
			tf.unitTest( 4, "1+1+1+1" );
			tf.unitTest( 0, "4-3-1" );
			tf.unitTest( 5, "10/2" );
			tf.unitTest( 3125, "5^5" );
			tf.unitTest( 5, "10-5" );
			tf.unitTest( 15, "10+5" );
			tf.unitTest( 24, "1*2*3*4" );
			tf.unitTest( 5, "20/2/2" );
			tf.unitTest( 3, "(1+10/2) - 3" );
			tf.unitTest( -10, "( (1+7)/2 + 5 ) - ( 19 )" );
			tf.unitTest( 14, "2*(3+4)" );
			tf.unitTest( 7, "2*(3+4) - 7" );
			tf.unitTest( 25, "(2+3)^2" );
			tf.unitTest( 36, "( 2*(2+(8*2) ) )" );*/
			tf.unitTest( 36, "1/" );
		}
        
        public function round( number:Number, precision:int ):Number {
			var numberString:String = String( number );
			if ( numberString.indexOf( "." ) != -1 ) {
				var decimalIndex:int = numberString.indexOf( "." ) + precision;
				numberString = numberString.replace( ".", "" );
				
				var i:int;
				var end:int = decimalIndex > numberString.length ? decimalIndex : numberString.length-1;				
				var multiplyNumber:String = "", divideNumber:String = "";
				var multiply:Boolean = true;
				while( i <= end ) {
					if ( multiply ) {
						if ( i == decimalIndex ) { multiplyNumber += "."; }
						multiplyNumber += i < numberString.length ? numberString.charAt( i ) : "0";
					} 
					else {
						if ( i == decimalIndex ) { divideNumber += "."; }
						divideNumber += i < numberString.length ? numberString.charAt( i ) : "0";
					}
					++i;
					if ( i > end && multiply ) { 
						multiply = false; 
						i = 0;
						//remove leading zeros and trailing zeros for an accurate number representation
						multiplyNumber = multiplyNumber.replace( /^0+/g, "" );
						multiplyNumber = multiplyNumber.replace( /(.0+)$/g, "" );
						
						//get our new rounded value
						numberString = String( Math.round( Number( multiplyNumber ) ) );
						var idx:int = multiplyNumber.indexOf( "." );
						//if we are shifting the decimal outside of our whole number, add 1 to compensate for rounding
						//i.e - the number 0.05, rounded to 0.1 with a precision of 2, instead of dividing the rounded value by the precision(10^n) resulting in 0.01
						//we would only need to divide by (10^(n-1))
						decimalIndex = idx != -1 ? idx + ( idx - precision < 0 ? 1 : 0 ) - precision : multiplyNumber.length - precision;
						end = numberString.length - 1;
						
						//insert any leading zeros
						if ( decimalIndex <= 0 ) {
							var k:int = decimalIndex + 1;
							divideNumber += ".";
							while( k <= 0 ) {
								divideNumber += "0";
								++k;
							}
							decimalIndex = int.MAX_VALUE;
						}
					} else if ( i > end ) {
						break;
					}
				}
				number = Number( divideNumber );
			}
			return number;
        }
		private function roundObject( number:Number, precision:int ):Number {
			var numberString:String = String( number );
			if ( numberString.indexOf( "." ) != -1 ) {
				var decimalIndex:int = numberString.indexOf( "." ) + precision;
				numberString = numberString.replace( ".", "" );
				
				var i:int;
				var end:int = decimalIndex > numberString.length ? decimalIndex : numberString.length-1;				
				//var multiplyNumber:String = "", divideNumber:String = "";
				var currentValue:Object = { current:multiply, multiply:"", divide:"" };
				var multiply:Boolean = true;
				while( i <= end ) {
					if ( multiply ) {
						if ( i == decimalIndex ) { currentValue.value += "."; }
						currentValue.value += i < numberString.length ? numberString.charAt( i ) : "0";
					} 
					++i;
					if ( i > end && currentValue.value== currentValue.multiply ) { 
						currentValue.value = currentValue.divide;
						i = 0;
						var m:String = currentValue.multiply;
						//remove leading zeros and trailing zeros for an accurate number representation
						m = m.replace( /^0+/g, "" );
						m = m.replace( /(.0+)$/g, "" );
						
						//get our new rounded value
						numberString = String( Math.round( Number( m ) ) );
						var idx:int = m.indexOf( "." );
						//if we are shifting the decimal outside of our whole number, add 1 to compensate for rounding
						//i.e - the number 0.05, rounded to 0.1 with a precision of 2, instead of dividing the rounded value by the precision(10^n) resulting in 0.01
						//we would only need to divide by (10^(n-1))
						decimalIndex = idx != -1 ? idx + ( idx - precision < 0 ? 1 : 0 ) - precision : m.length - precision;
						end = numberString.length - 1;
						
						//insert any leading zeros
						var d:String = currentValue.divide;
						if ( decimalIndex <= 0 ) {
							var k:int = decimalIndex + 1;
							d += ".";
							while( k <= 0 ) {
								d += "0";
								++k;
							}
							decimalIndex = int.MAX_VALUE;
						}
						currentValue.divide = d;
					} else if ( i > end ) {
						break;
					}
				}
				number = Number( currentValue.value );
			}
			return number;
		}
    }
}