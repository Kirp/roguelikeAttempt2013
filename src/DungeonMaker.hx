package ;

import nme.display.Sprite;
import nme.geom.Point;
import nme.geom.Rectangle;

/**
 * ...
 * @author VGC
 */

class DungeonMaker extends Sprite
{
	//This is the simple method of making random squares and then making sure they dont overlap
	
	public var MAP_WIDTH = 42;
	public var MAP_HEIGHT = 30;
	
	
	private var MINIMUM_LEN = 3;
	private var MINIMUM_WID = 3;
	public var MapTile:Array<Array<Int>>;
	public var TilesLoaded:Array<MapTileDisplayTiles>;
	public var RoomList:Array<RoomData>;
	private var pathMaker:Point;	
	public var cameraOffsetx:Int =0;
	public var cameraOffsety:Int = 0;
	public var isDrawn:Bool = false;
	public var stairsUp:Point;
	public var stairsDown:Point;
	
	public function new(width:Int, height:Int) 
	{
		super();
		
		MAP_WIDTH = width;
		MAP_HEIGHT = height;
		MapTile = [];
		TilesLoaded = [];
		RoomList = [];
		
	}
	
	public function clearTiles():Void
	{
		for (entity in TilesLoaded)
		{
			entity.clear();
		}
		
		
	}
	
	public function fillMapWith(fill:Int):Void
	{
		for (y in 0...MAP_HEIGHT+1)
		{
			var mapx:Array<Int> = [];
			for (x in 0...MAP_WIDTH+1)
			{
				mapx.push(fill);
			}
			MapTile.push(mapx);
		}
	}
	
	
	public function drawMap(camerax:Int, cameray:Int):Void
	{
		cameraOffsetx = camerax;
		cameraOffsety = cameray;
		if (isDrawn == false)
		{	
			for (i in 0...MapTile.length)
			{
				for (h in 0...MapTile[i].length)
				{
					if(MapTile[i][h] != 0) TilesLoaded.push(new MapTileDisplayTiles(h, i, MapTile[i][h]));
				}
			}
			
			//draw map tiles
			for (tile in TilesLoaded)
			{
				tile.draw(cameraOffsetx, cameraOffsety);
			}
			
			isDrawn = true;
		} else 
			{
				for (tile in TilesLoaded)
				{
					tile.draw(cameraOffsetx, cameraOffsety);
				}
			}
	}
	
	public function addRandomTile(tile:Int):Void
	{
		var diceRollx = Math.floor(Math.random() * MAP_WIDTH);
		var diceRolly = Math.floor(Math.random() * MAP_HEIGHT);
		MapTile[diceRolly][diceRollx] = tile;
	}
	
	public function changeTileTo(x:Int, y:Int, tile:Int):Void
	{
		MapTile[y][x] = tile;
	}
	
	public function addRandomRectangle(tile:Int, maxlen:Int, maxWidth:Int):Void
	{
		var numberOfChecks:Int = 0;
		var lenRoll = Math.floor(Math.random() * (maxlen - MINIMUM_LEN)) + MINIMUM_LEN;
		var heiRoll = Math.floor(Math.random() * (maxWidth - MINIMUM_WID)) + MINIMUM_WID;
		var goodRect:Bool = false;
		var copySpotted:Bool = false;
		
		while (goodRect==false)
		{	
			copySpotted = false;
			var diceRollx = Math.floor(Math.random() * (MAP_WIDTH - lenRoll ));
			var diceRolly = Math.floor(Math.random() * (MAP_HEIGHT - heiRoll));
			
			for (y in 0...heiRoll+1)
			{
				for (x in 0...lenRoll+1) //@TODO: diceroll value gets a neg number, fix it
				{
					if (MapTile[diceRolly + y][diceRollx + x] == tile)
					{
						copySpotted = true;
					}
				}
			}
			
			if (copySpotted == true)
			{
				goodRect = false;
				numberOfChecks++;
			} else 
				{
					for (y in 0...heiRoll+1)
					{
						for (x in 0...lenRoll+1)
						{
							MapTile[diceRolly + y][diceRollx + x] = tile;
						}
					}
					
					for (y in 1...heiRoll)
					{
						for (x in 1...lenRoll)
						{
							MapTile[diceRolly + y][diceRollx + x] = 1;
						}
					}
					
					
					RoomList.push(new RoomData(diceRollx, diceRolly, lenRoll, heiRoll));
					goodRect = true;
				}
			if (numberOfChecks > 100) 
			{	
				trace("cannot fit room");
				break;
			}
		}	
	}
	
