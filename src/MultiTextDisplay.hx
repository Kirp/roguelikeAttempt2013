package ;


/**
 * ...
 * @author VGC
 */

class MultiTextDisplay 
{
	private var Lines:Array<String>;
	public var _x:Float;
	public var _y:Float;
	private var TX1:FeedBackDisplay;
	private var TX2:FeedBackDisplay;
	private var TX3:FeedBackDisplay;
	private var TX4:FeedBackDisplay;
	private var TX5:FeedBackDisplay;
	private var sameLineCount:Int = 1;
	private var lastSay:String;
	private var currentColor:UInt = 0xFFFFFF;
	
	public function new(x:Float, y:Float) 
	{
		_x = x;
		_y = y;
		Lines = [];
		
		TX1 = new FeedBackDisplay(_x, _y + 10);
		TX2 = new FeedBackDisplay(_x, _y + 20);
		TX3 = new FeedBackDisplay(_x, _y + 30);
		TX4 = new FeedBackDisplay(_x, _y + 40);
		TX5 = new FeedBackDisplay(_x, _y + 50);
 		
	}
	
	public function draw():Void
	{
		TX1.draw();
		TX2.draw();
		TX3.draw();
		TX4.draw();
		TX5.draw();
	}
	
	public function clearUp():Void
	{
		TX1.clearText();
		TX2.clearText();
		TX3.clearText();
		TX4.clearText();
		TX5.clearText();
	}
	
	public function updateContent():Void
	{

		if (Lines[Lines.length-1] != null)
		{
			TX1.sayThis(Lines[Lines.length-1]);
		}
		
		if (Lines[Lines.length-2] != null)
		{
			TX2.sayThis(Lines[Lines.length-2]);
		}
		
		if (Lines[Lines.length-3] != null)
		{
			TX3.sayThis(Lines[Lines.length-3]);
		}
		
		if (Lines[Lines.length-4] != null)
		{
			TX4.sayThis(Lines[Lines.length-4]);
		}
		
		if (Lines[Lines.length-5] != null)
		{
			TX5.sayThis(Lines[Lines.length-5]);
		}
		
	}
	
	public function sayThis(say:String):Void
	{
		
		if (Lines.length <= 0)
		{
			Lines.push(say);
			lastSay = say;
		} else
			{
				if (say == lastSay)
				{
					Lines.pop();
					sameLineCount++;
					Lines.push(say + "(x" +sameLineCount + ")");
					
				}else 
					{
						Lines.push(say);
						lastSay = say;
						sameLineCount = 1;
					}
			}
		
		updateContent();
	}
	
	
	
}