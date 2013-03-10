package ;
import nme.geom.Point;
import nme.display.Sprite;
import nme.geom.Rectangle;
import nme.display.Tilesheet;
import nme.Assets;
/**
 * ...
 * @author VGC
 */

class TileSheetsGrid extends Sprite
{
	inline public static var TILE_HEIGHT = 16;
	inline public static var TILE_WIDTH = 16;
	inline public static var TILESHEET_WIDTH = 256;
	
	
	public var tileSheet:Tilesheet;
	public var rect:Rectangle;
	public var offSet:Point;
	

	public function new(gTile:Float) 
	{
		super();
		offSet = new Point();
		tileSheet = new Tilesheet(Assets.getBitmapData("img/curses_square_16x16.png"));
		for (i in 0... Std.int(gTile)+1)
		{
			offSet = computeGrid(i);
			rect = new Rectangle(offSet.x, offSet.y, TILE_WIDTH, TILE_HEIGHT);
			tileSheet.addTileRect(rect);
		}
		
		tileSheet.drawTiles(graphics, [0, 0, gTile]);
	}

	
	private function computeGrid(n:Float):Point
	{
		var XYCord:Point = new Point();
		var x:Float = 0;
		var y:Float = 0;
		var pos:Float = (n * TILE_WIDTH) / TILESHEET_WIDTH;
		var ceilinged = Math.ceil(pos);
		if (ceilinged == 1) 
		{
			x = (n-1) * TILE_WIDTH;
			y = 0;
		} else
		{
			var offsetx:Float = n - (TILE_WIDTH * (ceilinged - 1));
			x = (offsetx-1) * TILE_WIDTH;
			y = (ceilinged-1) * TILE_HEIGHT;
			
		}
		
		XYCord.x = x;
		XYCord.y = y;
		return XYCord;
	}
	
	public function changeTile(newTile:Float):Void
	{
		tileSheet.drawTiles(graphics, [0, 0, newTile]);
	}
}