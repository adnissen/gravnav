package
{

	import org.flixel.*;
	

	public class MenuState extends FlxState
	{
		
		private var playButton:FlxButton;
		private var devButton:FlxButton;
		private var Title:FlxText;
		
		private var buildings:FlxSprite;
		private var instructions:FlxSprite;
		private var credits:FlxSprite;
		private var zx:FlxSprite;
		[Embed(source = "../MenuFinal.png")] protected var IMGbg:Class;
		[Embed(source = "../Instructions.png")] protected var IMGInstructions:Class;
		[Embed(source = "../CreditScreen.png")] protected var IMGCredits:Class;
		[Embed(source = "../zxMenu.png")] protected var zxAnimated:Class;
		
		[Embed(source="../WhenMyStomachTurns.mp3")] protected var music:Class;
		[Embed(source = "../Stars1.png")] protected var stars1:Class;
		[Embed(source = "../Stars2.png")] protected var stars2:Class;
		[Embed(source = "../menuchange.mp3")] protected var change:Class;
		private var movingStars1:FlxSprite;
		private var movingStars1Backup:FlxSprite;
		private var movingStars2:FlxSprite;
		private var movingStars2Backup:FlxSprite;
		
		[Embed(source = "../InstructionArrow.png")] protected var arrowSprite:Class;
		private var arrow:FlxSprite;
		override public function create():void
		{
			FlxG.bgColor = 0xFF2F567C;
			movingStars1 = new FlxSprite(0, 0, stars1);
			add(movingStars1);
			movingStars1Backup = new FlxSprite(-240, 0, stars1);
			add(movingStars1Backup);
			movingStars2 = new FlxSprite(0, 0, stars2);
			add(movingStars2);
			movingStars2Backup = new FlxSprite(-240, 0, stars2);
			add(movingStars2Backup);
			
			zx = new FlxSprite(100.5, 180);
			zx.loadGraphic(zxAnimated, true, false, 39, 13);
			zx.addAnimation("flash", [0, 1], 4, true);
			zx.play("flash");
			add(zx);
			
			instructions = new FlxSprite(0, 0, IMGInstructions);
			instructions.visible = false;
			add(instructions);
			
			arrow = new FlxSprite(82, 149);
			arrow.loadGraphic(arrowSprite, true, false, 77, 66);
			arrow.addAnimation("flash", [0, 1, 2], 6, true);
			arrow.visible = false;
			arrow.play("flash");
			add(arrow);
			
			credits = new FlxSprite(0, 0, IMGCredits);
			credits.visible = false;
			add(credits);
			
			buildings = new FlxSprite(0,0,IMGbg);
			add(buildings);
			FlxG.playMusic(music);
		}
		
		override public function update():void
		{
			movingStars1.x += 1;
			if (movingStars1.x > 240)
				movingStars1.x = -240;
			movingStars1Backup.x += 1;
			if (movingStars1Backup.x > 240)
				movingStars1Backup.x = -240;
				
			movingStars2.x += .5;
			if (movingStars2.x > 240)
				movingStars2.x = -240;
			movingStars2Backup.x += .5;
			if (movingStars2Backup.x > 240)
				movingStars2Backup.x = -240;
				
			//menu switching things
			if (FlxG.keys.C)
			{
				FlxG.play(change);
				zx.x = 0;
				zx.y = 0;
				arrow.visible = false;
				credits.visible = true;
				buildings.visible = false;
				instructions.visible = false;
			}
			
			if (FlxG.keys.I)
			{
				FlxG.play(change);
				zx.x = 0;
				zx.y = 0;
				arrow.visible = true;
				credits.visible = false;
				buildings.visible = false;
				instructions.visible = true;
			}
			
			if (FlxG.keys.ESCAPE)
			{
				FlxG.play(change);
				zx.x = 100.5;
				zx.y = 180;
				arrow.visible = false;
				credits.visible = false;
				buildings.visible = true;
				instructions.visible = false;
			}
			
			if (FlxG.keys.justPressed("M") && buildings.visible == true)
			{
				FlxU.openURL("http://adnissen.com/");
			}
				
			if (FlxG.keys.Z)
			{
				if (FlxG.keys.X)
					FlxG.switchState(new PlayState);
			}
			
			else if (FlxG.keys.X)
			{
				if (FlxG.keys.Z)
					FlxG.switchState(new PlayState);
			}
			super.update();	
		}
		
		
		
	}
}

