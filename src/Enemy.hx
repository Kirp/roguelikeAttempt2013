package ;
import nme.geom.Point;


/**
 * ...
 * @author VGC
 */

enum EnemyAIState {
	sentry;
	PatrolX;
	PatrolY;
	engage;
	
}

class Enemy extends Hero
{
	public var behavior:EnemyAIState;
	public var currentTarget:Hero;
	public var priorityTarget:Hero;
	public var master:GameManager;
	
	
	public function new(x:Float, y:Float, mainTarget:Hero, gameMaster:GameManager) 
	{
		super(x, y);
		
		setName("DudeBro");
		behavior = sentry;
		changeFace(2);
		priorityTarget = mainTarget;
		master = gameMaster;
	}
	
	public function isAttackedBy(attacker:Hero):Void
	{
		currentTarget = attacker;
	}
	
	public function takeTurn():Void
	{
		switch(behavior)
		{
			case sentry:
				//scan for target here
				if (scanForTarget())
				{
					trace("main target sighted");
					currentTarget = priorityTarget;
				}
				if (currentTarget != null) //if target found then switch to engage mode
				{
					behavior = engage;
					takeTurn();
				}
				
			case PatrolX:
				
			case PatrolY:
				
			case engage:
				//place skill script here, if there are no skill attacks then
				if (checkIfTargetWithinMelee())
				{
					useMeleeAttackOnTarget(priorityTarget);
				} else simpleMoveToTarget(priorityTarget); //use skill script here or fire range or start moving
		}
	}
	
	public function simpleMoveToTarget(target:Hero):Void
	{
		var diffx = target._x - this._x;
		var diffy = target._y - this._y;
		var delta = new Point((diffx < 0? -1:1), (diffy < 0? -1:1));
		if (master.canMoveTo(this._x + delta.x, this._y + delta.y, master.arrdungeonStages[master.currentStage].TilesLoaded))
		{
			move(delta.x, delta.y);
		}else trace(this.Name + " cannot move");
		
	}
	
	public function checkIfTargetWithinMelee():Bool
	{
		for (y in -1...2)
		{
			for (x in -1...2)
			{
				if (this._x + x == priorityTarget._x && this._y +y == priorityTarget._y)
				{
					return true;
				}
			}
		}
		return false;
		
		
	}
	
	public function useMeleeAttackOnTarget(Target:Hero):Void
	{
		var attackRoll = rollDice(100);
		if (attackRoll <= this.Accuracy - Target.Dodge)
		{
			trace(this.Name +" hits the " + Target.Name);
			trace("doing " + this.STR * this.DamageCapacity + " damage");
			Target.HitPoints -= this.STR * this.DamageCapacity;
			
			
		} else trace(this.Name + " missed");		
	}
	
	
	public function scanForTarget():Bool
	{
		var getPoints:Array<Point> = getSightRangePoints(new Point(this._x, this._y), Range);
		for (coord in getPoints)
		{
			if (coord.x == priorityTarget._x && coord.y == priorityTarget._y)
			return true;
		}
		return false;
	}
	
}