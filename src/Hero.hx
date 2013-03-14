package ;
import nme.geom.Point;
import nme.Lib;
/**
 * ...
 * @author VGC
 */

class Hero 
{
	private var TILE_WIDTH = 16;
	private var TILE_HEIGHT = 16;
	private var MAX_INVENTORY_SLOT = 5;
	
	public var HitPoints:Int=1;
	
	public var Name:String = "Derp";
	public var HeroismRank:Int = 0;
	
	//stats
	public var STR:Int = 10;
	
	//combat modifiers
	public var Accuracy:Int = 50;
	public var Dodge:Int = 10;
	public var DamageCapacity:Int = 1;
	public var Range:Int = 2;
	public var Reach:Int = 1;
	public var SightRange:Int = 3;
	
	
	public var _x:Float;
	public var _y:Float;
	public var face:TileSheetsGrid;
	public var inventory:Array<Item>;
	
	private var master:GameManager;
	
	public function new(x:Float, y:Float, gameMaster:GameManager) 
	{
		master = gameMaster;
		inventory = [];
		this._x = x;
		this._y = y;
		face = new TileSheetsGrid(65);
		face.x = _x * TILE_WIDTH;
		face.y = _y * TILE_HEIGHT;
	}
	
	public function draw():Void
	{
		face.x = (this._x) * TILE_WIDTH + master.camerax;
		face.y = (this._y) * TILE_HEIGHT + master.cameray;
		Lib.stage.addChild(face);
	}
	
	public function reDraw():Void
	{
		Lib.stage.removeChild(face);
		draw();
	}
	
	public function removeAll():Void
	{
		Lib.stage.removeChild(face);
		inventory = [];
	}
	
	public function move(deltax:Float, deltay:Float):Void
	{
		this._x += deltax;		
		this._y += deltay;
		
		face.x = (this._x) * TILE_WIDTH + master.camerax;
		face.y = (this._y) * TILE_HEIGHT + master.cameray;
	}
	
	public function addToInventory(mark:Int, nam:String):Bool
	{
		if (inventory.length < MAX_INVENTORY_SLOT)
		{
			inventory.push(new Item(mark, nam));
			return true;
		}
		
		return false;
	}
	
	public function traceInventory():Void
	{
		for (thing in inventory)
		{
			trace("Marker :" + thing.marker + " Name :" + thing.name);
		}
	}
	
	public function dropInventoryItem(drop:Int):Int
	{
		drop -= 1;
		if (inventory[drop]!=null)
		{
			var outBound = inventory[drop].marker;
			inventory.remove(inventory[drop]);
			return outBound;
		}
		return 0;
	}
	
	public function sayInventory(say:Int):Int
	{
		say -= 1;
		if (inventory[say] != null)
		{
			var outBound = inventory[say].marker;
			return outBound;
		}
		return 0;
	}
	
	public function setName(newName:String):Void
	{
		this.Name = newName;
	}
	
	public function setRange(newRange:Int):Void
	{
		this.Range = newRange;
	}
	
	public function checkIfDead():Bool
	{
		if (this.HitPoints <= 0)
		{
			return true;
		}
		return false;
	}
	
	public function changeFace(newMarker:Int):Void
	{
		face.changeTile(newMarker);
	}
	
	
	public function getSightRangePoints(center:Point, range:Int):Array<Point>
	{
		var pointList:Array<Point> = [];
		var pattern = range;
		for (y in 0...range+1)
		{
			
			for (x in (pattern*-1)...pattern+1)
			{
				pointList.push(new Point(center.x+x, center.y+y));
			}
			pattern--;
			
		}
		
		//top half
		
		var pattern = range -1;
		for (y in 1...range+1)
		{
			
			for (x in (pattern*-1)...pattern+1)
			{
				pointList.push(new Point(center.x+x,center.y+y*-1));
			}
			pattern--;
			
		}
		return pointList;
	}
	
	
	public function rollDice(dieSize:Int):Int
	{
		return Math.floor((Math.random() * (dieSize-1)) + 1);
	}
	
	public function offSetForCamera():Void
	{
		face.x = (this._x) * TILE_WIDTH + master.camerax;
		face.y = (this._y) * TILE_HEIGHT + master.cameray;
	}
}