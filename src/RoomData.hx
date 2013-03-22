package ;
import nme.geom.Point;

/**
 * ...
 * @author VGC
 */

class RoomData 
{
	public var locX:Int;
	public var locY:Int;
	public var height:Int;
	public var width:Int;
	public var centerX:Int;
	public var centerY:Int;
	
	public function new(_x:Int, _y:Int, wid:Int, hei:Int) 
	{
		this.locX = _x;
		this.locY = _y;
		this.height = hei;
		this.width = wid;
		
		centerX = Math.floor(locX + width / 2);
		centerY = Math.floor(locY + height / 2);
	}
	
	public function getOpenSpace():Array<Point>
	{
		var roomSpace:Array<Point> = [];
		var minx = locX + 1;
		var miny = locY +1;
		var maxx = (locX + width) - 1;
		var maxy = (locY + height) -1;
		for (y in miny...maxy)
		{
			for (x in minx...maxx)
			{
				roomSpace.push(new Point(x, y));
			}
		}
		return roomSpace;
	}
	
}