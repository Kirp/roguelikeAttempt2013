package ;
import nme.geom.Point;

/**
 * ...
 * @author VGC
 */

class SpecialMoveLineBlast extends SpecialMove
{
	public var blastLength:Int;
	public var firingDelta:Point;
	
	public function new(movName:String, cost:Int, damage:Int, initiator:Hero, GM:GameManager, fireLength:Int) 
	{
		super(movName, cost, damage, initiator, GM);
		blastLength = fireLength;

	}
	
	override public function fire(direction:Point):Void
	{
		firingDelta = direction;
		master.reportFeed.sayThis("You activated the " + this.moveName + " attack!");
		if (master.mainMech.Energy >= energyCost)
		{
			master.mainMech.Energy -= energyCost;
			var toHit = getAffectedPositions();
			for (position in toHit)
			{	master.temporaryItems.push(new MapTileDisplayItems(position.x, position.y, MapTileDisplayItems.ITEM_ROCK));
				for (enmy in master.enemyList)
				{
					if (enmy._x == position.x && enmy._y == position.y)
					{
						master.reportFeed.sayThis(enmy.Name + " was hit with " + this.moveName + " doing " + damageDone + " damage!");
						enmy.HitPoints -= damageDone;
						
						
						break;
					}
				}
			}
			master.checkForDead();
			for (rock in master.temporaryItems)
			{
				rock.draw(master.camerax, master.cameray);
			}
		} else master.reportFeed.sayThis("Not enough energy to use "+moveName);
	}
	
	public function getAffectedPositions():Array<Point>
	{
		var affected:Array<Point> = [];
		for (i in 2...blastLength)
		{
			
			affected.push(new Point(caster._x + (firingDelta.x * i), caster._y + (firingDelta.y * i)));	
	
		}
		return affected;
	}
}