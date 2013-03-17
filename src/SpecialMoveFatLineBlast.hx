package ;
import nme.geom.Point;

/**
 * ...
 * @author VGC
 */

class SpecialMoveFatLineBlast extends SpecialMoveLineBlast
{
	public var minFatBeam:Int = -1;
	public var maxFatBeam:Int = 1;

	public function new(movName:String, cost:Int, damage:Int, initiator:Hero, GM:GameManager, fireLength:Int) 
	{
		super(movName, cost, damage, initiator, GM, fireLength);
		
	}
	
	override public function getAffectedPositions():Array<Point>
	{
		var affected:Array<Point> = [];
		
		if (firingDelta.x == 1 && firingDelta.y == 0 || firingDelta.x == -1 && firingDelta.y==0)
		{	
			for (i in 1...blastLength)
			{
				
				for (y in minFatBeam...maxFatBeam+1)
				{
					affected.push(new Point(caster._x + (firingDelta.x * i), caster._y + (firingDelta.y<0?firingDelta.y - y:firingDelta.y + y )));	
				}
				
				
			}
			return affected;
		}else if (firingDelta.y == 1 && firingDelta.x == 0 || firingDelta.y == -1 && firingDelta.x==0)
				{	
					for (i in 1...blastLength)
					{
						
						for (y in minFatBeam...maxFatBeam+1)
						{
							affected.push(new Point(caster._x + (firingDelta.x<0?firingDelta.x - y:firingDelta.x + y ), caster._y + (firingDelta.y * i)));	
						}
						
						
					}
					return affected;
				}else
					{
						master.reportFeed.sayThis("Targeting error! Can only fire straight N/E/W/S");
					}
		
		return affected;
	}
}