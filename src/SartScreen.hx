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
	public var description4:FeedBackDisplay;
	public var description5:FeedBackDisplay;
	public var prompt:FeedBackDisplay;
	
	
	public function new() 
	{
		super();
		Title = new FeedBackDisplay(250, 10);
		Title.changeSize(40);
		Title.sayThis("d is for Dragon");
		Title.draw();
		
		description = new FeedBackDisplay(10, 130);
		description.changeSize(15);
		description.sayThis("You are a young dragon raiding a local dwarven mine");
		description.draw();
		
		description2 = new FeedBackDisplay(10, 170);
		description2.changeSize(15);
		description2.sayThis("Use your flame breath to keep the pesky dwarves from stopping your feast and gain more power");
		description2.draw();
		
		description3 = new FeedBackDisplay(10, 200);
		description3.changeSize(15);
		description3.sayThis("Your 'gold' sense will also help you in finding all the loot");
		description3.draw();
		
		description4 = new FeedBackDisplay(10, 230);
		description4.changeSize(15);
		description4.sayThis("Press 's' for the breath attack and go down stairs('>') with 'd'");
		description4.draw();
		
		description5 = new FeedBackDisplay(10, 260);
		description5.changeSize(15);
		description5.sayThis("Move with the numpad keys, make sure numlock is on");
		description5.draw();
		
		prompt = new FeedBackDisplay(250, 400);
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
		description4.clearText();
		description5.clearText();
		prompt.clearText();
	}
	
}