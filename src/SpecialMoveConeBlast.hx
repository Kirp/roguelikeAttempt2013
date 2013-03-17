package ;
import nme.geom.Point;

/**
 * ...
 * @author VGC
 */

class SpecialMoveConeBlast extends SpecialMoveLineBlast
{

	public function new(movName:String, cost:Int, damage:Int, initiator:Hero, GM:GameManager, fireLength:Int) 
	{
		super(movName, cost, damage, initiator, GM, fireLength);
		
	}
	

	
	override public function getAffectedPositions():Array<Point>
	{
		var affected:Array<Point> = [];
		var extraCounter:Int = 0;
		if (firingDelta.x == 1 && firingDelta.y == 0 || firingDelta.x == -1 && firingDelta.y==0)
		{	
			for (i in 1...blastLength)
			{
				var min:Int = extraCounter * -1;
				var max:Int = extraCounter;
				for (y in min...max + 1)
				{
					affected.push(new Point(caster._x + (firingDelta.x * i), caster._y + (firingDelta.y<0?firingDelta.y - y:firingDelta.y + y )));	
				}
				
				extraCounter++;
			}
			return affected;
		}else if (firingDelta.y == 1 && firingDelta.x == 0 || firingDelta.y == -1 && firingDelta.x==0)
				{	
					for (i in 1...blastLength)
					{
						var min:Int = extraCounter * -1;
						var max:Int = extraCounter;
						for (y in min...max + 1)
						{
							affected.push(new Point(caster._x + (firingDelta.x<0?firingDelta.x - y:firingDelta.x + y ), caster._y + (firingDelta.y * i)));	
						}
						
						extraCounter++;
					}
					return affected;
				}else
					{
						master.reportFeed.sayThis("Targeting error! Can only fire straight N/E/W/S");
					}
		
		return affected;
	}
	
}