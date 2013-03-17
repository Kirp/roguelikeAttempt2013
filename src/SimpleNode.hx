package ;

/**
 * ...
 * @author VGC
 */

class SimpleNode 
{
	public var _x:Float;
	public var _y:Float;
	public var Score:Int;
	public var deltax:Float;
	public var deltay:Float;
	
	public function new(x:Float, y:Float, dx:Float, dy:Float, seeker:Hero, target:Hero) 
	{
		_x = x;
		_y = y;
		deltax = dx;
		deltay = dy;
		
		var diffx:Float = target._x - x;
		var diffy:Float = target._y - y;
		Score = Std.int(diffx < 0?diffx * -1:diffx) + Std.int(diffy < 0?diffy * -1:diffy);
	}
	
}