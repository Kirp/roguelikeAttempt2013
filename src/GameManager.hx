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
	inline private static var TILE_WIDTH = 16;
	inline private static var TILE_HEIGHT = 16;
	
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
	inline private static var KEY_C = 67;
	inline private static var KEY_U = 85;
	inline private static var KEY_S = 83;
	
	
	public var arrdungeonStages:Array<DungeonMaker>;
	public var itemList:Array<MapTileDisplayItems>;
	public var enemyList:Array<Enemy>;
	public var temporaryItems:Array<MapTileDisplayItems>;
	
	public var tilesInSight:Array<Point>;
	
	public var currentStage:Int = 0;
	public var mainMech:MazinTypeHero;
	public var schmoe:Enemy;
	
	
	public var HUDHp:FeedBackDisplay;
	public var HUDEn:FeedBackDisplay;
	public var reportFeed:MultiTextDisplay;
	public var okToMove:Bool = true;
	public var useSkill:Bool = false;
	public var wait:Bool = false;
	
	public var camerax:Int = 0; //TODO: FIX THIS DAMN CAMERA
	public var cameray:Int = 0;
	
	
	public function new() 
	{
		super();
		arrdungeonStages = [];
		enemyList = [];
		itemList = [];
		temporaryItems = [];
		
		
		//temp code start
		mainMech = new MazinTypeHero(25, 15, this);
		var stage = new DungeonMaker(50, 50); 
		
		HUDHp = new FeedBackDisplay(10, 1);
		HUDEn = new FeedBackDisplay(10, 10);
		reportFeed = new MultiTextDisplay(50, 300);
		
		
		reportFeed.sayThis("Welcome to the game.");
		
		arrdungeonStages.push(stage);
		
		arrdungeonStages[currentStage].initializeMapWithRoomSetupA(10, 15, 15);
		
		arrdungeonStages[currentStage].drawMap(camerax, cameray);
		
		mainMech = new MazinTypeHero(arrdungeonStages[currentStage].stairsUp.x, arrdungeonStages[currentStage].stairsUp.y, this);
		mainMech.draw();
		
		//adding skills
		var iceBeam:SpecialMoveLineBlast = new SpecialMoveLineBlast("Ice Beam", 40, 50, mainMech, this, 5);
		mainMech.SkillSet.push(iceBeam);
		
		var rocketPunch = new SpecialMoveMissile("Rocket Punch", 5, 25, mainMech, this, 10);
		mainMech.SkillSet.push(rocketPunch);
		
		var breastFire = new SpecialMoveConeBlast("Breast Fire", 5, 40, mainMech, this, 4);
		mainMech.SkillSet.push(breastFire);
		
		var fireBlaster = new SpecialMoveFatLineBlast("Fire Blaster", 5 , 50, mainMech, this, 5);
		mainMech.SkillSet.push(fireBlaster);
		
		var schmoe = new Enemy(arrdungeonStages[currentStage].RoomList[1].centerX, arrdungeonStages[currentStage].RoomList[1].centerY, mainMech, this);
		schmoe.draw();
		enemyList.push(schmoe);
		
		var schmoe = new Enemy(arrdungeonStages[currentStage].RoomList[2].centerX, arrdungeonStages[currentStage].RoomList[2].centerY, mainMech, this);
		schmoe.isRangeUnit = false;
		schmoe.draw();
		enemyList.push(schmoe);
		
		var schmoe = new Enemy(arrdungeonStages[currentStage].RoomList[3].centerX, arrdungeonStages[currentStage].RoomList[3].centerY, mainMech, this);
		schmoe.isRangeUnit = false;
		schmoe.draw();
		enemyList.push(schmoe);
		
		
		updateSeenTiles();
		
		
		redrawHUD();
		centerCamera();
		
		trace(arrdungeonStages[currentStage].RoomList[0].getOpenSpace());
		//temp code end
		Lib.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	public function onKeyDown(e:KeyboardEvent):Void 
	{
		var keyPressed = e.keyCode;
		var delta = new Point();
		
		for (rock in temporaryItems)
		{
			rock.clear();
		}
		temporaryItems = [];
		
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
				
			
			case KEY_S:
				reportFeed.sayThis("Enter Direction to shoot");
				useSkill = true;
				okToMove = false;
				wait = true;
			
			case KEY_D:
				if (arrdungeonStages[currentStage].MapTile[Std.int(mainMech._y)][Std.int(mainMech._x)] == MapTileDisplayTiles.ITEM_STAIRSDOWN)
				{
					switchDungeonsForward();
					
				} else trace("no stairs here");
				trace(arrdungeonStages.length);
				
			default:
				
		}
		
		if (wait == false)
		{	
			if(okToMove)
			{
				PlayerMovement(delta);
				announceItemOnFoot();
			} 
			
			if (useSkill)
			{
				//cast skill
				mainMech.SkillSet[2].fire(delta);
				
				regenEffectUpdate();
				useSkill = false;
				okToMove = true;
				giveEnemyTurn();
			}
			
			
			updatePlayerStatus();
			checkIfNeedToCenterPlayer();
		}
		
		wait = false;
		
	}
	
	public function switchDungeonsForward():Void
	{
		camerax = 0;
		cameray = 0;
		if (currentStage + 1 == arrdungeonStages.length)
		{
			purgeEntities();
			var newStage = new DungeonMaker(50, 50);
			newStage.initializeMapWithRoomSetupA( 10, 15, 15);
			arrdungeonStages.push(newStage);
			
			arrdungeonStages[currentStage].clearTiles();
			currentStage+=1;
			arrdungeonStages[currentStage].drawMap(camerax, cameray);
			mainMech._x = arrdungeonStages[currentStage].stairsUp.x;
			mainMech._y = arrdungeonStages[currentStage].stairsUp.y;
			mainMech.reDraw();
		}
		
		updateSeenTiles();
		redrawHUD();
		centerCamera();
	}
	
	public function purgeEntities():Void
	{
		for (item in itemList)
		{
			item.clear();
		}
		itemList = [];
		for (enmy in enemyList)
		{
			enmy.removeAll();
		}
		enemyList = [];
	}
	
	public function announceItemOnFoot():Void
	{
		for (litter in itemList)
		{
			if (litter._x == mainMech._x && litter._y == mainMech._y)
			{
				reportFeed.sayThis("There is a " +litter.name+" here.");
			}
		}
	}
	
	public function regenEffectUpdate():Void
	{
		if (mainMech.tickCounter >= mainMech.tickPerRegen)
		{
			if (mainMech.HitPoints < mainMech.HitPoints)
			{
				mainMech.HitPoints += mainMech.HPRegenRate;
			}
			
			if (mainMech.Energy < mainMech.MaxEN)
			{
				mainMech.Energy += mainMech.ENRegenRate;
			}
			
			mainMech.tickCounter = 0;
		}
		mainMech.tickCounter++;
	}
	
	public function redrawHUD():Void
	{
		HUDHp.sayThis("HP :"+Std.string(mainMech.HitPoints));
		HUDHp.draw();
		HUDEn.sayThis("EN :" + Std.string(mainMech.Energy));
		HUDEn.draw();
		reportFeed.draw();
	}
	
	
	
	public function updatePlayerStatus():Void
	{
		HUDHp.sayThis("HP :" + Std.string(mainMech.HitPoints));
		HUDEn.sayThis("EN :" + Std.string(mainMech.Energy));
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
		regenEffectUpdate();
		updateSeenTiles();
		giveEnemyTurn();
		enemySpawnCheck();
	}
	
	public function reDrawAll():Void
	{
		
		arrdungeonStages[currentStage].drawMap(camerax, cameray);
		for (item in itemList)
		{
			item.draw(camerax, cameray);
		}
		mainMech.reDraw();
		for (derp in enemyList)
		{
			derp.reDraw();
		}
		redrawHUD();
	}
	
	public function centerCamera():Void
	{
		camerax = Std.int(-mainMech.face.x +128);
		cameray = Std.int(-mainMech.face.y +128);
		reDrawAll();
	}
	
	public function checkIfNeedToCenterPlayer():Void
	{
		var redraw:Bool = false;
		if (mainMech.face.x< 128)
		{
			camerax+=TILE_WIDTH;
			redraw = true;
		}
		
		if (mainMech.face.x > 640)
		{
			camerax-=TILE_WIDTH;
			redraw = true;
		}
		
		if (mainMech.face.y < 128)
		{
			cameray += TILE_HEIGHT;
			redraw = true;
		}
		
		if (mainMech.face.y > 272)
		{
			cameray -= TILE_HEIGHT;
			redraw = true;
		}
		
		if (redraw)
		{
				arrdungeonStages[currentStage].drawMap(camerax, cameray);
				for (item in itemList)
				{
					item.draw(camerax, cameray);
				}
				mainMech.reDraw();
				for (derp in enemyList)
				{
					derp.reDraw();
				}
		}
		
		
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
		
		for (enemy in enemyList)
		{
			if (enemy._x == x && enemy._y == y)
			{
				passable = false;
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
			reportFeed.sayThis(attacker.Name +" hits the " + defender.Name+"doing " + attacker.STR * attacker.DamageCapacity + " damage");
			defender.HitPoints -= attacker.STR * attacker.DamageCapacity;
			if (defender.checkIfDead())
			{
				if (isEnemyInList(defender))
				{
					removeEnemyFromList(defender);
					attacker.reDraw();
				}
			}
			
		} else 
			{
				trace(attacker.Name + " missed");
				reportFeed.sayThis(attacker.Name + " missed");
			}
	}
	
	public function checkForDead():Void
	{
		var foundDead:Bool = false;
		for (body in enemyList)
		{
			if (body.HitPoints <= 0)
			{
				removeEnemyFromList(body);
				foundDead = true;
			}
		}
		
		if (foundDead) mainMech.reDraw();
	}
	
	public function removeEnemyFromList(enemy:Hero):Void
	{
		for (dead in enemyList)
		{
			if (dead == enemy)
			{
				trace(dead.Name + " was killed!");
				reportFeed.sayThis(dead.Name + " was killed!");
				var remains = new MapTileDisplayItems(dead._x, dead._y, MapTileDisplayItems.ITEM_CORPSE);
				remains.draw(camerax, cameray);
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
	
	public function enemySpawnCheck():Void
	{
		if (enemyList.length < 4)
		{	
			var choicePick = Math.random();
			var rangeSet:Bool = choicePick < 0.5?false:true;
			var randomPoint = arrdungeonStages[currentStage].getRandomOpenSpace();
			var schmoe = new Enemy(randomPoint.x, randomPoint.y, mainMech, this);
			schmoe.isRangeUnit = rangeSet;
			schmoe.draw();
			enemyList.push(schmoe);
		}
	}
	
}