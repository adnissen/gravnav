package
{

	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public static var grpBad:FlxGroup;
		private var counter:int;
		private var txtScore:FlxText;
		private var waveCounter:int;
		public static var grpCollide:FlxGroup;
		private var player:Player;
		public static var arrow:FlxSprite;
		//[Embed(source = "../background.png")] protected var IMGbg:Class;
		[Embed(source = "../arrow.png")] protected var arrowSprite:Class;
		[Embed(source = "../BGStuff.png")] protected var bgStuff:Class;
		
		[Embed(source = "../Stars1.png")] protected var stars1:Class;
		[Embed(source = "../Stars2.png")] protected var stars2:Class;
		
		[Embed(source = "../xRetry.png")] protected var xRetrySprite:Class;
		public static var xRetry:FlxSprite;
		
		[Embed(source = "../explode.mp3")] protected var explode:Class;
		[Embed(source = "../select.mp3")] protected var select:Class;
		[Embed(source = "../gravswitch.mp3")] protected var gravSwitch:Class;
		
		private var movingStars1:FlxSprite;
		private var movingStars1Backup:FlxSprite;
		private var movingStars2:FlxSprite;
		private var movingStars2Backup:FlxSprite;
		
		
		//white pixel things
		public static var theEmitter:FlxEmitter;
		public static var whitePixel:FlxParticle;
		override public function create():void
		{
			FlxG.play(select);
			FlxG.bgColor = 0xFF2F567C;
			var bgstuff:FlxSprite = new FlxSprite(0, 0, bgStuff);
			//add(bgstuff);
			movingStars1 = new FlxSprite(0, 0, stars1);
			add(movingStars1);
			movingStars1Backup = new FlxSprite(-240, 0, stars1);
			add(movingStars1Backup);
			movingStars2 = new FlxSprite(0, 0, stars2);
			add(movingStars2);
			movingStars2Backup = new FlxSprite(-240, 0, stars2);
			add(movingStars2Backup);
			arrow = new FlxSprite(37.5, 23.5);
			arrow.loadGraphic(arrowSprite, true, false, 165, 193);
			arrow.visible = false;
			arrow.addAnimation("flash", [0, 1, 2], 6, true);
			arrow.play("flash");
			add(arrow);
			//Registry.gameStarted = true;
			grpBad = new FlxGroup();
			grpCollide = new FlxGroup();
			var bg:FlxSprite = new FlxSprite();
			
			txtScore = new FlxText(0, 30, FlxG.width, "");
			txtScore.alignment = "center";
			txtScore.size = 24;
			txtScore.color = 0xFFFFFF;
			add(txtScore);
			
			xRetry = new FlxSprite(37, (FlxG.height / 2) + 50);
			xRetry.loadGraphic(xRetrySprite, true, false, 166, 9);
			xRetry.addAnimation("flash", [0, 1], 4, true);
			xRetry.visible = false;
			xRetry.play("flash");
			add(xRetry);
			
			Registry.txtRegister = new FlxText(0, (FlxG.height / 2) + 75, FlxG.width, "(log into kongregate to save your high score!)");
			Registry.txtRegister.alignment = "center";
			Registry.txtRegister.size = 8;
			Registry.txtRegister.color = 0xFF0094;
			Registry.txtRegister.visible = false;
			//add(Registry.txtRegister);
			
			player = new Player(50 , 100);
			add(player);
			bg.play("idle");
			
			//particle effect things
			theEmitter = new FlxEmitter( -100, -100, 400);
			theEmitter.gravity = 300;
			add(theEmitter);
			for (var i:int = 0; i < theEmitter.maxSize/2; i++) {
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(2, 2, 0xFFFFFFFF);
				whitePixel.visible = false; //Make sure the particle doesn't show up at (0, 0)
				theEmitter.add(whitePixel);
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(1, 1, 0xFFFFFFFF);
				whitePixel.visible = false;
				theEmitter.add(whitePixel);
			}
		}
		private function gameOver(obj1:FlxObject, obj2:FlxObject):void 
		{
			FlxG.play(explode);
			theEmitter.x = player.x;
			theEmitter.y = player.y;
			theEmitter.setXSpeed( -300, 300);
			theEmitter.setYSpeed( -300, 300);
			theEmitter.start(true, 0, 0, 0);
			
			FlxG.flash(0x8DA2C5, 1);
			FlxG.camera.angle = 0;
			grpBad.kill();
			grpCollide.kill();
			xRetry.visible = true;
			Registry.gameStarted = false;
			obj1.kill();
			arrow.kill();
			
		}
		private var rotationCounter:int;
		private var angleCounter:int;
		private var arrowCounter:int;
		private var newAngle:int = (Math.round(FlxG.random() * 2) + 1) * 90;
		override public function update():void
		{
			if (Registry.gameStarted == true)
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
				Registry.waves = waveCounter;
				Registry.score++;
				counter++;
				
				angleCounter++;
				arrowCounter++;
				if (arrowCounter > 180)
				{
					arrowCounter = 0;
					arrow.visible = true;
					arrow.angle = newAngle - FlxG.camera.angle + 180;;
					trace("arrow angle: " + arrow.angle.toString());
					trace("upcoming screen angle: " + newAngle.toString());
				}
				if (angleCounter > 300)
				{
					FlxG.play(gravSwitch);
					arrowCounter = 0;
					angleCounter = 0;
					FlxG.camera.angle = newAngle;
					newAngle = (Math.round(FlxG.random() * 3) + 1) * 90;
					if (newAngle == FlxG.camera.angle)
					{
						newAngle += 90;
						if (newAngle > 360)
							newAngle = 90;
					}
					if (newAngle == 360)
					{
						newAngle = 0;
					}
					arrow.visible = false;
				}
			}
			else if (Registry.gameStarted == false)
			{
				if (FlxG.keys.X)
				{
					Registry.score = 0;
					FlxG.switchState(new PlayState);
				}
			}
			txtScore.text = Registry.score.toString();
			FlxG.overlap(player, grpCollide, gameOver);

			if (counter > 220)
			{
				counter = 0;
				for (var i:int = 0; i < 6; i++) 
				{
					add(new Badguy(FlxG.width + 50,0, i * 40));
					//add(new Badguy(-90,0, i * 40));
				}
				if (waveCounter <= 5)
				{
					grpBad.getRandom().kill();
					grpBad.getRandom().kill();
					grpBad.getRandom().kill();
				}
				else if (waveCounter > 5 && waveCounter <= 10)
				{
					grpBad.getRandom().kill();
					grpBad.getRandom().kill();
				}
				else 
				{
					grpBad.getRandom().kill();
				}
				grpBad.clear();
				waveCounter++;
			}
			
			super.update();
		}
	}
}

