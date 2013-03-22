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
	
	public var HitPoints:Int= 100;
	public var Energy:Int = 100;
	public var Name:String = "Derp";
	public var Level:Int = 1;
	public var SkillSet:Array<SpecialMove>;
	
	//stats
	public var STR:Int = 10;
	public var HPRegenRate:Int = 1;
	public var ENRegenRate:Int = 5;
	public var MaxHP:Int = 100;
	public var MaxEN:Int = 100;
	public var tickPerRegen:Int = 5;
	public var tickCounter:Int = 0;
	
	
	//combat modifiers
	public var Accuracy:Int = 50;
	public var Dodge:Int = 10;
	public var DamageCapacity:Int = 1;
	public var Range:Int = 2;
	public var Reach:Int = 1;
	public var SightRange:Int = 5;
	public var isRangeUnit:Bool = true;
	
	public var _x:Float;
	public var _y:Float;
	public var face:TileSheetsGrid;
	public var inventory:Array<Item>;
	
	private var master:GameManager;
	
	public function new(x:Float, y:Float, gameMaster:GameManager) 
	{
		master = gameMaster;
		inventory = [];
		SkillSet = [];
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
	
	public function setMaxHP(max:Int):Void
	{
		this.MaxHP = max;
		this.HitPoints = max;
	}
	
	public function setMaxEN(maxe:Int):Void
	{
		this.MaxEN = maxe;
		this.Energy = maxe;
	}
	
	public function setRegenRates(hpReg:Int, enReg:Int):Void
	{
		HPRegenRate = hpReg;
		ENRegenRate = enReg;
	}
	
	public function setSTR(str:Int):Void
	{
		this.STR = str;
	}
	
	public function setAccuracy(val:Int):Void
	{
		this.Accuracy = val;
	}
	
	public function setDodge(val:Int):Void
	{
		Dodge = val;
	}
	
	public function setDamageCapacity(val:Int):Void
	{
		DamageCapacity = val;
	}
	
	public function setReach(val:Int):Void
	{
		Reach = val;
	}
	
	public function setSightRange(val:Int):Void
	{
		SightRange = val;
	}
	
	public function setRangedUnitStatus(val:Bool):Void
	{
		isRangeUnit = val;
	}
	
	public function setAllStats(name:String, maxHitp:Int, maxEner:Int, strength:Int, accura:Int, dodg:Int, DamCap:Int, rang:Int, reach:Int, sightR:Int, canRange:Bool):Void
	{
		setName(name);
		setMaxHP(maxHitp);
		setSTR(strength);
		setAccuracy(accura);
		setDodge(dodg);
		setDamageCapacity(DamCap);
		setRange(rang);
		setReach(reach);
		setSightRange(sightR);
		setRangedUnitStatus(canRange);
	}
	
	public function skillSetAvailable():Bool
	{
		if (SkillSet == null)
		{
			return false;
		}
		return true;
	}
	
	
	
	public function regenEffectTick():Void
	{
		if (tickCounter >= tickPerRegen)
		{
			if (HitPoints < HitPoints)
			{
				HitPoints += HPRegenRate;
			}
			
			if (Energy < MaxEN)
			{
				Energy += ENRegenRate;
			}
			
			tickCounter = 0;
		}
		tickCounter++;
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