package ;

import nme.display.Sprite;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.geom.Point;
import nme.Lib;

/**
 * ...
 * @author VGC
 */

 enum GameState {
	 
	 startMode;
	 gameMode;
	 endMode;
 }
 
 
class Main extends Sprite 
{
	private var GM:GameManager;
	private var StScreen:SartScreen;
	
	
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
		StScreen = new SartScreen();
		addChild(StScreen);
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, startOnKeyDown);
		//GM = new GameManager();
		//addChild(GM);
		
	}
	
	private function startOnKeyDown(e:KeyboardEvent):Void 
	{
		StScreen.clearUp();
		removeChild(StScreen);
		stage.removeEventListener(KeyboardEvent.KEY_DOWN, startOnKeyDown);
		GM = new GameManager();
	}
	
	
	
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Main());
	}
	
}
