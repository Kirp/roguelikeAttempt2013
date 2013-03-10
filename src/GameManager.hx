package ;
import nme.display.Sprite;
import nme.events.KeyboardEvent;
import nme.geom.Point;
import nme.Lib;

/**
 * ...
 * @author VGC
 */



class GameManager extends Sprite
{	
	inline private static var numlKEY_UP = 104;
	inline private static var numlKEY_UPLEFT = 103;
	inline private static var numlKEY_UPRIGHT = 105;
	inline private static var numlKEY_DOWN = 98;
	inline private static var numlKEY_DOWNLEFT = 97;
	inline private static var numlKEY_DOWNRIGHT = 99;
	inline private static var numlKEY_LEFT = 100;
	inline private static var numlKEY_RIGHT = 102;
	inline private static var numlKEY_MIDDLE = 101;
	inline private static var KEY_G = 71;
	inline private static var KEY_O = 79;
	inline private static var KEY_D = 68;
	inline private static var Key_C = 67;
	inline private static var Key_U = 85;
	
	
	
	public var arrdungeonStages:Array<DungeonMaker>;
	

	public function new() 
	{
		super();
		
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	private function onKeyDown(e:KeyboardEvent):Void 
	{
		var keyPressed = e.keyCode;
		var delta = new Point();
		
		switch (keyPressed)
		{
			case numlKEY_UP:
				delta.x = 0;
				delta.y = -1;
			
			case numlKEY_UPLEFT:
				delta.x = -1;
				delta.y = -1;
				
			case numlKEY_UPRIGHT:
				delta.x = 1;
				delta.y = -1;
				
			case numlKEY_DOWN:
				delta.x = 0;
				delta.y = 1;
				
			case numlKEY_DOWNLEFT:
				delta.x = -1;
				delta.y = 1;
				
			case numlKEY_DOWNRIGHT:
				delta.x = 1;
				delta.y = 1;
				
			case numlKEY_LEFT:
				delta.x = -1;
				delta.y = 0;
				
			case numlKEY_RIGHT:
				delta.x = 1;
				delta.y = 0;
				
			default:
		}
		
		trace(delta);
	}
	
	private function canMoveTo(x:Float, y:Float, checkOnMap:Array<MapTileDisplayTiles>):Bool
	{
		var passable:Bool = false;
		for (tile in checkOnMap)
		{
			if (tile._x == x && tile._y == y)
			{
				passable = tile.isPassable;
			}
		}
		
		return passable;
	}
}