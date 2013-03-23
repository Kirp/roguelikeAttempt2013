package ;
import nme.display.Sprite;

/**
 * ...
 * @author VGC
 */

class SartScreen extends Sprite
{
	public var Title:FeedBackDisplay;
	public var description:FeedBackDisplay;
	public var description2:FeedBackDisplay;
	public var description3:FeedBackDisplay;
	public var prompt:FeedBackDisplay;
	
	
	public function new() 
	{
		super();
		Title = new FeedBackDisplay(10, 10);
		Title.changeSize(40);
		Title.sayThis("d is for Dragon");
		Title.draw();
		
		description = new FeedBackDisplay(10, 100);
		description.changeSize(15);
		description.sayThis("You are a young dragon raiding a local dwarven mine");
		description.draw();
		
		description2 = new FeedBackDisplay(10, 120);
		description2.changeSize(15);
		description2.sayThis("Use your flame breath to keep the pesky dwarves from stopping your feast and gain more power");
		description2.draw();
		
		description3 = new FeedBackDisplay(10, 140);
		description3.changeSize(15);
		description3.sayThis("Press 's' for the breath attack and go down stairs('>') with 'd'");
		description3.draw();
		
		prompt = new FeedBackDisplay(10, 300);
		prompt.changeSize(20);
		prompt.sayThis("Press any key to start the game");
		prompt.draw();
	}
	
	public function clearUp():Void
	{
		Title.clearText();
		description.clearText();
		description2.clearText();
		description3.clearText();
		prompt.clearText();
	}
	
}