package ;
import nme.display.Sprite;

/**
 * ...
 * @author VGC
 */

class CoverBMP extends Sprite
{
	private var myWidth:Float = 5;
	private var myHeight:Float = 5;
	private var myColor:UInt;
	private var myAlpha:Float;
	
	public function new(_x:Float, _y:Float, _Width:Float, _Height:Float, _Alpha:Float = 1, _Color:UInt = 0xFF0000) 
	{
		super();
		this.x = _x;
		this.y = _y;
		myWidth = _Width;
		myHeight = _Height;
		myColor = _Color;
		myAlpha = _Alpha;
		graphics.beginFill(myColor, myAlpha); 
		graphics.drawRect(this.x, this.y, myWidth, myHeight);
	}
	
	public function setAlpha(newAlpha:Float):Void
	{
		myAlpha = newAlpha;
		reDraw();
	}
	
	public function setColor(newColor:UInt):Void
	{
		myColor = newColor;
		reDraw();
	}
	
	public function reDraw():Void
	{
		graphics.clear();
		graphics.beginFill(myColor, myAlpha); 
		graphics.drawRect(this.x, this.y, myWidth, myHeight);
	}
	
}