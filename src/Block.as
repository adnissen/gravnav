package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	import org.flixel.*
	public class Block extends FlxSprite
	{
		[Embed(source = "../block.png")] protected var IMGbox:Class;
		private var right:Boolean = false;
		private var left:Boolean = false;
		public function Block(_x:int,_direction:int, _y:int) 
		{
			x = _x;
			if (_direction == 0)
			{
				//x = -50;
				left = true;
			}
			else
			{
				x = FlxG.width + 50;
				right = true;
			}
			
			y = _y;
			loadGraphic(IMGbox, false, false, 40, 40);
			PlayState.grpBad.add(this);
			PlayState.grpCollide.add(this);
		}
		override public function update():void 
		{
			if (x < -100)
			{
				//PlayState.grpBad.remove(this);
				this.kill();
			}
			if (right == true)
			{
				x += 1.5;
			}
			else
				x -= 1.5;
		}
		
	}

}