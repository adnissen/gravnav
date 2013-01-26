package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	public class GameOver extends FlxState
	{
		
		public function GameOver() 
		{
			var TxtScore:FlxText = new FlxText(0, FlxG.height / 2, FlxG.width, "SCORE: " + Registry.score.toString());
			TxtScore.alignment = "center";
			add(TxtScore);
		}
		
		override public function update():void 
		{
			if (FlxG.keys.justPressed("X"))
			{
				Registry.score = 0;
				FlxG.switchState(new PlayState);
			}
		}
		
	}

}