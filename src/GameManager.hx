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
	public var itemList:Array<MapTileDisplayItems>;
	public var enemyList:Array<Enemy>;
	
	public var tilesInSight:Array<Point>;
	
	public var currentStage:Int = 0;
	public var mainMech:MazinTypeHero;
	public var schmoe:Enemy;
	
	public var camerax:Int = 0; //TODO: FIX THIS DAMN CAMERA
	public var cameray:Int = 0;
	
	public function new() 
	{
		super();
		arrdungeonStages = [];
		enemyList = [];
		itemList = [];
		
		
		//temp code start
		mainMech = new MazinTypeHero(5, 5, this);
		var stage = new DungeonMaker(20, 20); 
		arrdungeonStages.push(stage);
		arrdungeonStages[currentStage].fillMapWith(1);
		
		
		
		
		arrdungeonStages[currentStage].drawMap(camerax, cameray);
		mainMech.draw();
		
		
		schmoe = new Enemy(10, 5, mainMech, this);
		schmoe.draw();
		enemyList.push(schmoe);
		
		updateSeenTiles();
		
		//temp code end
		Lib.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	public function onKeyDown(e:KeyboardEvent):Void 
	{
		var keyPressed = e.keyCode;
		var delta = new Point();
		
		switch (keyPressed)
		{
			case numlKEY_UP:
				delta.x = 0;
				delta.y = -1;
				PlayerMovement(delta);
				
			case numlKEY_UPLEFT:
				delta.x = -1;
				delta.y = -1;
				PlayerMovement(delta);
				
			case numlKEY_UPRIGHT:
				delta.x = 1;
				delta.y = -1;
				PlayerMovement(delta);
				
			case numlKEY_DOWN:
				delta.x = 0;
				delta.y = 1;
				PlayerMovement(delta);
				
			case numlKEY_DOWNLEFT:
				delta.x = -1;
				delta.y = 1;
				PlayerMovement(delta);
				
			case numlKEY_DOWNRIGHT:
				delta.x = 1;
				delta.y = 1;
				PlayerMovement(delta);
				
			case numlKEY_LEFT:
				delta.x = -1;
				delta.y = 0;
				PlayerMovement(delta);
				
			case numlKEY_RIGHT:
				delta.x = 1;
				delta.y = 0;
				PlayerMovement(delta);
			
			case KEY_G:
				camerax+=5;
				arrdungeonStages[currentStage].drawMap(camerax, cameray);
			default:
				
		}
		
		
	}
	
	public function PlayerMovement(delta:Point):Void
	{
		if (mainMech!=null)
		{
			if (isHittingEnemy(mainMech._x + delta.x, mainMech._y + delta.y))
			{
				
			}else 
				if (canMoveTo(mainMech._x + delta.x, mainMech._y + delta.y, arrdungeonStages[currentStage].TilesLoaded))
				{
					mainMech.move(delta.x, delta.y);
				}
		}
		updateSeenTiles();
		giveEnemyTurn();
	}
	
	public function giveEnemyTurn():Void
	{
		for (baddie in enemyList)
		{
			baddie.takeTurn();
		}
	}
	
	public function canMoveTo(x:Float, y:Float, checkOnMap:Array<MapTileDisplayTiles>):Bool
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
	
	public function isHittingEnemy(x:Float, y:Float):Bool
	{
		for (schmuck in enemyList)
		{
			if (schmuck._x == x && schmuck._y == y)
			{
				regularAttackEntity(mainMech, schmuck);
				return true;
			}
		}
		return false;
	}
	
	public function regularAttackEntity(attacker:Hero, defender:Hero):Void
	{
		var attackRoll = rollDice(100);
		if (attackRoll <= attacker.Accuracy - defender.Dodge)
		{
			trace(attacker.Name +" hits the " + defender.Name);
			trace("doing " + attacker.STR * attacker.DamageCapacity + " damage");
			defender.HitPoints -= attacker.STR * attacker.DamageCapacity;
			if (defender.checkIfDead())
			{
				if (isEnemyInList(defender))
				{
					removeEnemyFromList(defender);
					attacker.reDraw();
				}
			}
			
		} else trace(attacker.Name + " missed");
	}
	
	public function removeEnemyFromList(enemy:Hero):Void
	{
		for (dead in enemyList)
		{
			if (dead == enemy)
			{
				trace(dead.Name + " was killed!");
				var remains = new MapTileDisplayItems(dead._x, dead._y, MapTileDisplayItems.ITEM_CORPSE);
				remains.draw();
				itemList.push(remains);
				dead.removeAll();
				enemyList.remove(dead);
			}
		}
    }

	public function isEnemyInList(query:Hero):Bool
	{
		for (unit in enemyList)
		{
			if (unit == query)
			{
				return true;
			}
		}
		return false;
	}
	
	public function isTileInList(seek:MapTileDisplayTiles):Bool
	{
		for (tile in arrdungeonStages[currentStage].TilesLoaded)
		{
			if (tile._x == seek._x && tile._y == seek._y)
			return true;
		}
		return false;
	}
	
	public function getTileByPoint(XY:Point):MapTileDisplayTiles
	{
		for (tile in arrdungeonStages[currentStage].TilesLoaded)
		{
			if (tile._x == XY.x && tile._y == XY.y)
			{
				return tile;
			}
		}
		return null;
	}
	
	
	public function rollDice(dieSize:Int):Int
	{
		return Math.floor((Math.random() * (dieSize-1)) + 1);
	}
	
	public function updateSeenTiles():Void
	{
		if (tilesInSight == null)
		{
			tilesInSight = mainMech.getSightRangePoints(new Point(mainMech._x, mainMech._y), mainMech.SightRange);
			for (sighted in tilesInSight)
			{
				var isThere:MapTileDisplayTiles = getTileByPoint(sighted);
				if (isThere != null)
				{
					isThere.reveal();
				}	
			}
		} else
			{
				for (sighted in tilesInSight)
				{
					var isThere:MapTileDisplayTiles = getTileByPoint(sighted);
					if (isThere != null)
					{
						isThere.outOfSight();
					}	
				}
				
				tilesInSight = mainMech.getSightRangePoints(new Point(mainMech._x, mainMech._y), mainMech.SightRange);
				for (sighted in tilesInSight)
				{
					var isThere:MapTileDisplayTiles = getTileByPoint(sighted);
					if (isThere != null)
					{
						isThere.reveal();
					}	
				}
				
				
			}
	}
	
	
}