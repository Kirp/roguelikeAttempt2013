package ;

import nme.display.Sprite;
import nme.events.Event;
import nme.geom.Point;
import nme.Lib;

/**
 * ...
 * @author VGC
 */

class Main extends Sprite 
{
	private var GM:GameManager;
	
	
	
	
	public function new() 
	{
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	private function init(e) 
	{
		// entry point
		GM = new GameManager();
		//addChild(GM);
		
	}
	
	
	function drawDiamondWithPoints(range:Int):Void
	{
		var pointList:Array<Point> = [];
		var pattern = range;
		for (y in 0...range+1)
		{
			
			for (x in (pattern*-1)...pattern+1)
			{
				pointList.push(new Point(x,y));
			}
			pattern--;
			
		}
		
		//top half
		
		var pattern = range -1;
		for (y in 1...range+1)
		{
			
			for (x in (pattern*-1)...pattern+1)
			{
				pointList.push(new Point(x,y*-1));
			}
			pattern--;
			
		}
		
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Main());
	}
	
}
