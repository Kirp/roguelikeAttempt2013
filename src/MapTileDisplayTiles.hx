package ;
import nme.display.Sprite;
import nme.geom.Point;
import nme.Lib;
/**
 * ...
 * @author VGC
 */

class MapTileDisplayTiles
{
	//tile constants
	inline public static var TILE_GROUND = 1;
	inline public static var TILE_WALL = 2;
	inline public static var TILE_GRASS = 3;
	inline public static var TILE_TREE = 4;
	inline public static var TILE_OPENDOOR = 5;
	inline public static var TILE_CLOSEDDOOR = 6;
	inline public static var ITEM_STAIRSDOWN = 7;
	inline public static var ITEM_STAIRSUP = 8;
	
	//class variables
	public var marker:Int;
	public var face:TileSheetsGrid;
	public var _x:Float;
	public var _y:Float;
	public var isPassable:Bool = false;
	public var isVisible:Bool = false;
	public var isDiscovered:Bool = false;
	public var isDrawn:Bool = false;
	public var cameraOffsetx:Int = 0;
	public var cameraOffsety:Int = 0;
	
	public function new(_x:Float, _y:Float, marker:Int) 
	{
		this._x = _x + cameraOffsetx;
		this._y = _y + cameraOffsety;
		
		this.marker = marker;
		init();
		face.visible = isDiscovered;
	}
	
	public function init() 
	{
		switch (marker)
		{
			case TILE_GROUND: //(1) ground
				face = new TileSheetsGrid(47);
				isPassable = true;
					
			case TILE_WALL: //(2) wall
				face = new TileSheetsGrid(36);
			
			case TILE_GRASS: //(3) grass
				face = new TileSheetsGrid(35);
				isPassable = true;
				
			case TILE_TREE: //(4) tree
				face = new TileSheetsGrid(245);
			
			case TILE_OPENDOOR: //(5) open door
				face = new TileSheetsGrid(48);
				isPassable = true;
				
			case TILE_CLOSEDDOOR: //(6) closed door
				face = new TileSheetsGrid(44);
				
			case ITEM_STAIRSDOWN: //(7) Stairs down
				face = new TileSheetsGrid(63);
				isPassable = true;
				
			case ITEM_STAIRSUP: //(8) Stairs up
				face = new TileSheetsGrid(61);
				isPassable = true;
				
			default:
				face = new TileSheetsGrid(2);
		}
	}
	
	public function draw(camerax:Int, cameray:Int):Void
	{
		cameraOffsetx = camerax;
		cameraOffsety = cameray;
		if (isDrawn == false)
		{
			
			face.visible = isDiscovered;
			face.x = (this._x) * TileSheetsGrid.TILE_WIDTH +cameraOffsetx;
			face.y = (this._y) * TileSheetsGrid.TILE_HEIGHT + cameraOffsety;
			face.changeCoverAlpha(0.6);
			Lib.stage.addChild(face);
			isDrawn = true;
		} else 
			{
				face.x = (this._x) * TileSheetsGrid.TILE_WIDTH +cameraOffsetx;
				face.y = (this._y) * TileSheetsGrid.TILE_HEIGHT + cameraOffsety;
			}
	}
	
	public function reveal():Void
	{
		isDiscovered = true;
		face.visible = isDiscovered;
		isVisible = true;
		face.changeCoverAlpha(0);
	}
	
	public function outOfSight():Void
	{
		isVisible = false;
		face.changeCoverAlpha(0.6);
	}
	
	public function changeTile(newMarker:Int):Void
	{
		this.marker = newMarker;
		switch (marker)
		{
			case TILE_GROUND: //(1) ground
				face.changeTile(47);
				isPassable = true;
					
			case TILE_WALL: //(2) wall
				face.changeTile(36);
			
			case TILE_GRASS: //(3) grass
				face.changeTile(35);
				isPassable = true;
				
			case TILE_TREE: //(4) tree
				face.changeTile(245);
			
			case TILE_OPENDOOR: //(5) open door
				face.changeTile(48);
				isPassable = true;
				
			case TILE_CLOSEDDOOR: //(6) closed door
				face.changeTile(44);
				
			case ITEM_STAIRSDOWN: //(7) Stairs down
				face.changeTile(63);
				
				
			case ITEM_STAIRSUP: //(8) Stairs up
				face.changeTile(61);
				
				
			default:
				face.changeTile(2);
		}
		
	}
	
	public function clear():Void
	{
		Lib.stage.removeChild(face);
	}
	
}