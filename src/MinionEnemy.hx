package ;

/**
 * ...
 * @author VGC
 */

class MinionEnemy extends Enemy
{

	public function new(x:Float, y:Float, mainTarget:Hero, gameMaster:GameManager) 
	{
		super(x, y, mainTarget, gameMaster);
	}
	
	override public function takeTurn():Void
	{
		switch(behavior)
		{
			case sentry:
				//scan for target here
				if (scanForTarget())
				{
					//trace("main target sighted");
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
				if (isRangeUnit)
				{
					if (checkIfTargetWithinRange())
					{
						//use range attack
						useRangeAttackOnTarget(priorityTarget);
					} else simpleMoveToTargetB(priorityTarget);
					
				}else if (checkIfTargetWithinMelee())
					{
						useMeleeAttackOnTarget(priorityTarget);
					} else simpleMoveToTargetB(priorityTarget); //use skill script here or fire range or start moving
		}
		checkIfSeen();
	}
}