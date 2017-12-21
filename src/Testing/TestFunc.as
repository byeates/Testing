package Testing
{
    import flash.sampler.getSavedThis;
    import flash.utils.describeType;
    import flash.utils.getTimer;
    
    public class TestFunc
    {
        public var Func:Function;
        public var name:String;
        public const buffer:String = "\t-\t";
        
        //Constructor for function, expects to be passed the function to be tested
        public function TestFunc(func:Function)
        {
            Func = func;
            name = getFunctionName(func);
        }
        
        //Loops the function [count] times, [args] is the arguments the function expects
        public function loop(count:int, ... args):void{
            var t:Number = getTimer();
            for(var i:int = 1; i <= count; i++){
               // trace("LOOP " + (i>9?i:" "+i) + buffer + run(args));
            }
            var time:Number = getTimer() - t;
            trace("-=- Looping complete in " + time + " millisecond" + (time > 1? "s" : "") + " -=-");
        }
        
        //Compares results of function with [args] against [expected]
        public function unitTest(expected:*, ... args):Boolean{
            var res:Boolean;
            var something:* = run(args);
            res = expected == something;
            trace((res? "PASSED":"FAILED") + buffer + expected + " == " + name + "(" + args.join(", ") + ") ~ returned: "+String(something));
            return res;
        }
        
        // -----------------
        // Utility Functions
        // -----------------
        
        //Runs function, can accept 10 parameters max
        private function run(args:Array):*{
            if(args.length > 10) throw new Error("Too many parameters!");
            var res:*;
            switch(args.length){
                case  0: res = Func(); break;
                case  1: res = Func(args[0]); break;
                case  2: res = Func(args[0], args[1]); break;
                case  3: res = Func(args[0], args[1], args[2]); break;
                case  4: res = Func(args[0], args[1], args[2], args[3]); break;
                case  5: res = Func(args[0], args[1], args[2], args[3], args[4]); break;
                case  6: res = Func(args[0], args[1], args[2], args[3], args[4], args[5]); break;
                case  7: res = Func(args[0], args[1], args[2], args[3], args[4], args[5], args[6]); break;
                case  8: res = Func(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]); break;
                case  9: res = Func(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]); break;
                case 10: res = Func(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]); break;
            }
            return res;
        }
        
        //Gets name of function being tested
        private function getFunctionName(f:Function):String {
            var t:Object = getSavedThis(f); 
            var methods:XMLList = describeType(t)..method.@name;
            for each (var m:String in methods)
            {
                if (t.hasOwnProperty(m) && t[m] != null && t[m] === f) return m;            
            }
            return null;  
        }
    }
}