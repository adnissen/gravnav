package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Andrew Nissen
	 */
	public class SetAndSettingsState extends FlxState
	{
		[Embed(source = "../gamebySets_NAV.png")] protected var SpriteLogo:Class;
		private var SSLogo:FlxSprite;
		public function SetAndSettingsState() 
		{
			
		}
		override public function create():void 
		{
			FlxG.flash(0x000000, 1.5);
			SSLogo = new FlxSprite(-30, 0, SpriteLogo);
			add(SSLogo);
		}
		private var delayCounter:int;
		override public function update():void 
		{
			delayCounter++;
			if (delayCounter >= 180)
			{
				fade();
			}
			super.update();
		}
		private function fade():void 
		{
			FlxG.fade(0x000000, 1.5, switchstate);
		}
		private function switchstate():void 
		{
			FlxG.switchState(new MenuState());
		}
		
	}

}