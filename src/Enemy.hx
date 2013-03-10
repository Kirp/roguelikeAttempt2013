package ;

/**
 * ...
 * @author VGC
 */

class Enemy extends Hero
{
	
	public function new(x:Float, y:Float) 
	{
		super(x, y);
		setName("DudeBro");
		changeFace(2);
	}
	
}