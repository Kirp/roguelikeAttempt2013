package ;
import nme.display.Sprite;

/**
 * ...
 * @author VGC
 */

class GameOverWin extends Sprite
{
	public var Title:FeedBackDisplay;
	public var description:FeedBackDisplay;
	public var description2:FeedBackDisplay;
	public var description3:FeedBackDisplay;
	public var prompt:FeedBackDisplay;
	
	public function new() 
	{
		super();
		Title = new FeedBackDisplay(250, 10);
		Title.changeSize(40);
		Title.sayThis("D is for Dragon");
		Title.draw();
		
		description = new FeedBackDisplay(200, 100);
		description.changeSize(15);
		description.sayThis("You ate enough riches to turn into a powerful greater Dragon");
		description.draw();
		
		description2 = new FeedBackDisplay(130, 150);
		description2.changeSize(15);
		description2.sayThis("The dwarves have moved away to lament their ways till they find a wizard and a hobbit");
		description2.draw();
		
		description3 = new FeedBackDisplay(300, 200);
		description3.changeSize(15);
		description3.sayThis("Thanks for Playing!");
		description3.draw();
		
		prompt = new FeedBackDisplay(85, 410);
		prompt.changeSize(20);
		prompt.sayThis("Game created (and failed to submit in time) for the 7DRL challenge - DeCampanille");
		prompt.draw();
	}
	
}