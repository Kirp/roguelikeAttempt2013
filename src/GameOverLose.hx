package ;
import nme.display.Sprite;

/**
 * ...
 * @author VGC
 */

class GameOverLose extends Sprite
{
	public var Title:FeedBackDisplay;
	public var description:FeedBackDisplay;
	public var description2:FeedBackDisplay;
	public var description3:FeedBackDisplay;
	public var prompt:FeedBackDisplay;

	public function new() 
	{
		super();
		Title = new FeedBackDisplay(300, 10);
		Title.changeSize(40);
		Title.sayThis("Game Over");
		Title.draw();
		
		description = new FeedBackDisplay(220, 100);
		description.changeSize(15);
		description.sayThis("You failed to get enough riches to turn into a greater dragon");
		description.draw();
		
		description2 = new FeedBackDisplay(140, 150);
		description2.changeSize(15);
		description2.sayThis("The dwarves found the riches in your belly, celebrated, then died from alcohol poisoning");
		description2.draw();
		
		description3 = new FeedBackDisplay(350, 200);
		description3.changeSize(20);
		description3.sayThis("Partial Win!");
		description3.draw();
		
	}
	
}