	public function connectRoomTo(roomA:Int, roomB:Int):Bool
	{
		
		if (roomA > MapTile.length || roomB > MapTile.length)
		{
			return false;
		}
		
		var diffx = RoomList[roomB].centerX - RoomList[roomA].centerX;
		var	signx = diffx > 0 ? 1 : -1;
		var diffy = RoomList[roomB].centerY - RoomList[roomA].centerY;
		var	signy = diffy > 0 ? 1 : -1;
		var spaceMaker:Point = new Point(RoomList[roomA].centerX, RoomList[roomA].centerY);
		
		if (signx > 0)
		{
			while (spaceMaker.x < RoomList[roomB].centerX)
			{
				spaceMaker.x += signx;
				MapTile[Std.int((spaceMaker.y))][Std.int(spaceMaker.x)] = 1;
			}
		} else if (signx < 0)
				{ 
					while (spaceMaker.x > RoomList[roomB].centerX)
					{
						spaceMaker.x += signx;
						MapTile[Std.int((spaceMaker.y))][Std.int(spaceMaker.x)] = 1;
					}
				}
		
		if (signy > 0)
		{
			while (Math.floor(spaceMaker.y) < RoomList[roomB].centerY)
			{
				spaceMaker.y += signy;
				MapTile[Std.int(spaceMaker.y)][Std.int(spaceMaker.x)] = 1;
			}
		} else if (signy < 0)
				{
					while (Math.floor(spaceMaker.y) > RoomList[roomB].centerY)
					{
						spaceMaker.y += signy;
						MapTile[Std.int(spaceMaker.y)][Std.int(spaceMaker.x)] = 1;
					}
				}
		return true;
	}
	
	public function connectAllRooms():Void
	{
		for (i in 0...RoomList.length)
		{
			var b = Math.floor(Math.random() * RoomList.length);
			while (i == b)
			{
				b = Math.floor(Math.random() * RoomList.length);
			}
			connectRoomTo(i, b);
		}
	}
	
	public function addStairs():Void
	{
		var randomPickRoom = Std.int(Math.random() * (RoomList.length - 1));
		var roomOpenSpace = RoomList[randomPickRoom].getOpenSpace();
		var randomOpenTile = Std.int(Math.random() * (roomOpenSpace.length - 1));
		var pickedTile:Point = roomOpenSpace[randomOpenTile];
		MapTile[Std.int(pickedTile.y)][Std.int(pickedTile.x)] = MapTileDisplayTiles.ITEM_STAIRSDOWN;
		stairsDown = new Point(pickedTile.x, pickedTile.y);
		
		var randomPickRoomB = Std.int(Math.random() * (RoomList.length - 1));
		while (randomPickRoom == randomPickRoomB) 
		{
			randomPickRoomB = Std.int(Math.random() * (RoomList.length - 1));
		}
		
		var roomOpenSpaceB = RoomList[randomPickRoomB].getOpenSpace();
		var randomOpenTileB = Std.int(Math.random() * (roomOpenSpaceB.length - 1));
		var pickedTileB = roomOpenSpaceB[randomOpenTileB];
		MapTile[Std.int(pickedTileB.y)][Std.int(pickedTileB.x)] = MapTileDisplayTiles.ITEM_STAIRSUP;
		stairsUp = new Point(pickedTileB.x, pickedTileB.y);
	}
	
	public function getRandomOpenSpace():Point
	{
		var randomPickRoom = Std.int(Math.random() * (RoomList.length - 1));
		var roomOpenSpace = RoomList[randomPickRoom].getOpenSpace();
		var randomOpenTile = Std.int(Math.random() * (roomOpenSpace.length - 1));
		var pickedTile:Point = roomOpenSpace[randomOpenTile];
		return pickedTile;
	}
	
	public function initializeMapWithRoomSetupA(numberOfRooms:Int, maxRoomWidth:Int, maxRoomHeight:Int):Void
	{
		fillMapWith(0);
		for (rooms in 0...numberOfRooms)
		{
			addRandomRectangle(2, maxRoomWidth, maxRoomHeight);
		}
		
		connectAllRooms();
		addStairs();
	}
	
}