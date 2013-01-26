package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	public class Smoke extends FlxSprite
	{
		[Embed(source = "../smoke.png")] protected var sprite:Class;
		public function Smoke(_x:int, _y:int) 
		{
			loadGraphic(sprite, false, false, 9, 9);
			x = _x;
			y = _y;
		}
		
		override public function update():void 
		{
			x -= .40;
			this.scale.x -= .009;
			this.scale.y -= .009;
			
			if (scale.x <= .1)
				this.kill();
		}
		
	}

}