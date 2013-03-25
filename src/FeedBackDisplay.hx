package ;
import nme.display.Sprite;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;
import nme.text.TextFormat;
import nme.Lib;
/**
 * ...
 * @author VGC
 */

class FeedBackDisplay extends Sprite
{
	public var regFormat:TextFormat;
	public var mainChatter:TextField;
	private var isDrawn:Bool = false;
	
	public function new(x:Float, y:Float) 
	{
		super();
		this.x = x;
		this.y = y;

		regFormat = new TextFormat();
		regFormat.font = "Times";
		regFormat.size = 12;
		regFormat.color = 0xFFFFFFFF;
		
		
		mainChatter = new TextField();
		mainChatter.backgroundColor = 0x0000FF;
		mainChatter.background = false;
		mainChatter.autoSize = LEFT;
		mainChatter.selectable = false;
		mainChatter.maxChars = 20;
		mainChatter.defaultTextFormat = regFormat;
		mainChatter.x = this.x;
		mainChatter.y = this.y;
		mainChatter.text = "";
		
	}
	
	public function changeSize(newSize:Int):Void
	{
		regFormat.size = newSize;
		mainChatter.defaultTextFormat = regFormat;
	}
	
	public function draw():Void
	{
		if (isDrawn == false)
		{
			Lib.stage.addChild(mainChatter);
			isDrawn = true;
		} else 
			{
				Lib.stage.removeChild(mainChatter);
				Lib.stage.addChild(mainChatter);
			}
	}
	
	public function sayThis(say:String, colorCode:UInt = 0xFFFFFF):Void
	{
		regFormat.color = colorCode;
		mainChatter.text = say;
		regFormat.color = 0xFFFFFF;
	}
	
	public function clearText():Void
	{
		mainChatter.text = "";
	}
	
}