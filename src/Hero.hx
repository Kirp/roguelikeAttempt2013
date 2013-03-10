package ;
import browser.display.InterpolationMethod;
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
	
	public var _x:Float;
	public var _y:Float;
	private var face:TileSheetsGrid;
	public var inventory:Array<Item>;

	public function new(x:Float, y:Float) 
	{
		inventory = [];
		this._x = x;
		this._y = y;
		face = new TileSheetsGrid(65);
	}
	
	public function draw():Void
	{
		face.x = this._x * TILE_WIDTH;
		face.y = this._y* TILE_HEIGHT;
		Lib.stage.addChild(face);
	}
	
	public function reDraw():Void
	{
		Lib.stage.removeChild(face);
		draw();
	}
	
	public function move(deltax:Float, deltay:Float):Void
	{
		this._x += deltax;		
		this._y += deltay;
		
		face.x = this._x * TILE_WIDTH;
		face.y = this._y* TILE_HEIGHT;
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
	
}