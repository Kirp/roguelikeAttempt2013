package ;
import nme.geom.Point;

/**
 * ...
 * @author VGC
 */

class SpecialMove 
{	
	public var moveName:String;
	public var caster:Hero;
	
	public var master:GameManager;
	public var energyCost:Int;
	public var damageDone:Int;
	
	public function new(movName:String, cost:Int, damage:Int, initiator:Hero, gm:GameManager) 
	{
		moveName = movName;
		energyCost = cost;
		damageDone = damage;
		caster = initiator;
	
		master = gm;
	}
	
	public function canFire():Bool
	{
		if (caster.Energy >= energyCost)
		{
			return true;
		} else return false;
	}
	
	public function fire(direction:Point):Void
	{
		
	}
	
	public function fireAt(target:Hero):Void
	{
		
	}
	
}