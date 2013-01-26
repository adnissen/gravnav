package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	public class Player extends FlxSprite
	{
		[Embed(source = "../player.png")] protected var IMGplayer:Class;
		[Embed(source = "../upTutorial.png")] protected var ZSprite:Class;
		[Embed(source = "../explode.mp3")] protected var explode:Class;
		[Embed(source = "../jetpack.mp3")] protected var jetpackSound:Class;
		
		private var zTutorial:FlxSprite;
		private var started:Boolean = false;
		public function Player(_x:Number, _y:Number) 
		{
			x = _x;
			y = _y;
			loadGraphic(IMGplayer, true, true, 12, 15);

			//set up the physics of the game
			height = 9;
			offset.y = 3
			maxVelocity.x = 50;
			maxVelocity.y = 350;


			addAnimation("up", [0, 1], 4);
			addAnimation("down", [2, 3], 4);

			
			zTutorial = new FlxSprite(x - 14, y - 50);
			zTutorial.loadGraphic(ZSprite, true, false, 37, 31);
			zTutorial.addAnimation("flash", [0, 1, 2], 6, true);
			zTutorial.play("flash");
			FlxG.state.add(zTutorial);
		}
		private var counter:int;
		private var ghostCounter:int;
		override public function update():void 
		{
			if (Registry.gameStarted == true)
			{
				//this is kind of cool I think, it just moves the tutorial sprite away when the game starts
				//I dunno I thought that was a nice touch
				zTutorial.x -= 1;
				if (zTutorial.x < -200)
					zTutorial.kill();
				counter++;

				//another neat touch, spawns a ghost sprite on a cooldown of about 8 frames
				ghostCounter++;
				if (ghostCounter >= 8)
				{
					FlxG.state.add(new GhostPlayer(x, y));
					ghostCounter = 0;
				}
			}
			if (FlxG.keys.Z || FlxG.keys.SPACE)
			{
				play("up");
				FlxG.play(jetpackSound, .02);
				Registry.gameStarted = true;
				if (started == false)
				{
					acceleration.y = 300;
					started = true;
				}
				velocity.y -= 10;
				if (counter >= 30)
				{
					counter = 0;
					FlxG.state.add(new Smoke(x - 10, y + 10));
				}
			}
			else 
				play("down");

			//if they fall off the screen
			if (y < -20 || y > FlxG.height + 4)
			{
				FlxG.play(explode);
				PlayState.theEmitter.x = x;
				PlayState.theEmitter.y = y;
				PlayState.theEmitter.setXSpeed( -40, 200);
				PlayState.theEmitter.setYSpeed( -175, -400);
				PlayState.theEmitter.start(true, 0, 0, 0);
				FlxG.flash(0x8DA2C5, 1);
				PlayState.grpCollide.kill();
				PlayState.grpBad.kill();
				FlxG.camera.angle = 0;
				PlayState.xRetry.visible = true;
				Registry.gameStarted = false;
				PlayState.arrow.kill();
				this.kill();
			}
			super.update();
		}
	}

}