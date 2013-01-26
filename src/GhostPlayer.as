package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	public class GhostPlayer extends FlxSprite
	{
		[Embed(source = "../player.png")] protected var sprite:Class;
		public function GhostPlayer(_x:int, _y:int) 
		{
			x = _x;
			y = _y;
			loadGraphic(sprite, false, false, 12, 15);
			alpha = .3;
		}
		
		override public function update():void 
		{
			x -= 1;
			if (y < -20 || y > FlxG.height + 4)
			{
				this.kill();
			}
		}
		
	}

}