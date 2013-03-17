package ;
import nme.geom.Point;

/**
 * ...
 * @author VGC
 */

class SpecialMoveMissile extends SpecialMoveLineBlast
{
	
	public function new(movName:String, cost:Int, damage:Int, initiator:Hero, GM:GameManager, fireLength:Int) 
	{
		super(movName, cost, damage, initiator, GM, fireLength);
		
	}
	
	
	override public function getAffectedPositions():Array<Point>
	{
		var affected:Array<Point> = [];
		for (i in 1...blastLength)
		{
			var enemyDetected:Bool = false;
			affected.push(new Point(caster._x + (firingDelta.x * i), caster._y + (firingDelta.y * i)));
			for(enemy in master.enemyList)
			{	if (enemy._x == caster._x + (firingDelta.x * i) && enemy._y == caster._y + (firingDelta.y * i))
					{
						enemyDetected = true;
					}
			}
			if (enemyDetected)
			{
				break;
			}
			
		}
		return affected;
	}
}