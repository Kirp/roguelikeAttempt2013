package ;
import nme.display.Sprite;
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
	
	//class variables
	public var marker:Int;
	public var face:TileSheetsGrid;
	public var _x:Float;
	public var _y:Float;
	public var isPassable:Bool = false;

	public function new(_x:Float, _y:Float, marker:Int) 
	{
		this._x = _x;
		this._y = _y;
		
		this.marker = marker;
		init();
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
				
				
			default:
				face = new TileSheetsGrid(2);
		}
	}
	
	public function draw():Void
	{
		face.x = (this._x) * TileSheetsGrid.TILE_WIDTH;
		face.y = (this._y) * TileSheetsGrid.TILE_HEIGHT;
		Lib.stage.addChild(face);
		
		
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
				
				
			default:
				face.changeTile(2);
		}
		
	}
	
}