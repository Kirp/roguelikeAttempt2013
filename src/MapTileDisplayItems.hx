package ;
import nme.Lib;
/**
 * ...
 * @author VGC
 */

class MapTileDisplayItems 
{
	//tile constants
	inline public static var ITEM_EMPTY = 0;
	inline public static var ITEM_ROCK = 1;
	inline public static var ITEM_POTION = 2;
	inline public static var ITEM_KEY = 3;
	inline public static var ITEM_WAND = 4;
	inline public static var ITEM_PICKAXE = 5;
	inline public static var ITEM_AXE = 6;
	inline public static var ITEM_LOG = 7;
	inline public static var ITEM_CORPSE = 8;
	inline public static var ITEM_GOLDCOINS = 9;
	inline public static var ITEM_GEMS = 10;
	inline public static var ITEM_GOLDSTATUE = 11;
	
	
	//class variables
	public var marker:Int;
	public var face:TileSheetsGrid;
	public var _x:Float;
	public var _y:Float;
	public var name:String;
	public var cameraOffsetx:Int;
	public var cameraOffsety:Int;
	public var isDrawn:Bool = false;
	public var amount:Int = 0;
	
	public function new(_x:Float, _y:Float, marker:Int, amnt:Int = 0) 
	{
		this._x = _x;
		this._y = _y;
		this.marker = marker;
		this.amount = amnt;
		init();
	}
	
	public function init() 
	{
		switch (marker)
		{
			case ITEM_EMPTY: //(0) ground
				face = null;
				name = "Empty";
				
			case ITEM_ROCK: //(1) rock
				face = new TileSheetsGrid(43);
				name = "Rock";
				
			case ITEM_POTION: //(2) potion
				face = new TileSheetsGrid(34);
				name = "Potion";
			
			case ITEM_KEY: //(3) Key
				face = new TileSheetsGrid(13);
				name = "Key";
				
			case ITEM_WAND: //(4) Wand
				face = new TileSheetsGrid(46);
				name = "Wand";
			
			case ITEM_PICKAXE: // (5) Pickaxe
				face = new TileSheetsGrid(42);
				name = "Pickaxe";
				
			case ITEM_AXE: // (6) Axe
				face = new TileSheetsGrid(42);
				name = "Axe";
				
			case ITEM_LOG: // (7) Log
				face = new TileSheetsGrid(23);
				name = "Log";
			
			case ITEM_CORPSE: //(8) Corpse
				face = new TileSheetsGrid(38);
				name = "Corpse";
				
			case ITEM_GOLDCOINS: //(9) GOLD COINS
				face = new TileSheetsGrid(37);
				name = "Gold Coins";
				
			case ITEM_GEMS: //(10) GEMS
				face = new TileSheetsGrid(16);
				name = "Gem";
			
			case ITEM_GOLDSTATUE: //(11) GoldStatue
				face = new TileSheetsGrid(235);
				name = "Gold Statue";
				
			default:
				face = new TileSheetsGrid(2);
				name = "unknown";
		}
	}
	
	public function changeTile(newMarker:Int):Void
	{
		switch (newMarker)
		{
			case ITEM_EMPTY: //(0) ground
				Lib.stage.removeChild(face);
				face = null;
				name = "Empty";
				
			case ITEM_ROCK: //(1) rock
				face.changeTile(43);
				name = "Rock";
				
			case ITEM_POTION: //(2) potion
				face.changeTile(34);
				name = "Potion";
			
			case ITEM_KEY: //(3) Key
				face.changeTile(13);
				name = "Key";
				
			case ITEM_WAND: //(4) Wand
				face.changeTile(46);
				name = "Wand";
			
			case ITEM_PICKAXE: // (5) Pickaxe
				face.changeTile(42);
				name = "Pickaxe";
				
			case ITEM_AXE: // (6) Axe
				face.changeTile(42);
				name = "Axe";
				
			case ITEM_LOG: // (7) Log
				face.changeTile(23);
				name = "Log";
			
			case ITEM_CORPSE: //(8) Corpse
				face.changeTile(38);
				name = "Corpse";
				
			case ITEM_GEMS: //(10) GEMS
				face.changeTile(16);
				name = "Gem";
			
			case ITEM_GOLDSTATUE: //(11) GoldStatue
				face.changeTile(235);
				name = "Gold Statue";
				
			default:
				face.changeTile(2);
				name = "unknown";
		}
	}
	
	public function draw(camerax:Int, cameray:Int):Void
	{
		cameraOffsetx = camerax;
		cameraOffsety = cameray;
		if (isDrawn == false)
		{	
			
			if (face!=null)
			{
			face.x = (this._x) * TileSheetsGrid.TILE_WIDTH + cameraOffsetx;
			face.y = (this._y) * TileSheetsGrid.TILE_HEIGHT + cameraOffsety;
			Lib.stage.addChild(face);
			}
		} else
			{
				face.x = (this._x) * TileSheetsGrid.TILE_WIDTH + cameraOffsetx;
				face.y = (this._y) * TileSheetsGrid.TILE_HEIGHT + cameraOffsety;
			}
	}
	
	public function clear():Void
	{
		Lib.stage.removeChild(face);
	}
	
	public function sayName():String
	{
		return this.name;
	}
	
}