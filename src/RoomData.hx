package ;

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
	
}